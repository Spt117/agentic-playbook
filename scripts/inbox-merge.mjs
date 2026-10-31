#!/usr/bin/env node
// Exemple minimal de consolidation d'une inbox (voir docs/inbox-merge.md).
// Usage : node scripts/inbox-merge.mjs <tâche> [--apply]
// Dry-run par défaut : sans --apply, rien n'est écrit ni déplacé.
import { mkdirSync, readdirSync, readFileSync, renameSync, writeFileSync } from "node:fs";
import { join } from "node:path";

const task = process.argv[2];
const apply = process.argv.includes("--apply");
if (!task) {
  console.error("Usage : node scripts/inbox-merge.mjs <tâche> [--apply]");
  process.exit(1);
}

const inbox = join("inbox", task);
const done = join(inbox, "traites");
const output = join("output", `${task}.json`);

const files = readdirSync(inbox).filter((f) => f.endsWith(".json"));
const merged = [];
const rejected = [];

for (const f of files) {
  try {
    const item = JSON.parse(readFileSync(join(inbox, f), "utf8"));
    // Validation minimale : chaque artefact porte un identifiant stable.
    if (typeof item.id !== "string" || item.id === "") throw new Error("id manquant");
    merged.push(item);
  } catch (e) {
    rejected.push({ file: f, reason: String(e.message ?? e) });
  }
}

// Dédup par id : le dernier artefact gagne (ordre alphabétique = ordre d'horodatage).
const byId = new Map(merged.map((i) => [i.id, i]));
const result = [...byId.values()];

console.log(`${files.length} artefact(s), ${result.length} retenu(s), ${rejected.length} rejeté(s)`);
for (const r of rejected) console.log(`  rejeté ${r.file} : ${r.reason}`);

if (!apply) {
  console.log("Dry-run : relancer avec --apply pour écrire.");
  process.exit(0);
}

mkdirSync("output", { recursive: true });
mkdirSync(done, { recursive: true });
// Écriture en deux temps : fichier temporaire puis renommage atomique.
writeFileSync(`${output}.tmp`, JSON.stringify(result, null, 2));
renameSync(`${output}.tmp`, output);
for (const f of files) renameSync(join(inbox, f), join(done, f));
console.log(`Écrit : ${output}`);
