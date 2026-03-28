---
description: List stories or load a specific story
argument-hint: [story-name]
tags: [dotagent]
---

List or load story documents from `.agent/stories/`.

## Instructions

### No arguments

If `$ARGUMENTS` is empty:

1. List all `.md` files in `.agent/stories/`.
2. For each file, extract the **Status** and the first line of the **Problem Statement > Background** section.
3. Display as a table: filename, status, summary.
4. If no stories exist, say so.

### With arguments

If `$ARGUMENTS` is provided:

1. List all `.md` files in `.agent/stories/`.
2. Fuzzy match the query against filenames (partial match, case-insensitive).
3. If exactly one match: read and display the full story content.
4. If multiple matches: list them and ask which one to load.
5. If no match: say so and list available stories.

$ARGUMENTS
