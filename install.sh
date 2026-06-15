#!/usr/bin/env bash
#
# Shahid Video SkillSet (/svs) — interactive multi-agent installer
#
# Lets you choose WHICH agents to install /svs into. Detected agents are pre-selected;
# toggle any on/off, then confirm. Covers every common CLI / AI coding agent.
#
# Usage:
#   bash install.sh              # interactive picker
#   bash install.sh --all        # install into every supported agent, no prompts
#   bash install.sh --detected   # install only into agents detected on this machine
#   bash install.sh --yes        # same as --detected (non-interactive)
#
set -euo pipefail

SKILL_NAME="svs"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC_DIR="${SCRIPT_DIR}/skills/${SKILL_NAME}"

# --- pretty output -----------------------------------------------------------
b()    { printf "\033[1m%s\033[0m\n" "$1"; }
ok()   { printf "  \033[32m✓\033[0m %s\n" "$1"; }
skip() { printf "  \033[33m•\033[0m %s\n" "$1"; }
err()  { printf "  \033[31m✗\033[0m %s\n" "$1"; }

if [ ! -f "${SRC_DIR}/SKILL.md" ]; then
  err "Could not find skills/${SKILL_NAME}/SKILL.md next to this script."
  echo "  Run this from inside the cloned Shahid-Video-SkillSet repo."
  exit 1
fi

# --- agent registry ----------------------------------------------------------
# Fields:  KEY | Label | install-kind | path | detect-dir
#   kind = folder  → copy the skill folder to <path>/svs/
#   kind = mdc     → write a single Cursor-style rule file at <path>
#   kind = rulefile→ write a single markdown rule file at <path>
#   detect-dir     → if this dir exists, the agent is considered present (pre-selected)
AGENTS=(
  "claude|Claude Code|folder|${HOME}/.claude/skills|${HOME}/.claude"
  "gemini|Gemini CLI|folder|${HOME}/.gemini/skills|${HOME}/.gemini"
  "antigravity|Antigravity|folder|${HOME}/.gemini/antigravity/skills|${HOME}/.gemini/antigravity"
  "codex|Codex CLI|folder|${HOME}/.codex/skills|${HOME}/.codex"
  "opencode|OpenCode|folder|${HOME}/.config/opencode/skills|${HOME}/.config/opencode"
  "aider|Aider|folder|${HOME}/.aider/skills|${HOME}/.aider"
  "continue|Continue|folder|${HOME}/.continue/skills|${HOME}/.continue"
  "agents|Generic (~/.agents)|folder|${HOME}/.agents/skills|${HOME}/.agents"
  "cursor|Cursor|mdc|${HOME}/.cursor/rules/svs.mdc|${HOME}/.cursor"
  "windsurf|Windsurf|rulefile|${HOME}/.codeium/windsurf/global-rules/svs.md|${HOME}/.codeium/windsurf"
  "cline|Cline / Roo (VS Code)|rulefile|${HOME}/.clinerules/svs.md|${HOME}/.clinerules"
)

# The detect-dir exists → treat the agent as present on this machine.
is_detected() {
  local detect="$1"
  [ -d "$detect" ]
}

# --- build the Cursor/rule-file body from SKILL.md ---------------------------
# Cursor .mdc needs its own frontmatter; rule files just need the body.
write_rule_file() {
  local kind="$1" dest="$2"
  mkdir -p "$(dirname "$dest")"
  # Strip the SKILL.md YAML frontmatter (everything up to the 2nd '---').
  local body
  body="$(awk 'BEGIN{f=0} /^---$/{f++; next} f>=2{print}' "${SRC_DIR}/SKILL.md")"
  if [ "$kind" = "mdc" ]; then
    {
      echo "---"
      echo "description: /svs — World-Class AI Video Director & Remotion Expert. Turns a real codebase (or a script) into a cinematic video. Trigger on /svs or any code-to-video request."
      echo "globs:"
      echo "alwaysApply: false"
      echo "---"
      echo ""
      echo "$body"
    } > "$dest"
  else
    {
      echo "# /svs — Shahid Video SkillSet (rule)"
      echo ""
      echo "$body"
    } > "$dest"
  fi
}

