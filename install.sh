#!/usr/bin/env bash
#
# Shahid Video SkillSet (/svs) — global multi-agent installer
# Installs the `svs` Video Director skill into Claude Code, Antigravity, Gemini CLI,
# Codex, and any generic ~/.agents skill host found on this machine.
#
# Usage:  bash install.sh
#
set -euo pipefail

SKILL_NAME="svs"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC_DIR="${SCRIPT_DIR}/skills/${SKILL_NAME}"

# --- pretty output -----------------------------------------------------------
b() { printf "\033[1m%s\033[0m\n" "$1"; }
ok() { printf "  \033[32m✓\033[0m %s\n" "$1"; }
skip() { printf "  \033[33m•\033[0m %s\n" "$1"; }

b ""
b "🎬  Shahid Video SkillSet — installing /svs"
b "    World-Class AI Video Director & Remotion Expert"
b ""

# --- sanity check ------------------------------------------------------------
if [ ! -f "${SRC_DIR}/SKILL.md" ]; then
  printf "\033[31m✗ Could not find skills/%s/SKILL.md next to this script.\033[0m\n" "${SKILL_NAME}"
  printf "  Run this from inside the cloned Shahid-Video-SkillSet repo.\n"
  exit 1
fi

# --- target agent skill directories -----------------------------------------
# Each entry: "Agent Label|~/path/to/global/skills"
TARGETS=(
  "Claude Code|${HOME}/.claude/skills"
  "Antigravity|${HOME}/.gemini/antigravity/skills"
  "Gemini CLI|${HOME}/.gemini/skills"
  "Codex|${HOME}/.codex/skills"
  "Generic agents|${HOME}/.agents/skills"
)

installed=0
for entry in "${TARGETS[@]}"; do
  label="${entry%%|*}"
  base="${entry##*|}"
  dest="${base}/${SKILL_NAME}"

  # Install for every agent so /svs is available everywhere (create dirs as needed).
  mkdir -p "${dest}"
  rm -rf "${dest:?}/"*
  cp -R "${SRC_DIR}/." "${dest}/"
  ok "${label}  →  ${dest}"
  installed=$((installed + 1))
done

# --- global memory home ------------------------------------------------------
mkdir -p "${HOME}/.svs"
if [ ! -f "${HOME}/.svs/profile.md" ]; then
  cat > "${HOME}/.svs/profile.md" <<'EOF'
# /svs — Global Director Profile

> Filled out over time. The skill reads this before every job.

## Brand
- Primary color:
- Accent color:
- Brand font:
- Logo path:

## Defaults
- Default aspect ratio: 16:9   # options: 16:9 (YouTube) · 9:16 (Reels/TikTok) · 1:1 (square)
- Default fps: 30
- Music: ask each time

## Taste
- Tone: (e.g. sleek / energetic / luxurious / playful)
- Reference videos / inspiration:
EOF
  ok "Created ~/.svs/profile.md (global Director profile)"
else
  skip "~/.svs/profile.md already exists — left untouched"
fi

b ""
b "✅  Installed /svs into ${installed} agent location(s)."
b "    Restart your agent (or start a new session) and type:  /svs"
b ""
