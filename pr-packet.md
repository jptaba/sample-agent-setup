# PR packet — generated 2026-10-18T22:47:41Z
Contract: references/contract.md (sha256: cbfa3aa547587110e080e6c0415db1dc17479e9d10b43abff5e7b9694f12bab1)

## What was asked (copied from the contract)
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
```bash
node --test "tests-ts/**/*.test.ts"
```
Must exit 0. (Node 22+ runs the TypeScript directly; no build step, no dependencies. The explicit glob is used because `node --test <dir>` doesn't discover `.ts` files on its own.)

## Done when
- Both functions match the outputs above on ASCII, unicode, and empty input.
- The full test suite is green.

## Bad result looks like

## What changed (git diff --stat)
```
 .agents/skills/review/scripts/collect-evidence.sh | 30 ++++++++++++++++++++++-
 .githooks/pre-commit                              |  6 ++++-
 references/contract-java.md                       |  5 +++-
 references/contract-py.md                         |  5 +++-
 references/contract.md                            |  5 +++-
 5 files changed, 46 insertions(+), 5 deletions(-)
```

## What was run, and the exit code
```
$ node --test "tests-ts/**/*.test.ts"
▶ slugify
  ✔ basic (8.884762ms)
  ✔ punctuation and case (0.370327ms)
  ✔ unicode (0.417027ms)
  ✔ empty (0.384437ms)
✔ slugify (14.319264ms)
▶ wordCount
  ✔ basic (0.932881ms)
  ✔ empty and whitespace (1.789387ms)
✔ wordCount (3.164613ms)
ℹ tests 6
ℹ suites 2
ℹ pass 6
ℹ fail 0
ℹ cancelled 0
ℹ skipped 0
ℹ todo 0
ℹ duration_ms 314.602294
exit code: 0
```

## What the reviewer could not check
- (fill in: anything the script and diff cannot show — e.g. production data, manual UX)

## Verdict
- READY FOR REVIEW — proof command passed. Reviewer: judge the diff against the contract; cite file and line per finding.
