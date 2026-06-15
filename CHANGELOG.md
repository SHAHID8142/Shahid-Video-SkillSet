# Changelog

All notable changes to **Shahid Video SkillSet (`/svs`)**.
Format loosely follows [Keep a Changelog](https://keepachangelog.com/).

## [1.3.0] — 2026-06-15
### Added
- **Deep reference guides (progressive disclosure)** so the core SKILL stays lean while coverage grows:
  - `cloud-rendering.md` — Remotion Lambda + GitHub Actions for long/batch/CI/per-customer renders.
  - `3d-webgl.md` — Three.js / R3F scenes with frame-determinism and GL-backend flags.
  - `player-embed.md` — embedding the live interactive `<Player>` (autoplay/hover/scroll-scrub).
  - `troubleshooting.md` — full symptom → cause → fix matrix.
  - `brief.template.md` + `storyboard.template.md` — concrete `./.svs/` memory files.
- "Deep References" index in SKILL.md pointing to the above on demand.

## [1.2.0] — 2026-06-15
### Added
- **Production Hardening (Step 5.5):** multi-format reframing (16:9 / 9:16 / 1:1 without
  letterboxing, safe areas), data-driven motion, audio-licensing safety rule, captions + `.srt`
  accessibility.
- **Reference templates:** complete worked `SceneExample`, `AnimatedNumber` (data count-ups),
  `render-all.mjs` (multi-format delivery), and `package.template.json`.
- Quality gate expanded to 21 checks (reframing, audio licensing, real data, captions).

## [1.1.0] — 2026-06-15
### Added
- **Interactive multi-agent installer** with mark/unmark picker, `--all` / `--detected` modes, and
  accurate per-agent detection. Now covers 11 agents incl. Cursor (`.mdc`), Windsurf, Cline/Roo,
  OpenCode, Aider, Continue.
- **`AGENTS.md`** — supported-agent matrix + manual fallback for any other agent.
- **Bundled `references/` templates** (Remotion config alias, IsolatedProvider, deterministic GSAP
  hook, FilmGrade finish, font gating, Playwright capture).
- **Dual mode:** 🟦 Showcase (real codebase) + 🟪 Original (from a script in a blank dir).
- **`/sps` Craft Engine dependency** — all design/animation code routes through `/sps`, auto-installed
  if missing.
- 10-role **Virtual Film Crew**, **Render-Safety & Determinism** laws (Step 4.5), Error Recovery
  (Step 4.6), non-React Playwright fallback, complex-state mocking, TTS narration.
### Fixed
- Replaced the invalid `--disable-webgl` render flag with the correct `--gl=<backend>`.

## [1.0.0] — 2026-06-15
### Added
- Initial `/svs` scaffold: README, CATALOG, install/uninstall scripts, `skills/svs/SKILL.md` with the
  four unbreakable rules, Director's workflow, and scene-by-scene approval.
