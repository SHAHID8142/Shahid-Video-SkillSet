/**
 * render-all.template.mjs
 * One command → every deliverable. Run from the video/ workspace:  node render-all.mjs
 *
 * Renders each registered composition (e.g. landscape 16:9, vertical 9:16, square 1:1),
 * plus a poster still for each. Keeps platform exports in sync from a single source of truth.
 *
 * Requires the compositions below to exist in src/Root.tsx with matching ids.
 */
import { execSync } from "node:child_process";
import { mkdirSync } from "node:fs";

const OUT = "out";
mkdirSync(OUT, { recursive: true });

// id = <Composition> id in Root.tsx · file = output name · still = poster frame
const TARGETS = [
  { id: "Showcase-16x9", file: "showcase-landscape.mp4", still: 30 },
  { id: "Showcase-9x16", file: "showcase-vertical.mp4", still: 30 },
  { id: "Showcase-1x1", file: "showcase-square.mp4", still: 30 },
];

const run = (cmd) => {
  console.log(`\n$ ${cmd}`);
  execSync(cmd, { stdio: "inherit" });
};

for (const t of TARGETS) {
  // High-quality H.264 delivery render
  run(
    `npx remotion render ${t.id} ${OUT}/${t.file} --codec=h264 --crf=18 --log=info`,
  );
  // Poster frame for thumbnails / social cards
  run(
    `npx remotion still ${t.id} ${OUT}/${t.file.replace(/\.mp4$/, ".png")} --frame=${t.still}`,
  );
}

console.log(`\n✅ All deliverables in ./${OUT}/`);
