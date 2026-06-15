/**
 * useGsapTimeline.template.ts
 * Drop into  video/src/motion/useGsapTimeline.ts.
 *
 * Drives a GSAP timeline DETERMINISTICALLY from the Remotion frame clock.
 * The timeline is paused and SEEKED to frame/fps every render — never played in real time —
 * so frame N is identical on every machine and every render. (Render-Safety law.)
 */
import { useMemo } from "react";
import { useCurrentFrame, useVideoConfig } from "remotion";
import { gsap } from "gsap";

export const useGsapTimeline = (
  build: () => gsap.core.Timeline,
  deps: React.DependencyList = [],
) => {
  const frame = useCurrentFrame();
  const { fps } = useVideoConfig();

  // Build once (paused). Rebuild only if deps change.
  // eslint-disable-next-line react-hooks/exhaustive-deps
  const tl = useMemo(() => build().pause(), deps);

  // Seek to the exact time for this frame.
  tl.seek(frame / fps);

  return tl;
};

/* Usage in a scene:
   const tl = useGsapTimeline(() => {
     const t = gsap.timeline();
     t.from(".word", { y: 60, opacity: 0, stagger: 0.05, ease: "power3.out" });
     return t;
   });
*/
