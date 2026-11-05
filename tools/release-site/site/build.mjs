// Builds the site from the bucket <3
import { mkdir, writeFile, rm, stat, copyFile } from "node:fs/promises";
import { createWriteStream } from "node:fs";
import { Readable } from "node:stream";
import { pipeline } from "node:stream/promises";
import { join } from "node:path";

const ENDPOINT = process.env.RELEASES_ENDPOINT ?? "https://syd.cloud.appwrite.io/v1";
const PROJECT = process.env.RELEASES_PROJECT ?? "atomix-api";
const BUCKET = process.env.RELEASES_BUCKET ?? "rl-mobile-releases";
const OUT = process.argv[2] ?? "dist";

// File IDs look like 2-1-0.manager.apk
const FILE_ID = /^(\d+)-(\d+)-(\d+)\.([A-Za-z0-9._-]+)$/;

async function listFiles() {
	const files = [];
	let cursor = null;
	for (;;) {
		const queries = [{ method: "limit", values: [100] }];
		if (cursor) queries.push({ method: "cursorAfter", values: [cursor] });
		const url = new URL(`${ENDPOINT}/storage/buckets/${BUCKET}/files`);
		for (const q of queries) url.searchParams.append("queries[]", JSON.stringify(q));

		const res = await fetch(url, { headers: { "X-Appwrite-Project": PROJECT } });
		if (!res.ok) throw new Error(`List failed: ${res.status} ${await res.text()}`);
		const page = (await res.json()).files;
		files.push(...page);
		if (page.length < 100) return files;
		cursor = page.at(-1).$id;
	}
}

async function download(file, dest) {
	const url = `${ENDPOINT}/storage/buckets/${BUCKET}/files/${encodeURIComponent(file.$id)}/download?project=${PROJECT}`;
	for (let attempt = 1; ; attempt++) {
		try {
			const res = await fetch(url);
			if (!res.ok) throw new Error(`${res.status}`);
			await pipeline(Readable.fromWeb(res.body), createWriteStream(dest));
			return;
		} catch (e) {
			if (attempt >= 3) throw new Error(`Download of ${file.$id} failed: ${e.message}`);
		}
	}
}

const byVersion = (a, b) => b.parts[0] - a.parts[0] || b.parts[1] - a.parts[1] || b.parts[2] - a.parts[2];

const files = await listFiles();
const versions = new Map();
for (const file of files) {
	const m = FILE_ID.exec(file.$id);
	if (!m) {
		console.warn(`Skipping ${file.$id}, not <x-y-z>.<name>`);
		continue;
	}
	const parts = m.slice(1, 4).map(Number);
	const dir = parts.join("-");
	if (!versions.has(dir)) versions.set(dir, { version: parts.join("."), dir, parts, files: [] });
	versions.get(dir).files.push({ name: m[4], file });
}

const sorted = [...versions.values()].sort(byVersion);
if (sorted.length === 0) throw new Error("Bucket has no releases");

await rm(OUT, { recursive: true, force: true });

// 4 at a time, don't hammer storage
const jobs = sorted.flatMap((v) => v.files.map((f) => ({ v, f })));
let next = 0;
async function worker() {
	while (next < jobs.length) {
		const { v, f } = jobs[next++];
		const dest = join(OUT, v.dir, f.name);
		await mkdir(join(OUT, v.dir), { recursive: true });
		await download(f.file, dest);
		console.log(`${v.dir}/${f.name} (${f.file.sizeOriginal} bytes)`);
	}
}
await Promise.all(Array.from({ length: 4 }, worker));

// Catch truncated downloads before they go live
for (const { v, f } of jobs) {
	const size = (await stat(join(OUT, v.dir, f.name))).size;
	if (size !== f.file.sizeOriginal) throw new Error(`${v.dir}/${f.name} is ${size} bytes, expected ${f.file.sizeOriginal}`);
}

// /latest is a copy, WAF redirects 500
await mkdir(join(OUT, "latest"), { recursive: true });
for (const f of sorted[0].files) {
	await copyFile(join(OUT, sorted[0].dir, f.name), join(OUT, "latest", f.name));
	console.log(`latest/${f.name} = ${sorted[0].dir}/${f.name}`);
}

const manifest = {
	latest: sorted[0].version,
	versions: sorted.map((v) => ({
		version: v.version,
		path: `/${v.dir}/`,
		files: v.files.map((f) => f.name).sort(),
		date: v.files.map((f) => f.file.$createdAt).sort()[0],
	})),
};
await writeFile(join(OUT, "versions.json"), JSON.stringify(manifest, null, "\t") + "\n");

const esc = (s) => s.replace(/[&<>"]/g, (c) => `&#${c.charCodeAt(0)};`);
const rows = manifest.versions
	.map((v) => `<li><b>${esc(v.version)}</b> ${v.files.map((f) => `<a href="${esc(v.path + f)}">${esc(f)}</a>`).join(" · ")}</li>`)
	.join("\n");
await writeFile(
	join(OUT, "index.html"),
	`<!doctype html>
<html lang="en">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Radiant Lyrics Mobile Releases</title>
<style>body{font:16px/1.6 system-ui,sans-serif;max-width:46rem;margin:3rem auto;padding:0 1rem;background:#111;color:#eee}a{color:#f7a8c8}li{margin:.3rem 0}</style>
<h1>Radiant Lyrics Mobile Releases</h1>
<p><a href="/latest/manager.apk">Download the latest Manager (${esc(manifest.latest)})</a></p>
<ul>
${rows}
</ul>
</html>
`,
);

console.log(`Built ${sorted.length} release(s), latest ${manifest.latest}`);
