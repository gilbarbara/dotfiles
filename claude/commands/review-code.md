---
description: Review uncommitted changes (fresh-code lens) with pragmatic-code-reviewer
argument-hint: [additional-instructions]
---

Run pragmatic-code-reviewer subagent on uncommitted working-tree changes (default: staged + unstaged; pass `staged` for staged-only).

Lens for this review (apply during validation):
- Bug-prone spots — off-by-ones, null/undef paths, type coercion surprises
- Error handling — try/catch coverage, async rejection paths, fallback behavior
- Edge cases in new logic — empty, single, max, malformed
- Untested branches — code paths without test coverage
- Security on input boundaries — sanitization, injection, auth checks

@~/.claude/snippets/review-rigor.md

$ARGUMENTS
