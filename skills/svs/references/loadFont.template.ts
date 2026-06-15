/**
 * loadFont.template.ts
 * Drop into  video/src/loadFont.ts.
 *
 * Loads a font and BLOCKS the render until it's ready, so text never pops/reflows mid-render.
 * Uses delayRender/continueRender (the Render-Safety law for async assets).
 */
import { delayRender, continueRender } from "remotion";

// Easiest path — bundled Google font (no async handle needed, it self-waits):
//   import { loadFont } from "@remotion/google-fonts/Inter";
//   const { fontFamily } = loadFont();
//   export { fontFamily };

// Custom/local font with an explicit delayRender gate:
export const loadCustomFont = (family: string, url: string) => {
  const handle = delayRender(`Loading font ${family}`);
  const font = new FontFace(family, `url(${url})`);
  font
    .load()
    .then((loaded) => {
      document.fonts.add(loaded);
      continueRender(handle);
    })
    .catch((err) => {
      console.error("Font load failed", err);
      continueRender(handle); // never leave the render hanging past 30s
    });
  return family;
};
