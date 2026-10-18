# PR packet — generated 2026-10-18T12:59:44Z
Contract: references/contract.md (sha256: abb1d0392f2f833bfd10ec965da0e708cd4511b036530ec91c8bca3601e1c1dd)

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
 .github/dependabot.yml                             |  4 +++
 .github/instructions/java.instructions.md          |  8 +++++
 AGENTS.md                                          |  1 +
 README.md                                          | 10 ++++--
 java-demo/pom.xml                                  | 26 ++++++++++++++
 .../main/java/com/sample/textutils/TextUtils.java  | 28 +++++++++++++++
 .../java/com/sample/textutils/TextUtilsTest.java   | 40 ++++++++++++++++++++++
 references/contract-java.md                        | 35 +++++++++++++++++++
 8 files changed, 149 insertions(+), 3 deletions(-)
```

## What was run, and the exit code
```
$ python3 -m unittest discover -s tests
......
----------------------------------------------------------------------
Ran 6 tests in 0.006s

OK
exit code: 0
```

## What the reviewer could not check
- (fill in: anything the script and diff cannot show — e.g. production data, manual UX)

## Verdict
- READY FOR REVIEW — proof command passed. Reviewer: judge the diff against the contract; cite file and line per finding.
