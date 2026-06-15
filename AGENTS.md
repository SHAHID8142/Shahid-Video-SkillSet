# Using `/svs` on any CLI / AI coding agent

`/svs` is a portable instruction skill. The installer ships first-class support for the agents below,
and **any other agent** can use it via the manual fallback at the bottom.

## Supported out of the box

Run `bash install.sh` (or `./install.ps1`) and pick from this list — detected agents are pre-checked,
and you can mark/unmark any of them:

| Agent | Install kind | Location |
|-------|--------------|----------|
| Claude Code | skill folder | `~/.claude/skills/svs/` |
| Gemini CLI | skill folder | `~/.gemini/skills/svs/` |
| Antigravity | skill folder | `~/.gemini/antigravity/skills/svs/` |
| Codex CLI | skill folder | `~/.codex/skills/svs/` |
| OpenCode | skill folder | `~/.config/opencode/skills/svs/` |
| Aider | skill folder | `~/.aider/skills/svs/` |
| Continue | skill folder | `~/.continue/skills/svs/` |
| Generic (`~/.agents`) | skill folder | `~/.agents/skills/svs/` |
| Cursor | rule file (`.mdc`) | `~/.cursor/rules/svs.mdc` |
| Windsurf | rule file | `~/.codeium/windsurf/global-rules/svs.md` |
| Cline / Roo (VS Code) | rule file | `~/.clinerules/svs.md` |

### Installer modes
```bash
bash install.sh            # interactive picker (mark/unmark agents)
bash install.sh --detected # install only into agents found on this machine
bash install.sh --all      # install into every supported agent
```
```powershell
./install.ps1              # interactive picker
./install.ps1 -Detected    # detected only
./install.ps1 -All         # all agents
```

In the interactive picker: type numbers to toggle (`1 3 5`), `a` = all, `n` = none, `d` = detected,
**ENTER** to install, `q` to quit.

## Any other agent (manual fallback)

`/svs` is just a Markdown instruction file. For any agent not listed above:

1. **Folder-skill agents** (read `SKILL.md` from a skills dir): copy the `skills/svs/` folder into that
   agent's skills directory.
2. **Single-rule agents** (one global rules/instructions file): copy the body of
   `skills/svs/SKILL.md` (everything after the YAML frontmatter) into the agent's rules file, or point
   the agent at the file directly.
3. **No skill system at all**: just paste the contents of `skills/svs/SKILL.md` into the chat/system
   prompt, then type your `/svs` request. It works as a plain instruction set.

The skill is self-contained — it carries its own rules, the 10-role crew, render-safety laws, and the
`references/` templates. It depends on `/sps` only for design/animation craft, which it auto-installs
when missing.
