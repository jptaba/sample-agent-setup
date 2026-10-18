---
applyTo: "**/*.{ts,mts,cts}"
---

# TypeScript review rules
- No new runtime dependencies without a contract update (`node:test` and `node:assert/strict` cover the demo).
- Public functions need explicit parameter and return types.
- New behavior needs a test; bug fixes need a regression test.
- Prefer `node:`-prefixed imports for builtins.
