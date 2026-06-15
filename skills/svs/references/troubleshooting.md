# Troubleshooting Matrix

Symptom → likely cause → fix. Consult when a render or preview misbehaves. (Extends SKILL.md Step 4.6.)

## Motion & visual
| Symptom | Cause | Fix |
|---------|-------|-----|
| Animation works in preview, frozen/static in render | CSS/Tailwind/Framer self-animation | Neutralize it; drive from `useCurrentFrame()` (Rule 1 / Step 4.5) |
| Flicker / jitter at scene edges | Unclamped `interpolate` | Add `extrapolateLeft:'clamp', extrapolateRight:'clamp'` |
| Animation differs each render | Wall-clock timing (`Date.now`, `useFrame`, `setTimeout`) | Derive everything from the frame; seed randomness by index |
| Text pops / reflows mid-render | Font not loaded before capture | `delayRender`/`continueRender` or `@remotion/google-fonts` `waitUntilDone()` |
| Elements jump on first frames | Layout shift / async data | Gate async with `delayRender`; set explicit sizes |

## Assets
| Symptom | Cause | Fix |
|---------|-------|-----|
| Image/video missing in render | Raw `<img>` / wrong path | Use `<Img>` + `staticFile()`; assets in `public/` |
| Video out of sync / slow | Legacy video tag | Use `@remotion/media` `<Video>` |
| Audio absent or clipped | Not in `public/` or no `<Audio>` | `staticFile()` + `<Audio>`; check volume/fades |
| `delayRender() timed out` | `continueRender` never called (>30s) | Ensure every handle resolves; add a `.catch` that still continues |

## Imports / build (Showcase Mode)
| Symptom | Cause | Fix |
|---------|-------|-----|
| `Cannot resolve '@app/...'` | Alias missing | Set webpack/Vite alias in `remotion.config.ts` → `../src` |
| `useRouter`/`useStore` is undefined | Missing provider | Wrap scene in `IsolatedProvider`; don't edit the user's component |
| Tailwind styles missing | Tailwind not wired into the studio | `enableTailwind` in config; mirror `globals.css` |
| Component imports server-only code | Next server deps in client render | Pass fixture props; isolate the visual subtree |

## Render / GPU
| Symptom | Cause | Fix |
|---------|-------|-----|
| Black frames / WebGL crash | No GPU headless | `--gl=swangle` (CI) or `--gl=angle` (local GPU) |
| Render very slow | Heavy blur/shadow/filter/WebGL | Precompute to images; lower `--scale` for drafts; tune `--concurrency` |
| Out of memory | Concurrency too high / 4K | Lower `--concurrency`; raise Lambda memory; render in segments |
| Transparency lost | H.264 has no alpha | Use `--codec=webm --transparent` or `--codec=prores --prores-profile=4444` |

## Escalation
If a fix fails ~3 times: roll back the scene to its last approved state, log the failure to
`./.svs/mistakes.md`, and ask the user — don't keep hacking (mirrors the `/sps` 3-strike rule).
