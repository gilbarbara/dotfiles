---
description: Create a new story document in .agent/stories/
argument-hint: <story-name> [additional-instructions]
tags: [dotagent]
---

Create a story document in `.agent/stories/`.

## Instructions

1. Parse `$ARGUMENTS` to extract the story name (first argument) and any additional instructions.
2. Convert the story name to kebab-case for the filename: `.agent/stories/<story-name>.md`
3. If the file already exists, stop and inform the user.
4. If `.agent/stories/` does not exist, create it.
5. Create the story using the template below.
6. Fill in: title (title-case from the name), today's date for Created and Last Updated, Status: Planning.
7. If additional instructions were provided, incorporate them into the Problem Statement and Requirements sections.
8. After creating the file, summarize what was created.

## Template

```markdown
# [Story Name]

**Status**: Planning
**Created**: YYYY-MM-DD
**Last Updated**: YYYY-MM-DD
**Target Completion**: TBD
**Owner**: TBD

---

## Problem Statement

**Background**: [Current situation and why this needs to be built]

**User Pain Point**: [What problem users are experiencing]

**Business Impact**: [Why this is important]

---

## Requirements

### Must Have
1. [Requirement]

### Nice to Have
1. [Optional feature]

### Out of Scope
- [What we are NOT building]

### Non-Functional Requirements
- **Performance**: [Constraints]
- **Security**: [Constraints]

---

## User Stories

### Story 1: [Title]
**As a** [user type]
**I want** [goal]
**So that** [benefit]

**Acceptance Criteria**:
- [ ] [Criterion]

---

## Technical Design

### Architecture Changes

**Components Affected**:
- [Component and what changes]

### Database Changes

**New Tables**: [if any]
**Modified Tables**: [if any]
**Migrations**: [if any]

### API Changes

[New or modified endpoints]

### Error Handling

| Error | HTTP Code | Message | User Action |
|-------|-----------|---------|-------------|

---

## Implementation Plan

### Phase 1: [Name]
- [ ] [Task]

**Files to modify**:
- `path/to/file` - [what changes]

---

## Testing Strategy

### Unit Tests
- [What to test]

### Integration Tests
- [What to test]

### Manual Testing Checklist
- [ ] [Scenario]

---

## Open Questions
- [ ] [Question]

---

## Risks & Mitigations

| Risk | Impact | Likelihood | Mitigation |
|------|--------|------------|------------|

---

## Implementation Log

**YYYY-MM-DD**: Story created

---

## Post-Launch Review

_Fill out after deployment_

**What went well**:
**What could be improved**:
**Follow-up stories**:
- [ ] [Story]
```

$ARGUMENTS
