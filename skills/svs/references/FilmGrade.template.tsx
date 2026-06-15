/**
 * FilmGrade.template.tsx
 * Drop into  video/src/grade/FilmGrade.tsx.
 *
 * Colorist + VFX finishing overlay: color grade + vignette + film grain + optional bloom.
 * Wrap your scene content with it as the TOP layer:
 *
 *   <FilmGrade look="teal-orange" grain={0.06} vignette={0.35}>
 *     <SceneContent />
 *   </FilmGrade>
 *
 * Grain uses a frame-seeded value (no Math.random at render time) to stay deterministic.
 */
import React from "react";
import { AbsoluteFill, useCurrentFrame } from "remotion";

type Look = "teal-orange" | "warm" | "clean" | "noir";

const GRADES: Record<Look, React.CSSProperties> = {
  "teal-orange": { filter: "contrast(1.08) saturate(1.12)", mixBlendMode: "normal" },
  warm: { filter: "contrast(1.05) saturate(1.05) sepia(0.06)" },
  clean: { filter: "contrast(1.03) saturate(1.04)" },
  noir: { filter: "grayscale(1) contrast(1.18)" },
};

const TINT: Record<Look, string> = {
  "teal-orange":
    "radial-gradient(120% 120% at 50% 40%, rgba(255,170,90,0.10), rgba(0,40,60,0.18))",
  warm: "linear-gradient(rgba(255,180,120,0.06), rgba(120,60,20,0.06))",
  clean: "transparent",
  noir: "linear-gradient(rgba(0,0,0,0.06), rgba(0,0,0,0.12))",
};

export const FilmGrade: React.FC<{
  children: React.ReactNode;
  look?: Look;
  grain?: number; // 0..0.2
  vignette?: number; // 0..0.6
}> = ({ children, look = "teal-orange", grain = 0.05, vignette = 0.3 }) => {
  const frame = useCurrentFrame();
  // Deterministic grain offset from the frame (no random).
  const gx = ((frame * 37) % 13) - 6;
  const gy = ((frame * 53) % 11) - 5;

  return (
    <AbsoluteFill>
      <AbsoluteFill style={GRADES[look]}>{children}</AbsoluteFill>

      {/* color tint */}
      <AbsoluteFill style={{ background: TINT[look], pointerEvents: "none" }} />

      {/* vignette */}
      <AbsoluteFill
        style={{
          pointerEvents: "none",
          background: `radial-gradient(120% 120% at 50% 50%, transparent 55%, rgba(0,0,0,${vignette}) 100%)`,
        }}
      />

      {/* film grain (tileable noise data-URI, nudged per frame) */}
      <AbsoluteFill
        style={{
          pointerEvents: "none",
          opacity: grain,
          backgroundPosition: `${gx}px ${gy}px`,
          backgroundImage:
            "url(\"data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='120' height='120'><filter id='n'><feTurbulence type='fractalNoise' baseFrequency='0.9' numOctaves='2'/></filter><rect width='100%25' height='100%25' filter='url(%23n)'/></svg>\")",
        }}
      />
    </AbsoluteFill>
  );
};
