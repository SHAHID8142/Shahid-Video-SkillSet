# `/svs` Reference Templates

Battle-tested boilerplate the skill copies instead of hand-writing — so output is correct and
consistent. Copy a template into the `video/` workspace and adapt it; don't reinvent these.

| Template | Copy to | Purpose |
|----------|---------|---------|
| `remotion.config.template.ts` | `video/remotion.config.ts` | Webpack alias → real `../src`, Tailwind, image format |
| `IsolatedProvider.template.tsx` | `video/src/IsolatedProvider.tsx` | Mock Router/Theme/Query/Store context to render real components in isolation |
| `useGsapTimeline.template.ts` | `video/src/motion/useGsapTimeline.ts` | Deterministic GSAP driven by `useCurrentFrame()` (seek, never play) |
| `FilmGrade.template.tsx` | `video/src/grade/FilmGrade.tsx` | Colorist + VFX finish: grade, vignette, deterministic grain, tint |
| `loadFont.template.ts` | `video/src/loadFont.ts` | Block render until fonts load (`delayRender`/`continueRender`) |
| `capture-app.template.mjs` | project root | Non-React fallback: Playwright captures of the real running app |

All templates obey the Render-Safety laws in `SKILL.md` Step 4.5 (frame-deterministic, clamped,
async-gated). They ship with the skill, so every agent that installs `/svs` gets them.
