#!/usr/bin/env bash
#
# Shahid Video SkillSet (/svs) — uninstaller
# Removes /svs from every agent location (skill folders + Cursor/Windsurf/Cline rule files).
# The global ~/.svs profile and any in-project ./.svs/ memory are kept unless you pass --purge.
#
# Usage:  bash uninstall.sh [--purge]
#
set -euo pipefail

SKILL_NAME="svs"
PURGE=0
[ "${1:-}" = "--purge" ] && PURGE=1

b()    { printf "\033[1m%s\033[0m\n" "$1"; }
ok()   { printf "  \033[32m✓\033[0m %s\n" "$1"; }
skip() { printf "  \033[33m•\033[0m %s\n" "$1"; }

b ""
b "🧹  Shahid Video SkillSet — uninstalling /svs"
b ""

# KEY | Label | kind | path   (must match install.sh)
AGENTS=(
  "claude|Claude Code|folder|${HOME}/.claude/skills"
  "gemini|Gemini CLI|folder|${HOME}/.gemini/skills"
  "antigravity|Antigravity|folder|${HOME}/.gemini/antigravity/skills"
  "codex|Codex CLI|folder|${HOME}/.codex/skills"
  "opencode|OpenCode|folder|${HOME}/.config/opencode/skills"
  "aider|Aider|folder|${HOME}/.aider/skills"
  "continue|Continue|folder|${HOME}/.continue/skills"
  "agents|Generic (~/.agents)|folder|${HOME}/.agents/skills"
  "cursor|Cursor|mdc|${HOME}/.cursor/rules/svs.mdc"
  "windsurf|Windsurf|rulefile|${HOME}/.codeium/windsurf/global-rules/svs.md"
  "cline|Cline / Roo (VS Code)|rulefile|${HOME}/.clinerules/svs.md"
)

removed=0
for entry in "${AGENTS[@]}"; do
  IFS='|' read -r key label kind path <<< "$entry"
  case "$kind" in
    folder) target="${path}/${SKILL_NAME}" ;;
    *)      target="$path" ;;
  esac
  if [ -e "$target" ]; then
    rm -rf "$target"
    ok "Removed ${label}  (${target})"
    removed=$((removed + 1))
  else
    skip "${label} — not installed"
  fi
done

if [ "${PURGE}" -eq 1 ]; then
  [ -d "${HOME}/.svs" ] && rm -rf "${HOME}/.svs" && ok "Purged global profile ~/.svs"
else
  skip "Kept global profile ~/.svs (use --purge to remove it)"
fi

b ""
b "✅  Removed /svs from ${removed} location(s)."
b ""
