// contributors.json from full git history <3
// Usage: node contributors.mjs <dir> <x.y.z>
import { execFileSync } from "node:child_process";
import { createHash } from "node:crypto";
import { existsSync, readFileSync } from "node:fs";
import { writeFile } from "node:fs/promises";
import { join } from "node:path";

const GITCAFE = "https://git.cafe";
const SITE = process.env.RELEASES_URL ?? "https://mobile.release.radiant-lyrics.org";
const [outDir, version] = process.argv.slice(2);
if (!outDir || !/^\d+\.\d+\.\d+$/.test(version ?? "")) {
	console.error("usage: node contributors.mjs <assetsDir> <x.y.z>");
	process.exit(2);
}
const dir = version.replaceAll(".", "-");

const log = execFileSync("git", ["log", "--no-merges", "--format=%aN%x00%aE"], { encoding: "utf8", maxBuffer: 64 << 20 });
// Reused runners keep stale shallow marks, HEAD's fine
const shallowFile = execFileSync("git", ["rev-parse", "--git-path", "shallow"], { encoding: "utf8" }).trim();
const cut = (existsSync(shallowFile) ? readFileSync(shallowFile, "utf8") : "").split("\n").filter(Boolean).filter((sha) => {
	try {
		execFileSync("git", ["merge-base", "--is-ancestor", sha, "HEAD"], { stdio: "ignore" });
		return true;
	} catch {
		return false;
	}
});
if (cut.length > 0) throw new Error(`History is cut at ${cut.join(", ")}, checkout with fetch-depth: 0`);

// Count per name + email
const pairs = new Map();
for (const line of log.split("\n")) {
	if (!line) continue;
	const [name, email] = line.split("\0");
	const key = `${name}\0${email.toLowerCase()}`;
	pairs.set(key, (pairs.get(key) ?? 0) + 1);
}

// Names sharing an email are one person
const parent = new Map();
const find = (x) => (parent.get(x) === x ? x : (parent.set(x, find(parent.get(x))), parent.get(x)));
const union = (a, b) => parent.set(find(a), find(b));
const byEmail = new Map();
for (const key of pairs.keys()) {
	const [name, email] = key.split("\0");
	if (!parent.has(name)) parent.set(name, name);
	if (byEmail.has(email)) union(name, byEmail.get(email));
	else byEmail.set(email, name);
}

async function gitcafeUser(name) {
	const res = await fetch(`${GITCAFE}/api/users/?q=${encodeURIComponent(name)}&limit=10`);
	if (!res.ok) return null;
	const want = name.toLowerCase();
	return (await res.json()).items.find((u) => u.handle === want || u.displayName?.toLowerCase() === want) ?? null;
}

// Gravatar 403s Android, so we host it
async function gravatar(email, slug) {
	const hash = createHash("sha256").update(email.trim().toLowerCase()).digest("hex");
	const res = await fetch(`https://gravatar.com/avatar/${hash}?d=404&s=128`);
	if (!res.ok) return null;
	const ext = res.headers.get("content-type")?.includes("png") ? "png" : "jpg";
	const name = `avatar-${slug}.${ext}`;
	await writeFile(join(outDir, name), Buffer.from(await res.arrayBuffer()));
	return `${SITE}/${dir}/${name}`;
}

const slugOf = (name) => name.toLowerCase().replace(/[^a-z0-9]+/g, "-").replace(/^-|-$/g, "").slice(0, 20) || "user";

const groups = new Map();
for (const [key, count] of pairs) {
	const [name, email] = key.split("\0");
	const root = find(name);
	if (!groups.has(root)) groups.set(root, { names: new Map(), emails: new Set(), commits: 0 });
	const g = groups.get(root);
	g.names.set(name, (g.names.get(name) ?? 0) + count);
	g.emails.add(email);
	g.commits += count;
}

const contributors = [];
for (const g of groups.values()) {
	const names = [...g.names.entries()].sort((a, b) => b[1] - a[1]).map(([n]) => n);
	let user = null;
	for (const n of names) if ((user = await gitcafeUser(n))) break;

	let avatarUrl = user?.avatarUrl ? GITCAFE + user.avatarUrl : null;
	for (const e of g.emails) if (!avatarUrl) avatarUrl = await gravatar(e, slugOf(user?.handle ?? names[0]));

	contributors.push({
		username: user?.handle ?? names[0],
		avatarUrl,
		url: user ? `${GITCAFE}/${user.handle}` : null,
		commits: g.commits,
		aliases: [...new Set([...names, ...(user ? [user.handle, user.displayName] : [])].filter(Boolean))],
		repositories: [],
	});
}
contributors.sort((a, b) => b.commits - a.commits);

await writeFile(join(outDir, "contributors.json"), JSON.stringify(contributors, null, "\t") + "\n");
for (const c of contributors) console.log(`${c.username}: ${c.commits} commits, avatar ${c.avatarUrl ? "yes" : "no"}`);
