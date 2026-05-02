---
description: Generate session handoff doc for new agent or review
argument-hint: [--out=<path>] [additional-instructions]
---

Produce a session-handoff document that either (a) seeds a fresh agent with everything needed to continue this work, or (b) supports human review of what happened.

## Argument parsing

`$ARGUMENTS` may contain:

- `--out=<path>` — write the doc to that path. If absent, default to `.agent/handoffs/YYYY-MM-DD-HHMM.md` (relative to cwd). Create the directory if missing.
- Any remaining text (after stripping the flag) — additional instructions from the user (e.g. "focus on auth work", "skip mental model section", "emphasize the failed migration"). Honor them.
- Blank `$ARGUMENTS` — use defaults, no extra guidance.

## Generator rules

Follow these strictly. They matter more than the schema.

- **Quote user verbatim** in Constraints and Last Exchange. Never paraphrase user rules.
- **Skip empty sections entirely.** Do not pad with "N/A" or "none".
- **One line per bullet.** Prefer `file:line` refs over prose descriptions.
- **Flag low-confidence items** with a trailing `?`.
- **Do not duplicate `git log` / `git status`.** Assume the new agent runs both. The handoff covers only what those don't show.
- **Keep it tight.** Session touched <5 files → doc fits on one page.
- **Verification must be concrete.** Name the exact test/command + last output line. Not "tests pass".
- **Failed Attempts must explain why.** Error message, constraint violated, or root cause — not just "didn't work".

## Template

Emit frontmatter then body. Omit any section whose content is empty.

```markdown
---
session_end: <ISO timestamp>
branch: <current branch>
git_state: <clean | dirty (N staged, M untracked, K stash)>
duration: <approx session length>
cwd: <absolute path>
---

## Intent
Original ask, verbatim. If scope shifted mid-session, note current target + what changed.

## Current State
In-flight work, what's working, what's broken. Bulleted, with file refs.

## Decisions Made
Forks taken + why. `Chose X over Y because Z.`

## Constraints
Verbatim user rules. Ruled-out approaches + why. No paraphrase.

## Scope Boundaries
Explicit don'ts this session ("don't touch auth", "don't refactor styles").

## Files Touched
`path:symbol` — nature of change. Mark committed vs uncommitted.

## Verification
- ✓ <what ran green — test name + last output line>
- ✗ <what's untested>
- ⊘ <what skipped, with reason>

## Failed Attempts
What tried, why it failed (error/constraint), don't retry without X.

## Mental Model
Key findings about the codebase (file:line refs). Saves re-exploration next session.

## Environment
Running processes (port, PID), open PRs/tickets referenced, external state the new agent needs to know about.

## Open Questions
Unresolved items user hasn't answered.

## Issues Discovered
Bugs/surprises found this session + any workarounds applied.

## Last Exchange
Literal last user message + last agent action. Continuity anchor for "where we were mid-thought".

## Next Steps
Ordered, specific. First thing the new session should do, then the next.
```

## After writing

Print the output path so the user can pipe/cat it. Do not echo the full body.
