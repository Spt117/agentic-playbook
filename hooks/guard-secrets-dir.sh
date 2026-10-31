#!/usr/bin/env bash
# Hook PreToolUse (matcher: Read|Bash|Grep|Glob) pour Claude Code.
# Un agent ne lit jamais le dossier de secrets : il passe par un lanceur dédié
# (un script existant, la valeur arrive dans une variable d'environnement et n'est pas affichée).
# Liste blanche fermée : tout ce qui touche le dossier est refusé, sauf la forme exacte du lanceur.
set -u

SECRETS_DIR="${SECRETS_DIR:-secrets-private}"
LAUNCHER="${LAUNCHER:-tools/with-secret.sh}"

input="$(cat)"

# Rien ne mentionne le dossier : on laisse passer.
printf '%s' "$input" | grep -q "$SECRETS_DIR" || exit 0

# Seule forme autorisée : le lanceur, suivi d'un script (pas de commande libre).
if printf '%s' "$input" | grep -Eq "\"command\"[[:space:]]*:[[:space:]]*\"$LAUNCHER $SECRETS_DIR/[A-Za-z0-9._-]+ [A-Z0-9_]+ -- [^;&|<>\`$]+\"" ; then
  exit 0
fi

echo "Refusé : le dossier $SECRETS_DIR n'est pas lisible par un agent." >&2
echo "Utilise : $LAUNCHER $SECRETS_DIR/<fichier> <CLÉ> -- <script> [args]" >&2
exit 2
