# CLAUDE.md : index du workspace

Lu automatiquement par l'agent à l'ouverture d'une session.

> **Plafond : ce fichier reste sous 100 000 caractères.** Contrôle : `wc -c CLAUDE.md`.
> Une ligne de catalogue = *quoi* + *quand le lire*. Un piège technique va dans le bloc « À savoir » du document concerné, jamais ici.

## 0. Règles générales

- **Langue** : <à fixer>.
- **Préséance en cas de conflit** : 1) consigne explicite de la session, 2) mémoire de l'agent, 3) ce fichier, 4) `docs/*.md` pour le « comment » technique.

### NEVER (sauf validation explicite)

1. Considérer un push comme terminé avant que la CI pertinente soit verte.
2. Lancer une migration destructive sans accord explicite.
3. <vos interdits métier, chacun avec son motif daté>

### ALWAYS

1. Scripts : **dry-run par défaut**, `--apply` pour écrire, relecture d'un échantillon après.
2. Plusieurs sessions en parallèle : worktrees isolés, `git add` fichier par fichier, `git commit -- <chemins>`.
3. Todo, plan, roadmap : dans le vault, jamais dans le dépôt.
4. Une contrainte de format récurrente = consigne **et** post-processeur mécanique.
5. Le palier de rigueur est annoncé en une phrase au début de la tâche (voir `docs/paliers.md`).

## 1. Maintenir cette documentation

À mettre à jour : nouvelle fonctionnalité, convention découverte, nouvelle structure de données, workflow modifié (avant le commit). Pas pour un correctif trivial.

## 2. Catalogue des documents

| Document | Quoi / quand le lire |
| --- | --- |
| `docs/<fonctionnalité>.md` | <une ligne> |
