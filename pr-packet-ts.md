# PR packet — generated 2026-10-18T12:47:09Z
Contract: references/contract-ts.md (sha256: 98b1b991c03cbdd57d5d150e18ad7d84481c09de2ae51f4d0b91121038c735d3)

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
 .agents/skills/review/SKILL.md                    |  2 +-
 .agents/skills/review/scripts/collect-evidence.sh |  2 +-
 .gitignore                                        |  1 +
 AGENTS.md                                         |  5 +++--
 README.md                                         | 17 +++++++++++++++++
 5 files changed, 23 insertions(+), 4 deletions(-)
```

## What was run, and the exit code
```
$ node --test "tests-ts/**/*.test.ts"
▶ slugify
  ✔ basic (8.600612ms)
  ✔ punctuation and case (0.332213ms)
  ✔ unicode (0.331391ms)
  ✔ empty (0.301605ms)
✔ slugify (11.812687ms)
▶ wordCount
  ✔ basic (0.54942ms)
  ✔ empty and whitespace (0.250309ms)
✔ wordCount (1.139668ms)
ℹ tests 6
ℹ suites 2
ℹ pass 6
ℹ fail 0
ℹ cancelled 0
ℹ skipped 0
ℹ todo 0
ℹ duration_ms 283.546812
exit code: 0
```

## What the reviewer could not check
- (fill in: anything the script and diff cannot show — e.g. production data, manual UX)

## Verdict
- READY FOR REVIEW — proof command passed. Reviewer: judge the diff against the contract; cite file and line per finding.
