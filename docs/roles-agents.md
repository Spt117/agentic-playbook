# Rôles des agents

Un agent qui a écrit le code est le moins bien placé pour le juger. On sépare donc les rôles.

| Rôle | Outil type | Reçoit | Rend |
| --- | --- | --- | --- |
| **Orchestrateur** | Claude Code (modèle le plus capable) | L'objectif, le palier | Un plan ou un brief fermé, puis un contrôle des comptes rendus |
| **Exécutant** | Claude Code (modèle intermédiaire) | Un brief fermé (palier 2) ou le chemin d'un plan (palier 3) | Le code, les contrôles lancés, ce qui change un contrat ou un risque |
| **Rédacteur de tests** | Agent distinct de l'exécutant (palier 3) | Le comportement attendu et le diff | Les tests |
| **Relecteur** | Second fournisseur d'IA (Codex CLI) | Diff + intention en une phrase + critères | Findings et liste des axes examinés |
| **Vérificateur visuel** | Playwright, piloté par un agent léger | URL réelle, viewports desktop et mobile | Constat, onglets fermés |

## Principes

- L'orchestrateur **contrôle des comptes rendus**, il ne relit pas le code. Le diff n'est ouvert qu'à l'endroit qu'un finding désigne.
- Un exécutant choisit librement l'implémentation **dans le périmètre fixé** et ne remonte que ce qui change un contrat, un risque ou l'objectif.
- Les corrections vont au **même** exécutant ; la relecture est bornée en tours.
- Chantiers parallèles : périmètres disjoints (worktrees). Un exécutant ne redélègue pas.
- Tout appel au second fournisseur passe par une file machine (créneaux, pause partagée en cas de limite de débit, reprise des workflows interrompus), jamais en direct.
- On contrôle le modèle réellement utilisé dans la sortie de l'outil, jamais par ce que le modèle dit de lui-même.