install_one() {
  local kind="$1" path="$2" label="$3"
  case "$kind" in
    folder)
      local dest="${path}/${SKILL_NAME}"
      mkdir -p "$dest"
      rm -rf "${dest:?}/"*
      cp -R "${SRC_DIR}/." "$dest/"
      ok "${label}  →  ${dest}"
      ;;
    mdc|rulefile)
      write_rule_file "$kind" "$path"
      ok "${label}  →  ${path}"
      ;;
  esac
}

# --- selection state ---------------------------------------------------------
declare -a SELECTED
MODE="interactive"
case "${1:-}" in
  --all) MODE="all" ;;
  --detected|--yes) MODE="detected" ;;
  "" ) MODE="interactive" ;;
  *) err "Unknown flag: $1"; exit 1 ;;
esac

# default selection: detected agents ON
for i in "${!AGENTS[@]}"; do
  IFS='|' read -r key label kind path detect <<< "${AGENTS[$i]}"
  if [ "$MODE" = "all" ]; then
    SELECTED[$i]=1
  elif is_detected "$detect"; then
    SELECTED[$i]=1
  else
    SELECTED[$i]=0
  fi
done

print_menu() {
  b ""
  b "🎬  Shahid Video SkillSet — choose where to install /svs"
  b "    [x] = will install   [ ] = skipped   (• detected on this machine)"
  b ""
  for i in "${!AGENTS[@]}"; do
    IFS='|' read -r key label kind path detect <<< "${AGENTS[$i]}"
    local mark=" "; [ "${SELECTED[$i]}" = "1" ] && mark="x"
    local det="  "; is_detected "$detect" && det="• "
    printf "   %2d) [%s] %s%-26s \033[2m%s\033[0m\n" "$((i+1))" "$mark" "$det" "$label" "$path"
  done
  b ""
  echo "   Type numbers to toggle (e.g. '1 3 5'), 'a'=all, 'n'=none, 'd'=detected,"
  echo "   ENTER=install selected, 'q'=quit."
}

if [ "$MODE" = "interactive" ] && [ -t 0 ]; then
  while true; do
    print_menu
    printf "  > "
    read -r line || break
    case "$line" in
      "" ) break ;;
      q|Q) echo "Aborted."; exit 0 ;;
      a|A) for i in "${!AGENTS[@]}"; do SELECTED[$i]=1; done ;;
      n|N) for i in "${!AGENTS[@]}"; do SELECTED[$i]=0; done ;;
      d|D) for i in "${!AGENTS[@]}"; do
             IFS='|' read -r key label kind path detect <<< "${AGENTS[$i]}"
             if is_detected "$detect"; then SELECTED[$i]=1; else SELECTED[$i]=0; fi
           done ;;
      *) for n in $line; do
           if [[ "$n" =~ ^[0-9]+$ ]] && [ "$n" -ge 1 ] && [ "$n" -le "${#AGENTS[@]}" ]; then
             idx=$((n-1))
             [ "${SELECTED[$idx]}" = "1" ] && SELECTED[$idx]=0 || SELECTED[$idx]=1
           fi
         done ;;
    esac
  done
elif [ "$MODE" = "interactive" ]; then
  # No TTY (piped) → fall back to detected.
  skip "No interactive terminal — installing into detected agents (use --all to force all)."
fi

# --- install -----------------------------------------------------------------
b ""
b "Installing /svs…"
installed=0
for i in "${!AGENTS[@]}"; do
  [ "${SELECTED[$i]}" = "1" ] || continue
  IFS='|' read -r key label kind path detect <<< "${AGENTS[$i]}"
  install_one "$kind" "$path" "$label"
  installed=$((installed + 1))
done

if [ "$installed" -eq 0 ]; then
  skip "Nothing selected — no changes made."
  exit 0
fi

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
- Default aspect ratio: 16:9   # 16:9 (YouTube) · 9:16 (Reels/TikTok) · 1:1 (square)
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
b "    Tip: /svs routes design/animation through /sps. Install it too:"
b "    https://github.com/SHAHID8142/Shahid-Personal-SkillSet"
b ""
