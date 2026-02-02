# [Epic Title]

**Type**: feature
**Priority**: 0-4 (0=critical, 2=medium, 4=backlog)
**Status**: Planning | In Progress | Done

---

## Problem Statement

**Background**: [Current situation - why does this need to exist?]

**Pain Point**: [What problem are users/devs experiencing?]

**Why Now**: [Why is this the right time to build this?]

---

## Requirements

### Must Have
1. [Core requirement 1]
2. [Core requirement 2]

### Nice to Have
1. [Optional enhancement]

### Out of Scope
- [What we're NOT building]
- [Deferred to future work]

---

## Technical Approach

### Components Affected
- [Component 1: e.g., "API routes - new endpoints"]
- [Component 2: e.g., "Database - new table"]

### Key Files
| File | Change |
|------|--------|
| `src/path/file.ts` | [description] |
| `src/path/other.ts` | [description] |

<!-- OPTIONAL: Architecture notes -->
### Architecture Notes
[High-level design decisions, patterns to follow, constraints]

---

## Issue Breakdown

### Phase 1: [Foundation]
| Issue | Type | Priority | Depends On |
|-------|------|----------|------------|
| [Task 1 title] | task | 2 | - |
| [Task 2 title] | task | 2 | Task 1 |

### Phase 2: [Core Feature]
| Issue | Type | Priority | Depends On |
|-------|------|----------|------------|
| [Task 3 title] | task | 2 | Phase 1 |

---

## Beads Commands

```bash
# Create issues
bd create --title="[Task 1]" --type=task --priority=2
bd create --title="[Task 2]" --type=task --priority=2
bd create --title="[Task 3]" --type=task --priority=2

# Set dependencies (Task 2 depends on Task 1)
bd dep add <task-2-id> <task-1-id>
```

---

## Testing Strategy
- [ ] [What to test - unit]
- [ ] [What to test - integration]
- [ ] [Manual verification steps]

---

## Open Questions
- [ ] [Question 1]
- [ ] [Question 2]

---

<!-- OPTIONAL -->
## Risks

| Risk | Impact | Mitigation |
|------|--------|------------|
| [Risk 1] | High/Med/Low | [How to handle] |

---

## Log

**YYYY-MM-DD**: Planning started
<!-- Update as work progresses -->
