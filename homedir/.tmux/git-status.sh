#!/usr/bin/env bash
# Print the git branch of $1 with a dirty marker, or nothing outside a repo.
# Called from .tmux.conf on every status refresh, so it stays cheap and silent.

cd "${1:-$PWD}" 2>/dev/null || exit 0
git rev-parse --is-inside-work-tree >/dev/null 2>&1 || exit 0

branch=$(git symbolic-ref --quiet --short HEAD 2>/dev/null) ||
  branch=$(git rev-parse --short HEAD 2>/dev/null) ||
  exit 0

dirty=
git diff --quiet --ignore-submodules HEAD 2>/dev/null || dirty='*'
[ -z "$(git ls-files --others --exclude-standard 2>/dev/null | head -1)" ] || dirty='*'

printf '%s%s' "$branch" "$dirty"
