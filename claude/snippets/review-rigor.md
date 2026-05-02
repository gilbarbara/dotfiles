## Validation Gate (mandatory before relaying findings)

Tag each finding by claim type. Validation bar differs per type — citation alone is not validation.

**line-text** ("file.ts:42 calls foo with wrong arg") — claim about specific line content.
- Bar: open file, read named line, confirm claim matches text.

**analysis** ("X is redundant", "Y duplicates Z", "this hook over-renders") — inference about behavior or design.
- Bar: trace the chain. Read callers, exports, related code, data flow. Single Read = sampling, not validation.
- Finding must cite secondary evidence (e.g. `grep callers`, `read related hook`, `check git log`). No secondary evidence → drop or downgrade to Open.

**absence** ("no CHANGELOG.md", "missing tests for X") — claim about what's not there.
- Bar: check 2+ alternate conventions before grading. Project may use GitHub releases instead of CHANGELOG, integration tests instead of unit, central test file instead of co-located.
- Alternates not checked → downgrade to Open and ask user.

Gate checks **inference**, not just **citation**. Confirming cited line exists is necessary but not sufficient. Ask: does the conclusion follow from the cited evidence? If no → drop.

Other rules:
- Multiple findings on same area → read side-by-side. Drift = signal one is wrong.
- Failed validation → drop. Name what was wrong with each dropped item.
- Same gate for original items and anything you add. Unvalidated additions = the failure mode.

Under pushback: re-read source. Defend with line cite + inference chain, or admit wrong with reasoning. Never pivot to *new* finding to placate — pivot = sycophancy, not retreat.

Output sections:
- **Findings** — validated items, each tagged `[line-text]` / `[analysis]` / `[absence]` with file:line(s) + secondary evidence cited.
- **Dropped** — items removed + reason.
- **Open** — items needing user input (couldn't validate without more context).
