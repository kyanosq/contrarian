#!/usr/bin/env sh
set -eu

ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
TARGETS=${AGENT_SKILL_TARGETS:-"$HOME/.codex/skills:$HOME/.cursor/skills"}

OLD_IFS=$IFS
IFS=:
set -- $TARGETS
IFS=$OLD_IFS

for target in "$@"; do
  mkdir -p "$target"
  for skill in "$ROOT"/skills/*; do
    [ -d "$skill" ] || continue
    name=$(basename "$skill")
    rm -rf "$target/$name"
    ln -s "$skill" "$target/$name"
    printf 'linked %s -> %s\n' "$target/$name" "$skill"
  done
done
