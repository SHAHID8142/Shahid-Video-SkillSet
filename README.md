<div align="center">

# 🎬 Shahid Video SkillSet — `/svs`

### A World-Class AI Video Director & Remotion Expert, installed as a single command.

**Turn your real codebase into a cinematic showcase video. No fake mockups. No generic UI slop. Just your actual product, directed like a film.**

[![Skill](https://img.shields.io/badge/skill-%2Fsvs-black?style=for-the-badge)](#)
[![Remotion](https://img.shields.io/badge/Remotion-Powered-3b82f6?style=for-the-badge)](https://remotion.dev)
[![Agents](https://img.shields.io/badge/Claude%20%C2%B7%20Antigravity%20%C2%B7%20Gemini-Compatible-7c3aed?style=for-the-badge)](#installation)
[![License](https://img.shields.io/badge/license-MIT-22c55e?style=for-the-badge)](#license)

</div>

---

## The Thesis

Most "AI video" tools hallucinate a generic SaaS dashboard, slap a gradient behind it, and call it a product demo. It looks like everyone else's. It is not your product. **It is slop.**

`/svs` takes the opposite, opinionated stance:

> **The only acceptable footage is your real UI.** Your actual React/Next.js/HTML components, your real CSS, your real fonts, your real design tokens, your real assets — rendered frame-perfectly inside [Remotion](https://remotion.dev) and directed with cinematic, frame-deterministic motion.

It does not "make a video." It **directs** one — collecting assets, writing a script, pitching you three distinct cuts, and building the final piece **one approved scene at a time**, the way a real editor works.

This is the companion to [`/sps` (Shahid Personal SkillSet)](https://github.com/SHAHID8142/Shahid-Personal-SkillSet). Same architecture. Same installable, multi-agent, unbreakable-rules philosophy. One job, done at a world-class level: **video.**

---

## Two modes — it adapts to where you run it

`/svs` detects its mode automatically, then runs the **same** director workflow, crew, rules, and render pipeline either way. Only the *source of the visuals* changes.

| | 🟦 **Showcase Mode** | 🟪 **Original Mode** |
|---|---|---|
| **When** | You run it inside a real project (website / app) | You run it in an empty folder, or have no project |
| **Visuals** | Your **real** components & assets, 1:1 | **Original** visuals it designs in code from your **script/idea** |
| **It asks for** | Nothing — it scans your codebase | Your script, the kind of video, brand, platform |
| **Rule 1** | 1A — never invent UI | 1B — original, but held to the same anti-slop bar via a locked design system |
| **Best for** | Product demos, portfolio showcases | Explainers, ads, kinetic-type, title sequences, story/quote videos |

So: **yes — you can create a video purely from a script with no project.** Run `/svs` in a blank directory and it enters Original Mode, asks for your idea, pitches 3 plans, and builds it scene-by-scene exactly like Showcase Mode.

---

## What it does

When you type `/svs [request]` inside any existing web project (🟦 Showcase Mode), the AI:

1. **Scans your actual codebase** — maps the component tree (via `graphify`), detects the stack, and builds an inventory of your real UI: heroes, navbars, cards, dashboards, pricing tables, footers, plus your tokens, fonts, and `public/` assets.
2. **Sets up an isolated Remotion studio** in `video/` that imports your **real** components via a webpack alias — your app is never modified.
3. **Becomes a Director** — writes a treatment + script, then proposes **exactly 3 distinct video plans** and stops for your pick.
4. **Builds scene-by-scene** — codes one ~5-second scene, then stops and asks you to review it live on `localhost:3000` before it's allowed to touch the next scene.
5. **Works as a full virtual film crew** — not just a Director: a Cinematographer (virtual camera), Colorist (grade/LUT), Gaffer (CG lighting), VFX Compositor (grain/bloom/DOF), Editor (pacing), Sound Designer (music + SFX), and Title designer all contribute to every scene.
6. **Layers cinematic motion** — Remotion + GSAP + Framer Motion + Lenis, all driven by the frame clock so every render is identical — and it **neutralizes** any baked-in CSS/Tailwind/Framer animation in your real components (which don't render in Remotion) and re-drives them deterministically.
7. **Renders** the final MP4 at your target aspect ratio (16:9 / 9:16 / 1:1) and hands you a deliverable.

---

## 🎬 The Virtual Film Crew

A Director alone makes a tech demo. A **crew** makes a film. `/svs` embodies ten roles and narrates each decision from the relevant one — *"As DP this is a slow push-in; as Colorist I'm grading it warm teal-orange; as Sound Designer the cut lands on the downbeat."*

**Director · Cinematographer (DP) · Production Designer · Gaffer (lighting) · Motion Designer · VFX Compositor · Editor · Colorist · Sound Designer/Composer · Title Designer**

See [`CATALOG.md`](CATALOG.md) for what each role pulls.

---

## ⛔ The Four Unbreakable Rules

These are enforced inside [`skills/svs/SKILL.md`](skills/svs/SKILL.md). The AI is instructed that violating any one of them is a **total failure of the task**, no matter how good the output looks.

### 1. The 1:1 Real Asset Rule
The AI **NEVER** designs a fake UI for the video. Every pixel on screen is your **actual component**, imported from your real source with your real styles, fonts, tokens, copy, and assets. If a component needs live data, only the **data** is mocked — never the **design**. No placeholder heroes. No stock cards. No UI slop. Ever.

### 2. The Director's Workflow
Before writing **any** video code, the AI must collect assets, write a script, and propose **exactly 3 distinct plans** (e.g. *Short Punchy Montage*, *Cinematic Showcase*, *Feature Breakdown*). It then **STOPS and waits** for you to approve **one**.

### 3. Scene-by-Scene Approval (Mandatory)
The AI **cannot** build the whole video at once. It builds one scene (~5s) at a time. After coding a scene it **stops**, tells you to spin up the Remotion `localhost` server, review that **specific** scene visually, and give **explicit approval** — only then may it write the next scene.

### 4. Cinematic, Best-in-Class Motion
The skill bundles instructions for layering **GSAP**, **Framer Motion**, and **Lenis** on top of Remotion for top-tier visual fidelity — complex timelines, staggered reveals, parallax depth, smooth camera moves — all driven by `useCurrentFrame()` so the render is **deterministic** (frame N is identical on every machine).

---

## Installation

The installer is **interactive** — it lists every supported agent, pre-checks the ones found on your machine, and lets you **mark/unmark** exactly where to install. Works on Claude Code, Gemini CLI, Antigravity, Codex, OpenCode, Aider, Continue, Cursor, Windsurf, Cline/Roo, and any generic `~/.agents` host. See [`AGENTS.md`](AGENTS.md) for the full list and a manual fallback for **any other agent**.

### macOS / Linux
```bash
git clone https://github.com/SHAHID8142/Shahid-Video-SkillSet
cd Shahid-Video-SkillSet
bash install.sh            # interactive picker
# bash install.sh --detected   # only agents found on this machine
# bash install.sh --all        # every supported agent
```

### Windows (PowerShell)
```powershell
git clone https://github.com/SHAHID8142/Shahid-Video-SkillSet
cd Shahid-Video-SkillSet
./install.ps1              # interactive picker  (-Detected / -All also available)
```

In the picker: type numbers to toggle (`1 3 5`), `a` = all, `n` = none, `d` = detected, **ENTER** to install, `q` to quit. Folder-skill agents get `skills/svs/`; Cursor/Windsurf/Cline get a generated rule file. Restart your agent and type `/svs` to confirm.

### Uninstall
```bash
bash uninstall.sh      # macOS / Linux   (--purge also removes ~/.svs)
./uninstall.ps1        # Windows         (-Purge also removes ~/.svs)
```

---

## Usage

From inside the project you want a video of:

```
/svs make me a launch trailer for my landing page
```
```
/svs cinematic 60s showcase of the dashboard for our pitch deck
```
```
/svs punchy 15s vertical reel of the pricing page for TikTok
```

Or, in an **empty folder** (Original Mode — no project needed):

```
/svs make a 30s animated explainer from this script: "..."
```
```
/svs cinematic kinetic-typography quote video, 9:16, dark + gold
```

Then follow the director:

1. **Confirm setup** — platform/aspect ratio, brand color + font, music yes/no.
2. **Review the asset manifest** — the AI shows you exactly which real components it found.
3. **Pick one of 3 plans** — montage / showcase / breakdown.
4. **Approve each scene** — run `npx remotion studio`, watch on `localhost:3000`, say "approved" or request changes.
5. **Get your MP4** — rendered at your target spec.

### Prerequisites
- Node 18+ and a package manager (npm / pnpm / yarn).
- For 🟦 Showcase Mode: an existing web project (React, Next.js, Vite, Astro, or plain HTML/CSS). For 🟪 Original Mode: nothing but your idea.
- **[`/sps` — Shahid Personal SkillSet](https://github.com/SHAHID8142/Shahid-Personal-SkillSet)**. `/svs` routes all design & animation code through `/sps` for best-in-class, anti-slop craft, and **auto-installs it** if it's missing. Install it ahead of time for the smoothest run.
- ~2 minutes for the one-time Remotion install inside `video/`.

> ### `/svs` directs · `/sps` crafts
> `/svs` is the film director — vision, plans, scenes, camera, grade, sound. The **actual design and animation code is generated through [`/sps`](https://github.com/SHAHID8142/Shahid-Personal-SkillSet)** (epic-design, awwwards-animations, senior-frontend, code-reviewer). That pairing is what keeps both the real-asset wrappers and any original visuals at a world-class bar instead of generic. If `/sps` isn't installed when you run `/svs`, the skill clones and installs it for you.

---

## How it works (architecture)

```
Shahid-Video-SkillSet/
├── README.md              ← you are here
├── AGENTS.md              ← supported agents + manual install for any other agent
├── CATALOG.md             ← bundled video/animation sub-skills
├── install.sh / .ps1      ← interactive multi-agent installers (mark/unmark)
├── uninstall.sh / .ps1    ← clean removal
└── skills/
    └── svs/
        ├── SKILL.md       ← the master Director instruction file (the brain)
        └── references/    ← battle-tested Remotion templates the skill copies
            ├── remotion.config.template.ts
            ├── IsolatedProvider.template.tsx
            ├── useGsapTimeline.template.ts
            ├── FilmGrade.template.tsx
            ├── loadFont.template.ts
            └── capture-app.template.mjs
```

The skill creates two memory layers at runtime, mirroring `/sps`:
- **Global** `~/.svs/profile.md` — your brand kit, default aspect ratios, music taste.
- **Local** `./.svs/` — `profile.md`, `storyboard.md` (live shot list + scene approvals), `assets.md` (real-asset manifest), `mistakes.md` (motion/render errors never to repeat).

And an **isolated** `video/` workspace in your project that imports your real components via a webpack alias — so the studio renders your UI 1:1 without ever touching your app.

---

## Why frame-deterministic motion matters

Remotion renders by seeking to a frame and screenshotting it. Any animation based on wall-clock time (`gsap.to`, `setTimeout`, `Date.now()`) will render differently every pass and produce **stutter and dropped frames**. `/svs` enforces that **all** motion derives from `useCurrentFrame()` — GSAP timelines are *seeked*, not *played*; Framer values are driven by the frame; Lenis camera moves are eased against the frame. The result: buttery, reproducible, broadcast-grade output.

---

## FAQ

**Does it modify my app?** No. All video work is isolated in `video/`. Your source is read-only input.

**What if a component needs a backend / auth / live data?** The AI mocks the **data** (realistic fixtures/props) but never the **design** — the pixels stay yours. If a component truly can't render in isolation, it tells you and asks.

**Vue / Svelte / Angular?** Best-in-class support is React/Next.js/HTML. Other frameworks degrade gracefully — the AI will render static captures or ask how you'd like to bridge them.

**My components use CSS transitions / `animate-` classes / Framer Motion — will those work?** They render *statically* in Remotion (CSS animations and Tailwind animation classes are not captured). `/svs` keeps the component's exact look but **neutralizes** its self-driven motion and re-animates it from the frame clock, so it renders perfectly and deterministically.

**Can it skip the approvals to go faster?** No. The scene-by-scene gate is an unbreakable rule. That discipline is exactly why the output isn't slop.

---

## License

MIT © Shahid. Built to pair with [`/sps`](https://github.com/SHAHID8142/Shahid-Personal-SkillSet).

<div align="center">

**Your product is the footage. `/svs` is the director.**

</div>
