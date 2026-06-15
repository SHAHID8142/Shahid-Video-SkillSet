# Embedding the Interactive `<Player>`

Use when the user wants the video **live and interactive on their own site** (autoplay hero,
hover-to-play, scrubbable demo) instead of — or in addition to — a rendered MP4. The Player runs the
same composition in the browser, so it stays pixel-identical to the render and updates with the code.

## Install & basic embed

```bash
npm i @remotion/player
```

```tsx
"use client"; // Next.js App Router: the Player is a client component
import { Player } from "@remotion/player";
import { Showcase } from "@/video/src/Showcase"; // your composition component

export const HeroVideo = () => (
  <Player
    component={Showcase}
    durationInFrames={300}
    fps={30}
    compositionWidth={1920}
    compositionHeight={1080}
    style={{ width: "100%", borderRadius: 16, overflow: "hidden" }}
    inputProps={{ title: "Live from real code" }}
    controls
    autoPlay
    loop
    // For silent social-style autoplay, also pass: muted
  />
);
```

## Patterns
- **Autoplay hero:** `autoPlay loop muted` + no `controls`; pair with `clickToPlay={false}`.
- **Hover to play:** keep a `ref` (`PlayerRef`) and call `.play()` / `.pause()` on mouse enter/leave.
- **Scroll-scrubbed:** map scroll progress → `playerRef.current.seekTo(frame)` for a scrollytelling hero.
- **Responsive:** the Player scales to its container; set the container aspect ratio with CSS and let
  `compositionWidth/Height` define the internal resolution.

## Gotchas
- Mark the wrapper `"use client"` in Next.js — the Player needs the browser.
- Fonts/assets must be reachable from the site's `public/` (same `staticFile()` discipline applies).
- The Player is for *preview/interactivity*; for a downloadable file you still `remotion render`.
- Heavy WebGL/3D compositions can stutter on low-end devices — offer a rendered MP4 fallback poster.
