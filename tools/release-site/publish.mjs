// Publishes a release to the site <3
// Usage: node publish.mjs <x.y.z> <dir> [--dry-run]
import { readdir, stat, mkdtemp } from "node:fs/promises";
import { execFileSync } from "node:child_process";
import { tmpdir } from "node:os";
import { join, dirname } from "node:path";
import { fileURLToPath } from "node:url";
import { Client, Storage, Sites, Waf, Query, AppwriteException } from "node-appwrite";
import { InputFile } from "node-appwrite/file";

const ENDPOINT = process.env.APPWRITE_ENDPOINT ?? "https://syd.cloud.appwrite.io/v1";
const PROJECT = process.env.APPWRITE_PROJECT ?? "atomix-api";
const BUCKET = process.env.RELEASES_BUCKET ?? "rl-mobile-releases";
const SITE = process.env.RELEASES_SITE ?? "rl-mobile-releases";
const FORCE = process.env.RELEASES_FORCE === "true";

const args = process.argv.slice(2);
const dryRun = args.includes("--dry-run");
const [version, assetsDir] = args.filter((a) => !a.startsWith("--"));
if (!/^\d+\.\d+\.\d+$/.test(version ?? "") || !assetsDir) {
	console.error("usage: node publish.mjs <x.y.z> <assetsDir> [--dry-run]");
	process.exit(2);
}

// 2.1.0 -> 2-1-0 (site path)
const dirOf = (v) => v.replaceAll(".", "-");
const FILE_ID = /^(\d+)-(\d+)-(\d+)\.([A-Za-z0-9._-]+)$/;
const dir = dirOf(version);

const client = new Client().setEndpoint(ENDPOINT).setProject(PROJECT);
if (!dryRun) {
	if (!process.env.APPWRITE_KEY) throw new Error("APPWRITE_KEY is not set");
	client.setKey(process.env.APPWRITE_KEY);
}
const storage = new Storage(client);
const sites = new Sites(client);
const waf = new Waf(client);

const notFound = (e) => e instanceof AppwriteException && e.code === 404;

async function listAll() {
	const files = [];
	let cursor;
	for (;;) {
		const queries = [Query.limit(100)];
		if (cursor) queries.push(Query.cursorAfter(cursor));
		const page = await storage.listFiles({ bucketId: BUCKET, queries });
		files.push(...page.files);
		if (page.files.length < 100) return files;
		cursor = page.files.at(-1).$id;
	}
}

// Highest version in the bucket + its files
function latestOf(files) {
	const versions = new Map();
	for (const f of files) {
		const m = FILE_ID.exec(f.$id);
		if (!m) continue;
		const key = m.slice(1, 4).join("-");
		if (!versions.has(key)) versions.set(key, { parts: m.slice(1, 4).map(Number), dir: key, names: new Set() });
		versions.get(key).names.add(m[4]);
	}
	return [...versions.values()].sort(
		(a, b) => b.parts[0] - a.parts[0] || b.parts[1] - a.parts[1] || b.parts[2] - a.parts[2],
	)[0];
}

const assets = [];
for (const name of (await readdir(assetsDir)).sort()) {
	const path = join(assetsDir, name);
	if (!(await stat(path)).isFile()) continue;
	const id = `${dir}.${name}`;
	if (!FILE_ID.test(id) || id.length > 36) throw new Error(`Bad asset name for a file ID: ${name}`);
	assets.push({ name, path, id, size: (await stat(path)).size });
}
for (const required of ["manager.apk", "patches.zip", "data.json"]) {
	if (!assets.some((a) => a.name === required)) throw new Error(`${assetsDir} has no ${required}`);
}
console.log(`Publishing ${version} to /${dir}/: ${assets.map((a) => `${a.name} (${a.size} bytes)`).join(", ")}`);

// No overwriting unless forced (bump .version!)
const existing = (await listAll()).filter((f) => f.$id.startsWith(`${dir}.`));
if (existing.length > 0) {
	if (!FORCE) {
		throw new Error(
			`${version} is already published (${existing.map((f) => f.$id).join(", ")}). ` +
				"Bump .version, or set the RELEASES_FORCE repo variable to true to replace it.",
		);
	}
	console.log(`RELEASES_FORCE set, replacing ${existing.length} existing file(s)`);
	for (const f of existing) {
		if (dryRun) console.log(`[dry-run] would delete ${f.$id}`);
		else await storage.deleteFile({ bucketId: BUCKET, fileId: f.$id });
	}
}

for (const a of assets) {
	if (dryRun) {
		console.log(`[dry-run] would upload ${a.id}`);
		continue;
	}
	// SDK chunks anything over 5MB
	const file = await storage.createFile({
		bucketId: BUCKET,
		fileId: a.id,
		file: InputFile.fromPath(a.path, a.name),
		folder: dir,
	});
	if (file.sizeOriginal !== a.size) throw new Error(`${a.id} uploaded ${file.sizeOriginal} of ${a.size} bytes`);
	console.log(`Uploaded ${a.id}`);
}

// Site source is just build.mjs
const siteDir = join(dirname(fileURLToPath(import.meta.url)), "site");
const tarball = join(await mkdtemp(join(tmpdir(), "rl-site-")), "code.tar.gz");
execFileSync("tar", ["-czf", tarball, "-C", siteDir, "."]);

if (dryRun) {
	console.log(`[dry-run] would deploy ${tarball} to site ${SITE}`);
} else {
	const deployment = await sites.createDeployment({
		siteId: SITE,
		code: InputFile.fromPath(tarball, "code.tar.gz"),
		buildCommand: "node build.mjs",
		outputDirectory: "./dist",
		activate: true,
	});
	console.log(`Deployment ${deployment.$id} created`);

	for (let i = 0; ; i++) {
		const { status, buildLogs } = await sites.getDeployment({ siteId: SITE, deploymentId: deployment.$id });
		console.log(`Status: ${status}`);
		if (status === "ready") break;
		if (status === "failed" || status === "canceled" || i >= 120) {
			console.log(buildLogs);
			throw new Error(`Deployment ${deployment.$id} ${i >= 120 ? "timed out" : status}`);
		}
		await new Promise((r) => setTimeout(r, 5000));
	}
}

// Site serves /latest itself, WAF redirects are broken
const latest = latestOf(dryRun ? [...(await listAll()), ...assets.map((a) => ({ $id: a.id }))] : await listAll());
for (const name of ["data.json", "manager.apk", "patches.zip"]) {
	const ruleId = `rlm-latest-${name}`;
	if (dryRun) {
		console.log(`[dry-run] would remove ${ruleId} if present`);
		continue;
	}
	try {
		await waf.deleteRule({ ruleId });
		console.log(`Removed old redirect ${ruleId}`);
	} catch (e) {
		if (!notFound(e)) throw e;
	}
}

console.log(`Done: ${version} published, latest is ${latest.dir.replaceAll("-", ".")}`);
