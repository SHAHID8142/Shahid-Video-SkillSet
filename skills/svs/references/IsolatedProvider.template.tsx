/**
 * IsolatedProvider.template.tsx
 * Drop into  video/src/IsolatedProvider.tsx.
 *
 * Wraps a REAL component that depends on global providers (Router, Theme, Redux/Zustand, Query)
 * so it can render inside Remotion in isolation — WITHOUT editing the user's component.
 *
 * Rule 1A: mock the DATA/context, never the DESIGN. Add only the providers your component needs;
 * delete the ones it doesn't.
 */
import React from "react";
// import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
// import { ThemeProvider } from "@app/providers/ThemeProvider";

// const queryClient = new QueryClient({
//   defaultOptions: { queries: { retry: false, staleTime: Infinity } },
// });

export const IsolatedProvider: React.FC<{ children: React.ReactNode }> = ({
  children,
}) => {
  return (
    // <QueryClientProvider client={queryClient}>
    //   <ThemeProvider forcedTheme="dark">
    <>{children}</>
    //   </ThemeProvider>
    // </QueryClientProvider>
  );
};

/**
 * If a component calls next/navigation's useRouter/usePathname, stub them at the top of the scene:
 *
 *   vi-style global stub (works in the bundler):
 *   (globalThis as any).__NEXT_ROUTER__ = { push() {}, prefetch() {}, replace() {} };
 *
 * Prefer passing realistic fixture props over deep context mocking whenever possible.
 */
