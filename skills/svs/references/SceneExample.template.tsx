/**
 * SceneExample.template.tsx
 * A COMPLETE, render-safe reference scene. Copy to  video/src/scenes/SceneNN.tsx  and adapt.
 *
 * Demonstrates every Render-Safety law in one place:
 *  - all motion from useCurrentFrame() (no CSS/Tailwind animation)
 *  - clamped interpolate (no flicker)
 *  - spring entrance, DP push-in (camera language)
 *  - FilmGrade finishing layer (colorist + vfx)
 *  - real component (Showcase) OR original element (Original) in the same slot
 */
import React from "react";
import {
  AbsoluteFill,
  Sequence,
  interpolate,
  spring,
  useCurrentFrame,
  useVideoConfig,
} from "remotion";
import { FilmGrade } from "../grade/FilmGrade";
// 🟦 Showcase Mode — import the REAL component:
// import { Hero } from "@app/components/Hero";

export const SceneExample: React.FC<{
  title?: string;
}> = ({ title = "Your headline" }) => {
  const frame = useCurrentFrame();
  const { fps, durationInFrames } = useVideoConfig();

  // Entrance (spring) — first ~0.5s
  const enter = spring({ frame, fps, config: { damping: 200 } });
  const y = interpolate(enter, [0, 1], [48, 0]);
  const opacity = interpolate(frame, [0, 12], [0, 1], { extrapolateRight: "clamp" });

  // DP slow push-in across the whole scene (1.00 → 1.06)
  const scale = interpolate(frame, [0, durationInFrames], [1, 1.06], {
    extrapolateLeft: "clamp",
    extrapolateRight: "clamp",
  });

  // Exit fade — last 10 frames
  const exit = interpolate(
    frame,
    [durationInFrames - 10, durationInFrames],
    [1, 0],
    { extrapolateLeft: "clamp", extrapolateRight: "clamp" },
  );

  return (
    <FilmGrade look="teal-orange" grain={0.05} vignette={0.32}>
      <AbsoluteFill
        style={{
          opacity: exit,
          transform: `scale(${scale})`,
          background: "var(--bg, #0b0b0f)",
          alignItems: "center",
          justifyContent: "center",
        }}
      >
        {/* 🟦 Showcase: render the REAL component here, e.g. <Hero /> */}
        {/* 🟪 Original: render your design-system element here */}
        <div style={{ transform: `translateY(${y}px)`, opacity, textAlign: "center" }}>
          <h1
            style={{
              fontFamily: "var(--brand-font, Inter)",
              fontSize: 96,
              fontWeight: 800,
              color: "var(--fg, #fff)",
              letterSpacing: "-0.03em",
              margin: 0,
            }}
          >
            {title}
          </h1>
        </div>
      </AbsoluteFill>

      {/* Caption / lower-third can be its own <Sequence from={...}> */}
      <Sequence from={Math.round(fps * 0.5)} layout="none" />
    </FilmGrade>
  );
};
