# Cloud & CI Rendering at Scale

Use when a render is too long/heavy for the user's machine, or must run in CI / on a schedule / per
PR. Local `npx remotion render` is the default; reach for this when that isn't enough.

## Remotion Lambda (serverless, parallel, fast)

Best for long videos, batch jobs, or rendering many parameterized variants in parallel.

```bash
npm i @remotion/lambda
# One-time AWS setup (needs an AWS account + IAM user with the Remotion policy):
npx remotion lambda policies role        # print the IAM permissions needed
npx remotion lambda functions deploy     # deploy the render function
npx remotion lambda sites create src/index.ts --site-name=svs   # upload the bundle
```

Render:
```bash
npx remotion lambda render <site-name> Showcase-16x9 \
  --codec=h264 --crf=18 --privacy=public
```

Programmatic (good for "render 50 personalized variants"):
```ts
import { renderMediaOnLambda, getRenderProgress } from "@remotion/lambda/client";

const { renderId, bucketName } = await renderMediaOnLambda({
  region: "us-east-1",
  functionName,
  serveUrl,
  composition: "Showcase-9x16",
  codec: "h264",
  inputProps: { title: "Hello" },     // parameterize per render
  framesPerLambda: 20,                 // tune parallelism vs cold-starts
});
```

Notes:
- Lambda has a memory/disk/timeout config — bump memory for heavy WebGL/3D scenes.
- Costs scale with render-seconds × concurrency; warn the user before large batches.
- Set `--concurrency` / `framesPerLambda` to balance speed vs cost.

## GitHub Actions (render on push / PR / schedule)

```yaml
# .github/workflows/render.yml
name: Render video
on:
  workflow_dispatch:
  push:
    paths: ["video/**"]
jobs:
  render:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with: { node-version: 20 }
      - run: cd video && npm ci
      # Chromium deps for headless rendering on Ubuntu:
      - run: cd video && npx remotion browser ensure
      - run: cd video && npx remotion render Showcase-16x9 out/video.mp4 --gl=swangle
      - uses: actions/upload-artifact@v4
        with: { name: video, path: video/out/video.mp4 }
```

- Use `--gl=swangle` in CI (software GL — most compatible without a GPU).
- For WebGL/3D in CI, prefer Lambda (GPU-backed options) over GitHub's CPU runners.

## When to use which
| Situation | Use |
|-----------|-----|
| One video, dev machine | `npx remotion render` (local) |
| Long/4K/heavy render | Remotion Lambda |
| Many personalized variants | Lambda, programmatic, parameterized `inputProps` |
| Auto-render on push/PR | GitHub Actions |
| Per-customer at request time | Lambda behind an API route |
