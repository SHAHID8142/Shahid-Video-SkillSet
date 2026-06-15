# 🎬 `/svs` Catalog — Bundled Video & Animation Skills

`/svs` is one master Director skill that internally orchestrates a curated set of video & motion
sub-disciplines. They are not separate commands — invoking `/svs` activates the right ones for the job.
This catalog documents what's inside the box.

---

## 🧩 Craft Engine — powered by `/sps`

`/svs` directs; **[`/sps`](https://github.com/SHAHID8142/Shahid-Personal-SkillSet) does the design &
animation craft.** Every scene's visuals and motion code are generated through `/sps`'s specialist
skills (epic-design, awwwards-animations, senior-frontend, code-reviewer) so nothing is ever generic.
If `/sps` isn't installed, `/svs` auto-installs it from the repo before designing.

---

## 🎬 The Virtual Film Crew (10 roles the AI embodies)

Pure cinematic output is a *crew* effort, not a single Director. `/svs` wears all ten hats and narrates
decisions from the relevant one.

| Role | Cinematic lever it pulls |
|------|--------------------------|
| **Director** | Story, vision, the 3-plan pitch, scene approvals |
| **Cinematographer (DP)** | Virtual camera — push-in, dolly, pan, parallax, depth of field, framing |
| **Production Designer** | Frame composition, backgrounds, negative space, brand world |
| **Gaffer (Lighting)** | CG lighting — glow, vignette, rim light, atmosphere, mood |
| **Motion Designer** | Frame-driven entrances, staggers, kinetic type, transitions |
| **VFX Compositor** | Film grain, bloom, chromatic aberration, lens flares, DOF, light leaks |
| **Editor** | Pacing, rhythm, J/L cuts, montage theory, the 2-second hook |
| **Colorist** | Color grade, LUT, film emulation, contrast curve, palette cohesion |
| **Sound Designer / Composer** | Music bed, UI SFX, whooshes/risers/impacts, beat-mapped mix |
| **Title / Brand Designer** | Lower-thirds, captions, end card, logo sting in the real brand font |

---

## 🎥 Direction & Pre-Production

| Skill | What it does |
|-------|--------------|
| **Asset Recon** | Scans the real codebase (`graphify`), maps the component tree, and builds the asset manifest (`.svs/assets.md`). The foundation of the 1:1 Real Asset Rule. |
| **The Treatment** | Writes the creative vision — tone, pacing, color grade, emotional arc — grounded in the real brand. |
| **Beat Sheet / Script** | Timed sequence of shots mapped to real components; saved to `.svs/storyboard.md`. |
| **3-Plan Pitch** | Generates exactly three distinct cuts (Montage / Showcase / Breakdown) and stops for approval. |
| **Storyboard Tracker** | Tracks every scene's status: `drafted → in review → approved → rendered`. |

---

## 🎞️ Remotion Engineering (Core)

| Skill | What it does |
|-------|--------------|
| **Studio Scaffolder** | Sets up the isolated `video/` Remotion workspace, fps/dimension defaults, and `Root.tsx`. |
| **Real-Component Bridge** | Webpack/Vite alias + Tailwind/CSS mirroring so the video imports your **actual** `../src` components and renders them 1:1. |
| **Sequence Composer** | Builds `<Sequence>`, `<Series>`, and `<TransitionSeries>` scene structure. |
| **Frame-Clock Engine** | Enforces deterministic motion: everything derives from `useCurrentFrame()`. |
| **Transitions Pack** | `@remotion/transitions` — slide, fade, wipe, clock-wipe, custom presentations. |
| **Audio Sync** | `@remotion/media-utils` beat detection; cuts land on the beat; clean fades. |
| **Render & Deliver** | Draft + full renders at H.264/ProRes/WebM; posters; per-platform exports. |

---

## ✨ Cinematic Motion Layer (Best-in-Class Fidelity)

| Skill | What it does |
|-------|--------------|
| **GSAP Timelines** | Complex staggered reveals, morphs, text splits — *seeked* to the frame, never time-played. |
| **Framer Motion (deterministic)** | Declarative entrances/exits & layout animations driven by the Remotion clock. |
| **Lenis Camera Moves** | Smooth, eased "scroll-through-the-page" tours of the real UI, frame-synced. |
| **Spring & Easing Lab** | Remotion `spring()`, `measureSpring`, cubic-bezier curves, clamped interpolation. |
| **Depth & Parallax** | Multi-layer parallax, scale, blur, and depth-of-field for cinematic feel. |
| **Kinetic Typography** | Brand-font captions, lower-thirds, and word-by-word reveals. |

---

## 🎞️ Cinematic Finish (Colorist · Gaffer · VFX)

| Skill | What it does |
|-------|--------------|
| **Color Grade / LUT** | Cohesive grade, teal-orange / warm / clinical looks, film emulation, contrast curve. |
| **CG Lighting** | Glow, vignette, rim light, ambient gradients, atmosphere — mood through light. |
| **Film Grain & Texture** | Subtle grain, light leaks, halation for the "shot on film" finish. |
| **Bloom & Lens FX** | Bloom, lens flares, chromatic aberration, depth-of-field blur. |
| **Beat-Mapped Editing** | 2-second hook, cut rhythm synced to music, J/L cuts, montage pacing. |
| **Voiceover / Narration** | Optional script + TTS (e.g. ElevenLabs) narration track, ducked under music. |

---

## ⚙️ Render-Safety & Determinism (prevents broken renders)

| Skill | What it does |
|-------|--------------|
| **Motion Neutralizer** | Strips non-deterministic CSS/Tailwind/Framer animation from copied real components and re-drives it from the frame clock. |
| **Async Render Guard** | `useDelayRender()`/`delayRender()` + `continueRender()` so fonts, images, and data finish before capture. |
| **Asset Pipeline** | `staticFile()`, `<Img>`, `@remotion/media` `<Video>`/`<Audio>`, `prefetch()` for heavy assets. |
| **Metadata & Schema** | `calculateMetadata` for dynamic duration; Zod-typed composition props. |
| **GPU Hardening** | Precomputes heavy `blur`/`shadow`/`filter`/WebGL to stills for safe headless renders. |
| **Concurrency & Codecs** | `remotion benchmark`, `--concurrency`, H.264/ProRes/WebM, `--scale` for drafts. |

---

## 🎯 Production Hardening (real-deliverable robustness)

| Skill | What it does |
|-------|--------------|
| **Multi-Format Reframing** | Purpose-reframes one source into 16:9 / 9:16 / 1:1 — punch-ins, vertical stacking, safe areas. No letterboxing/squishing. |
| **Data-Driven Motion** | Deterministic count-ups, animated charts, rings, and progress from REAL figures. |
| **Audio Licensing Guard** | Refuses copyrighted music; uses royalty-free/licensed sources and states the license. |
| **Captions & Accessibility** | Burned-in captions + sidecar `.srt`, safe-area placement, reduced-motion alternates. |
| **One-Command Delivery** | `render-all` outputs every aspect ratio + poster stills from a single source of truth. |

---

## 🎨 Brand & Quality

| Skill | What it does |
|-------|--------------|
| **Brand Kit Loader** | Reads `~/.svs/profile.md` + project tokens for 1:1 brand-accurate color/type. |
| **Aspect Ratio Manager** | 16:9 (YouTube), 9:16 (Reels/TikTok), 1:1 (square) compositions. |
| **Reduced-Motion Mode** | Low-motion / still alternatives on request. |
| **Director's Quality Gate** | 12-point pre-handover checklist (real assets, determinism, sync, render-verified). |
| **Mistake Memory** | Logs motion/render errors to `.svs/mistakes.md` so they never recur. |

---

## 📦 Bundled npm stack (installed into `video/`)

```
remotion · @remotion/cli · @remotion/player · @remotion/transitions
@remotion/google-fonts · @remotion/shapes · @remotion/media-utils · @remotion/lottie
gsap · framer-motion · @studio-freight/lenis
```

---

> Every item above serves **one mission**: turn your real product into a cinematic video, with zero fake UI.
> See [`skills/svs/SKILL.md`](skills/svs/SKILL.md) for the full Director protocol and the Four Unbreakable Rules.
