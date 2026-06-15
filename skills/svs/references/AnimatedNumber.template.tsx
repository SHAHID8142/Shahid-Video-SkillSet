/**
 * AnimatedNumber.template.tsx
 * Drop into  video/src/ui/AnimatedNumber.tsx.
 *
 * Data-driven count-up for product/metrics videos (e.g. "10,000+ users", "99.9% uptime").
 * Deterministic: the value is derived from useCurrentFrame() via a spring — no timers, no random.
 */
import React from "react";
import { interpolate, spring, useCurrentFrame, useVideoConfig } from "remotion";

export const AnimatedNumber: React.FC<{
  to: number;
  from?: number;
  durationInFrames?: number;
  prefix?: string;
  suffix?: string;
  decimals?: number;
  locale?: string;
  style?: React.CSSProperties;
}> = ({
  to,
  from = 0,
  durationInFrames = 40,
  prefix = "",
  suffix = "",
  decimals = 0,
  locale = "en-US",
  style,
}) => {
  const frame = useCurrentFrame();
  const { fps } = useVideoConfig();

  const progress = spring({
    frame,
    fps,
    durationInFrames,
    config: { damping: 200 },
  });
  const value = interpolate(progress, [0, 1], [from, to]);

  const formatted = value.toLocaleString(locale, {
    minimumFractionDigits: decimals,
    maximumFractionDigits: decimals,
  });

  return (
    <span style={{ fontVariantNumeric: "tabular-nums", ...style }}>
      {prefix}
      {formatted}
      {suffix}
    </span>
  );
};
