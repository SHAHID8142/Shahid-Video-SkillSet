# 3D / WebGL Scenes in Remotion

Use for product shots with depth, 3D logos, particle fields, shader backgrounds, or floating-UI-in-3D.
Powerful, but the heaviest thing you can render — follow the determinism + render flags carefully.

## Setup

```bash
npm i @remotion/three three @react-three/fiber
npm i -D @types/three
```

Use `<ThreeCanvas>` from `@remotion/three` (NOT R3F's `<Canvas>`) — it syncs WebGL to the frame clock.

```tsx
import { ThreeCanvas } from "@remotion/three";
import { useCurrentFrame, useVideoConfig, interpolate } from "remotion";

export const Logo3D: React.FC = () => {
  const frame = useCurrentFrame();
  const { width, height, durationInFrames } = useVideoConfig();
  // Deterministic rotation from the frame — never useFrame()/clock-based.
  const rotY = interpolate(frame, [0, durationInFrames], [0, Math.PI * 2]);

  return (
    <ThreeCanvas width={width} height={height} camera={{ fov: 40, position: [0, 0, 6] }}>
      <ambientLight intensity={0.6} />
      <directionalLight position={[5, 5, 5]} intensity={1.2} />
      <mesh rotation={[0, rotY, 0]}>
        <boxGeometry args={[2, 2, 2]} />
        <meshStandardMaterial color="#3b82f6" metalness={0.4} roughness={0.2} />
      </mesh>
    </ThreeCanvas>
  );
};
```

## Determinism rules (critical)
- **Never** drive animation from R3F's `useFrame()` or `THREE.Clock` — those are wall-clock and break
  reproducibility. Derive every transform from Remotion's `useCurrentFrame()`.
- Seed any randomness (particle positions) deterministically — precompute from an index, not
  `Math.random()` at render time.
- Load GLTF/textures with `delayRender()`/`continueRender()` (or `useGLTF` + a suspense gate) so the
  first frames don't capture an empty scene.

## Render flags
- Local with GPU: `--gl=angle` (best quality for WebGL).
- Headless/CI without GPU: `--gl=swangle` (software; slower but works).
- If renders crash or show black frames: try `--gl=swiftshader`, raise Lambda memory, or precompute the
  3D shot to a transparent video and composite it (cheapest at scale).

## When NOT to use 3D
If a 2.5D parallax (layered images + scale/translate from the frame) sells the shot, prefer it — it's
far cheaper to render and rarely flickers. Reserve true WebGL for shots that genuinely need depth.
