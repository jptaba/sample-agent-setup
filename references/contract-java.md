# Contract — textutils-java (sample)

Third demo in the same repo. The contract is per feature: point the evidence
script at this file instead of the default.

```bash
CONTRACT=references/contract-java.md PROOF_CMD="mvn -q -f java-demo/pom.xml test" \
  PACKET=pr-packet-java.md \
  bash .agents/skills/review/scripts/collect-evidence.sh
```

## Inputs
- `text`: String — any unicode string, possibly empty (null is out of scope).

## Outputs
- `TextUtils.slugify(text)`: lowercase ASCII slug, words joined by single hyphens, no leading/trailing hyphens.
  - `slugify("Hello World")` returns `"hello-world"`
  - `slugify("Café au lait")` returns `"cafe-au-lait"`
  - `slugify("")` returns `""`
- `TextUtils.wordCount(text)`: number of whitespace-separated tokens.
  - `wordCount("hello world")` returns `2`
  - `wordCount("")` returns `0`, `wordCount("   ")` returns `0`

## Proof command
`mvn -q -f java-demo/pom.xml test` — must exit 0. (Requires JDK 21+ and Maven; the first run downloads JUnit 5 from Maven Central.)

## Done when
- Both methods match the outputs above on ASCII, unicode, and empty input.
- The full test suite is green.

## Bad result looks like
- `slugify("Hello World")` returns anything other than `"hello-world"`.
- Empty input throws instead of returning `""` / `0`.
- Proof command exits non-zero.
- Behavior added that this contract does not name.
