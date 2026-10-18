# PR packet — generated 2026-10-18T13:05:06Z
Contract: references/contract-py.md (sha256: f43d67baf3ab54db72fbfbb1b39cb0ec89cc450a0b1e31a6df1f29ce32e113b2)

## What was asked (copied from the contract)
## Inputs
- `text`: str — any unicode string, possibly empty.

## Outputs
- `slugify(text) -> str`: lowercase ASCII slug, words joined by single hyphens, no leading/trailing hyphens.
  - `slugify("Hello World") == "hello-world"`
  - `slugify("Café au lait") == "cafe-au-lait"`
  - `slugify("") == ""`
- `word_count(text) -> int`: number of whitespace-separated tokens.
  - `word_count("hello world") == 2`
  - `word_count("") == 0`, `word_count("   ") == 0`

## Proof command
`python3 -m unittest discover -s tests` — must exit 0.

## Done when
- Both functions match the outputs above on ASCII, unicode, and empty input.
- The full test suite is green.

## Bad result looks like

## What changed (git diff --stat)
```
 .agents/skills/review/scripts/collect-evidence.sh |  2 +-
 AGENTS.md                                         |  2 +-
 README.md                                         | 13 ++---
 pr-packet.md                                      | 67 ++++++++++++++---------
 references/contract-py.md                         | 12 +++-
 references/contract.md                            | 11 +---
 6 files changed, 62 insertions(+), 45 deletions(-)
 pr-packet-ts.md           | 69 -----------------------------------------------
 references/contract-py.md | 28 +++++++++++++++++++
 references/contract-ts.md | 35 ------------------------
 references/contract.md    | 31 ++++++++++++---------
 4 files changed, 47 insertions(+), 116 deletions(-)
```

## What was run, and the exit code
```
$ python3 -m unittest discover -s tests
......
----------------------------------------------------------------------
Ran 6 tests in 0.001s

OK
exit code: 0
```

## What the reviewer could not check
- (fill in: anything the script and diff cannot show — e.g. production data, manual UX)

## Verdict
- READY FOR REVIEW — proof command passed. Reviewer: judge the diff against the contract; cite file and line per finding.
