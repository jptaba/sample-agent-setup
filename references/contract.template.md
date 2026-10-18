# Contract — <feature> (template)

Copy this file to `references/contract-<feature>.md` for each new project or
feature. This file is the only per-project file — everything in
`.agents/skills/` stays generic.

## What was asked

<One or two sentences: the feature and its purpose.>

## Inputs

<What goes in: function signatures, CLI args, file formats, etc.>

## Outputs

<What comes out: return values, files, formats.>

## Proof command

```bash
<the one command that proves it works, e.g. pytest, npm test, mvn test>
```

Requirements: <JDK 21+, Node 22+, Python 3.10+, network for first-time
dependency fetch — whatever applies.>

## Edge cases

<List the edge cases the tests must cover, and what is explicitly out of scope.>

## What a bad result looks like

<Concrete failure modes: e.g. "slugify drops digits", "proof command exits
non-zero", "packet claims without a file:line citation".>

## To prove a non-default contract

```bash
CONTRACT=references/contract-<feature>.md PROOF_CMD="<proof command>" \
  PACKET=pr-packet-<feature>.md \
  bash .agents/skills/review/scripts/collect-evidence.sh
```
