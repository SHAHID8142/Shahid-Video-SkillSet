/**
 * remotion.config.template.ts
 * Drop into  video/remotion.config.ts.
 *
 * 🟦 Showcase Mode: aliases the video project to the user's REAL source (../src) and wires their
 *    Tailwind/PostCSS so components render 1:1.
 * 🟪 Original Mode: the alias is harmless if ../src is absent — remove it if you prefer.
 *
 * Adjust the relative paths to match where the app lives relative to video/.
 */
import { Config } from "@remotion/cli/config";
import { enableTailwind } from "@remotion/tailwind-v4"; // use @remotion/tailwind for Tailwind v3
import path from "path";

Config.setVideoImageFormat("jpeg"); // PNG only when you need transparency (slower)
Config.setOverwriteOutput(true);
// Config.setConcurrency(8);        // tune via: npx remotion benchmark

Config.overrideWebpackConfig((current) => {
  return enableTailwind({
    ...current,
    resolve: {
      ...current.resolve,
      alias: {
        ...(current.resolve?.alias ?? {}),
        // Make the user's real components importable from scenes:
        //   import { Hero } from "@app/components/Hero";
        "@app": path.join(process.cwd(), "..", "src"),
      },
    },
  });
});
