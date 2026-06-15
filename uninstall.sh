#!/usr/bin/env bash
#
# Shahid Video SkillSet (/svs) — uninstaller
# Removes the `svs` skill from every agent location. Your ~/.svs profile and any
# in-project ./.svs/ memory are LEFT IN PLACE by default (pass --purge to also
# remove the global ~/.svs profile).
#
# Usage:  bash uninstall.sh [--purge]
#
set -euo pipefail

SKILL_NAME="svs"
PURGE=0
[ "${1:-}" = "--purge" ] && PURGE=1

b() { printf "\033[1m%s\033[0m\n" "$1"; }
ok() { printf "  \033[32m✓\033[0m %s\n" "$1"; }
skip() { printf "  \033[33m•\033[0m %s\n" "$1"; }

b ""
b "🧹  Shahid Video SkillSet — uninstalling /svs"
b ""

TARGETS=(
  "Claude Code|${HOME}/.claude/skills"
  "Antigravity|${HOME}/.gemini/antigravity/skills"
  "Gemini CLI|${HOME}/.gemini/skills"
  "Codex|${HOME}/.codex/skills"
  "Generic agents|${HOME}/.agents/skills"
)

removed=0
for entry in "${TARGETS[@]}"; do
  label="${entry%%|*}"
  base="${entry##*|}"
  dest="${base}/${SKILL_NAME}"
  if [ -d "${dest}" ]; then
    rm -rf "${dest}"
    ok "Removed ${label}  (${dest})"
    removed=$((removed + 1))
  else
    skip "${label} — not installed"
  fi
done

if [ "${PURGE}" -eq 1 ]; then
  if [ -d "${HOME}/.svs" ]; then
    rm -rf "${HOME}/.svs"
    ok "Purged global profile ~/.svs"
  fi
else
  skip "Kept global profile ~/.svs (use --purge to remove it)"
fi

b ""
b "✅  Removed /svs from ${removed} location(s)."
b ""
