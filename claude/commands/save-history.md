---
description: Save a history entry for the current session
argument-hint: <title>
tags: [dotagent]
---

Capture what happened in the current session as a history entry.

## Instructions

1. Parse `$ARGUMENTS` to get the title. If empty, infer a title from the work done in this session.
2. Create `.agent/history/` if it does not exist.
3. Generate filename: `.agent/history/YYYY-MM-DD-<title-in-kebab-case>.md`
   - If a file with this name exists, append `-2`, `-3`, etc.
4. Gather session information:
   - **If git repo with commits**: run `git rev-parse --short HEAD` for SHA, `git log --oneline -5` for recent commits, `git diff --name-status HEAD~1..HEAD` for changed files.
   - **If git repo with no commits**: note "no commits yet" in the Commit field, skip git log/diff.
   - **If not a git repo**: set Commit to "N/A", skip all git commands.
   - Review the conversation context to understand what was done and why.
5. Create the history entry:

```markdown
# <title>
Date: YYYY-MM-DD HH:MM
Commit: <sha or "N/A">

## What
<1-3 sentences describing what was accomplished>

## Why
<motivation and context for this work>

## Decisions
- <key choice and rationale>

## Changed
- `path/to/file` - <what changed and why>

## Follow-up
- <open items, if any>

Tags: `tag1`, `tag2`
```

6. Update `.agent/history/INDEX.md`:
   - If INDEX.md does not exist, create it with `# History\n\nSession history entries, newest first.\n`
   - Add a new entry at the top of the list (newest first):
     `- [YYYY-MM-DD: <title>](./<filename>.md) - <one-line summary>`

7. Report what was saved.

## Guidelines

- Keep entries lean. No padding.
- "What" should be 1-3 sentences max.
- "Decisions" should capture choices not obvious from the code.
- "Changed" should list significant files, not every file touched. Group related changes.
- "Follow-up" should only include genuine open items, not aspirational TODOs.
- Tags should be short, lowercase, useful for filtering (e.g., `refactor`, `bugfix`, `auth`, `database`).
- If no meaningful work was done in this session, say so instead of creating an empty entry.

$ARGUMENTS
