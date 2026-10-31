#!/usr/bin/env bash
# Hook PreToolUse (matcher: Bash) pour Claude Code.
# Refuse un `git commit` sans pathspec : sans lui, le commit embarque tout l'index,
# y compris ce qu'une autre session y a déjà stagé.
# Entrée : le JSON de l'appel d'outil sur stdin. Sortie 2 = appel refusé, stderr renvoyé à l'agent.
set -u

input="$(cat)"

# Extrait la commande sans dépendre de jq.
cmd="$(printf '%s' "$input" | sed -n 's/.*"command"[[:space:]]*:[[:space:]]*"\(.*\)".*/\1/p' | head -n1)"

# Ne concerne que les commits.
case "$cmd" in
  *"git commit"*) ;;
  *) exit 0 ;;
esac

# Forme exigée : `git commit ... -- <chemin> [<chemin>...]`
if printf '%s' "$cmd" | grep -Eq 'git commit.*[[:space:]]--[[:space:]]+[^[:space:]]'; then
  exit 0
fi

echo "Refusé : committe avec un pathspec, 'git commit -F - -- <chemin1> <chemin2>'." >&2
echo "Vérifie aussi 'git diff --cached --name-only' si l'index est partagé." >&2
exit 2
