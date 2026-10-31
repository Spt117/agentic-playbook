# Inbox + merge

**Problème** : plusieurs agents ou workflows écrivent en parallèle dans un fichier ou des enregistrements partagés. Résultat : écrasements silencieux et conflits.

**Motif** :

1. Chaque agent dépose **un artefact atomique** (un fichier JSON par résultat) dans `inbox/<tâche>/`. Il n'édite jamais un fichier partagé.
2. Le nom du fichier est unique (identifiant de l'élément + horodatage), l'écriture se fait en deux temps (fichier temporaire puis renommage) pour qu'un lecteur ne voie jamais un fichier à moitié écrit.
3. **Un seul script** consolide : il lit l'inbox, valide chaque artefact, écrit le résultat consolidé, puis déplace les artefacts traités vers `inbox/<tâche>/traites/`.
4. Le script est **idempotent** et en dry-run par défaut.

Le même principe vaut pour le code : deux sessions en parallèle travaillent dans des worktrees séparés, avec des `git add` ciblés et des commits avec pathspec.

Voir un exemple minimal dans [`scripts/inbox-merge.mjs`](../scripts/inbox-merge.mjs).
