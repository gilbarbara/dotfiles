---
description: Review branch commits (high-level lens) with pragmatic-code-reviewer
argument-hint: [additional-instructions]
---

Run pragmatic-code-reviewer subagent on unique commits of current branch vs base (default: main/master; override via `$1`).

Lens for this review (apply during validation):
- Architectural fit — does change align with existing patterns?
- Atomic commits — one logical change per commit, no unrelated bundling
- Scope discipline — did anything creep beyond stated intent?
- Public API impact — callers/consumers identified, breaking changes flagged
- Migration / rollout safety where applicable

@~/.claude/snippets/review-rigor.md

$ARGUMENTS
