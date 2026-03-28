---
description: Search and load history entries
argument-hint: [search-query]
tags: [dotagent]
---

Search and load history entries from `.agent/history/`.

## Instructions

### No arguments

If `$ARGUMENTS` is empty:

1. Read and display `.agent/history/INDEX.md`.
2. If INDEX.md does not exist or `.agent/history/` is empty, say so.

### With arguments (tiered search)

If `$ARGUMENTS` is provided:

**Tier 1 — Search INDEX.md:**
1. Read `.agent/history/INDEX.md`.
2. Search for lines matching the query (case-insensitive) in titles and tags.
3. If matches found, list them.

**Tier 2 — Full-text search (only if Tier 1 found nothing):**
1. Search across all `.md` files in `.agent/history/` for the query.
2. List matching files with the line(s) that matched.

**After search:**
- If exactly one match: read and display the full entry.
- If multiple matches: list them with summaries and ask which one to load.
- If no matches: say so.

$ARGUMENTS
