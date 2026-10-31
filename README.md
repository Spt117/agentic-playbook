# agentic-playbook

Comment je travaille avec des agents IA (Claude Code, Codex, Playwright) sur un parc de projets en production, seul, sans y laisser la qualité. Ce dépôt contient la méthode, génériquement : aucun code métier, aucune donnée.

*How I work with AI coding agents on production projects as a solo operator. Method only, no business code. Docs are in French; hooks and scripts are language-neutral.*

## Principes

1. **Le dépôt est la mémoire.** Un `CLAUDE.md` court sert d'index, un document par fonctionnalité porte le détail. Voir [`CLAUDE.template.md`](CLAUDE.template.md).
2. **Les plans vivent hors du code**, dans un vault Obsidian : notes à cases à cocher, le coché fait foi. Voir [`templates/plan.md`](templates/plan.md).
3. **Rigueur proportionnée au risque**, pas à la taille du diff. Voir [`docs/paliers.md`](docs/paliers.md).
4. **Rôles séparés** : qui orchestre, qui exécute, qui relit, qui teste. Voir [`docs/roles-agents.md`](docs/roles-agents.md).
5. **Ce qui doit être vrai se vérifie mécaniquement** : hooks, CI, post-processeurs, plutôt qu'une consigne de plus dans un prompt. Voir [`hooks/`](hooks/).
6. **Écritures concurrentes = inbox + merge.** Voir [`docs/inbox-merge.md`](docs/inbox-merge.md).

## Contenu

| Chemin | Rôle |
| --- | --- |
| `CLAUDE.template.md` | Squelette d'index de connaissance, avec plafond de taille |
| `docs/paliers.md` | Les trois paliers de rigueur et leurs exigences |
| `docs/roles-agents.md` | Orchestrateur, exécutant, relecteur, testeur, navigateur |
| `docs/inbox-merge.md` | Motif d'écriture parallèle sans conflit |
| `hooks/guard-commit-pathspec.sh` | Refuse un `git commit` sans pathspec |
| `hooks/guard-secrets-dir.sh` | Refuse l'accès d'un agent à un dossier de secrets |
| `scripts/inbox-merge.mjs` | Exemple minimal de consolidation d'une inbox |
| `templates/plan.md` | Modèle de plan à cases pour le vault |

## Licence

MIT.
