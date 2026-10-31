# Trois paliers de rigueur

La rigueur se règle sur **la portée, la réversibilité et l'impact maximal** du changement, jamais sur sa seule taille. Le palier est annoncé en une phrase au début de la tâche (« palier 2 parce que… ») et peut être requalifié. Dans le doute, on prend le palier le plus haut.

| Palier | Périmètre | Exigences |
| --- | --- | --- |
| **1. Correctif trivial** | Quelques lignes, cause connue, effet localisé et réversible, aucun contrat, schéma ni donnée touché | Vérification ciblée du comportement attendu, par l'exécutant. Pas de relecture ni de plan |
| **2. Changement moyen** | Une fonctionnalité bornée : module, route, tâche planifiée | Tests unitaires, intégration si une chaîne réelle est touchée (seules les dépendances externes sont simulées). Une relecture fraîche, deux tours au plus |
| **3. Chantier sensible** | Paiement, prix, stock, authentification, secrets, migration, données clients, écriture vers un tiers, déploiement, multi-services | Plan écrit et relu, décisions tranchées avant le lancement, tests par un agent distinct de l'exécutant, relecture du code, vérification visuelle sur l'URL réelle |

## Règles communes

- Le rédacteur de tests reçoit le comportement **attendu** et le diff, jamais « fais passer au vert ».
- Un test rouge se corrige, il ne se supprime ni ne s'assouplit.
- Un niveau de vérification non applicable **se dit**, il ne s'omet pas.
- Un relecteur liste les **axes examinés** ; on relance seulement sur un axe absent.
- **Bloquant** = impact réel (perte de données, faille, régression visible) avec scénario étayé. On ne livre pas tant qu'un bloquant est ouvert.
- Un revert garde la vérification de son palier.

## Garde-fous indépendants du palier

Secrets hors de portée des agents, commits ciblés, CI verte avant de conclure, migrations destructives sur accord explicite, courriers rédigés en brouillon et jamais envoyés directement. Alléger un palier n'allège jamais cette liste.
