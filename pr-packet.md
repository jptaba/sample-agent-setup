# PR packet — generated 2026-10-18T13:05:06Z
Contract: references/contract.md (sha256: 8b79cb6f7eb11b9bf1df51e2dd7d2878c0904563f5c51f7aea2c16eb1bdcd180)

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
`node --test "tests-ts/**/*.test.ts"` — must exit 0. (Node 22+ runs the TypeScript directly; no build step, no dependencies. The explicit glob is used because `node --test <dir>` doesn't discover `.ts` files on its own.)

## Done when
- Both functions match the outputs above on ASCII, unicode, and empty input.
- The full test suite is green.

## Bad result looks like

## What changed (git diff --stat)
```
 .agents/skills/review/scripts/collect-evidence.sh |  2 +-
 AGENTS.md                                         |  2 +-
 README.md                                         | 13 ++++++-------
 references/contract-py.md                         | 12 ++++++++++--
 references/contract.md                            | 11 +++--------
 5 files changed, 21 insertions(+), 19 deletions(-)
 pr-packet-ts.md           | 69 -----------------------------------------------
 references/contract-py.md | 28 +++++++++++++++++++
 references/contract-ts.md | 35 ------------------------
 references/contract.md    | 31 ++++++++++++---------
 4 files changed, 47 insertions(+), 116 deletions(-)
```

## What was run, and the exit code
```
$ node --test "tests-ts/**/*.test.ts"
▶ slugify
  ✔ basic (8.044169ms)
  ✔ punctuation and case (0.286187ms)
  ✔ unicode (0.346901ms)
  ✔ empty (0.276398ms)
✔ slugify (11.54786ms)
▶ wordCount
  ✔ basic (0.529563ms)
  ✔ empty and whitespace (0.280667ms)
✔ wordCount (1.191895ms)
ℹ tests 6
ℹ suites 2
ℹ pass 6
ℹ fail 0
ℹ cancelled 0
ℹ skipped 0
ℹ todo 0
ℹ duration_ms 288.545529
exit code: 0
```

## What the reviewer could not check
- (fill in: anything the script and diff cannot show — e.g. production data, manual UX)

## Verdict
- READY FOR REVIEW — proof command passed. Reviewer: judge the diff against the contract; cite file and line per finding.
