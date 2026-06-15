/**
 * capture-app.template.mjs
 * Non-React fallback (Vue / Svelte / Angular / any live site).
 * Run:  node capture-app.mjs http://localhost:5173 ./video/public/captures
 *
 * Captures high-fidelity stills (and optionally a video) of the REAL running app, which you then
 * composite in Remotion with <Img>/<Video>. This preserves Rule 1 (real pixels) when the framework
 * isn't React and can't be aliased component-by-component.
 *
 * Requires: npm i -D playwright  (then: npx playwright install chromium)
 */
import { chromium } from "playwright";
import { mkdir } from "node:fs/promises";

const url = process.argv[2] ?? "http://localhost:3000";
const outDir = process.argv[3] ?? "./captures";

// Edit these to the sections/routes you want as "shots".
const SHOTS = [
  { name: "hero", selector: "header, .hero, #hero" },
  { name: "features", selector: "#features, .features" },
  { name: "pricing", selector: "#pricing, .pricing" },
];

await mkdir(outDir, { recursive: true });

const browser = await chromium.launch();
const page = await browser.newPage({
  viewport: { width: 1920, height: 1080 },
  deviceScaleFactor: 2, // retina-crisp captures
});
await page.goto(url, { waitUntil: "networkidle" });

// Full-page poster
await page.screenshot({ path: `${outDir}/fullpage.png`, fullPage: true });

// Per-section element captures
for (const shot of SHOTS) {
  const el = await page.$(shot.selector);
  if (el) {
    await el.screenshot({ path: `${outDir}/${shot.name}.png` });
    console.log(`captured ${shot.name}`);
  } else {
    console.warn(`selector not found for ${shot.name}: ${shot.selector}`);
  }
}

await browser.close();
console.log(`Done → ${outDir}`);
