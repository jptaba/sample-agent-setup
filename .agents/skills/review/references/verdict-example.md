# Verdict examples

The format every review verdict follows. Cite file and line per finding; never
approve on "looks fine".

## APPROVE

> Verdict: APPROVE
>
> - `src-ts/textutils.ts:12` — slugify strips diacritics via NFKD before hyphenating; matches contract edge case "café au lait → cafe-au-lait".
> - `tests-ts/textutils.test.ts:8` — new regression test covers the reported bug.
> - Packet `pr-packet.md`: proof exit 0, contract sha `9f2a…` matches `references/contract.md`, secret scan clean.
>
> Could not check: production traffic shape for the new input; flag for the human gate.

## REQUEST CHANGES

> Verdict: REQUEST CHANGES
>
> - `src-ts/textutils.ts:20` — adds `axios` import; the contract names zero runtime dependencies. Remove it or update the contract first.
> - `tests-ts/textutils.test.ts` — no test for the empty-string edge case the contract requires ("## Edge cases").
> - Packet `pr-packet.md`: contract sha `41bc…` does not match `references/contract.md` (`9f2a…`) — stale packet, regenerate after fixing.
>
> Could not check: nothing — diff and proof output were both visible.
