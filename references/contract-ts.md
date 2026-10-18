# Contract — textutils-ts (sample)

Second demo in the same repo. The contract is per feature: point the evidence
script at this file instead of the default.

```bash
CONTRACT=references/contract-ts.md PROOF_CMD='node --test "tests-ts/**/*.test.ts"' \
  PACKET=pr-packet-ts.md \
  bash .agents/skills/review/scripts/collect-evidence.sh
```

## Inputs
- `text`: string — any unicode string, possibly empty.

## Outputs
- `slugify(text): string`: lowercase ASCII slug, words joined by single hyphens, no leading/trailing hyphens.
  - `slugify("Hello World") === "hello-world"`
  - `slugify("Café au lait") === "cafe-au-lait"`
  - `slugify("") === ""`
- `wordCount(text): number`: number of whitespace-separated tokens.
  - `wordCount("hello world") === 2`
  - `wordCount("") === 0`, `wordCount("   ") === 0`

## Proof command
`node --test "tests-ts/**/*.test.ts"` — must exit 0. (Node 22+ runs the TypeScript directly; no build step, no dependencies. The explicit glob is used because `node --test <dir>` doesn't discover `.ts` files on its own.)

## Done when
- Both functions match the outputs above on ASCII, unicode, and empty input.
- The full test suite is green.

## Bad result looks like
- `slugify("Hello World")` returns anything other than `"hello-world"`.
- Empty input throws instead of returning `""` / `0`.
- Proof command exits non-zero.
- Behavior added that this contract does not name.
