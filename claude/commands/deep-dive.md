---
description: Produce an expert-level analysis of a subsystem or topic
argument-hint: <topic-or-path>
tags: [dotagent]
---

Thoroughly explore a subsystem, module, or topic and produce a comprehensive expert-level analysis document.

## Instructions

1. Parse `$ARGUMENTS` to identify the target:
   - A directory path (e.g., `src/auth/`)
   - A module name (e.g., `authentication`)
   - A conceptual topic (e.g., `state management`, `data flow`)
   - A specific concern (e.g., `positioning logic`, `caching strategy`)
2. If the target is ambiguous, ask the user to clarify before proceeding.
3. Conduct thorough research:
   - Read all relevant source files — follow the chain, not just entry points
   - Trace data flow and control flow through the subsystem
   - Identify public API surfaces, internal abstractions, and integration points
   - Find edge cases, error handling patterns, and failure modes
   - Check tests for behavioral specifications and known scenarios
   - Look at git history for recent significant changes (`git log --oneline -20 -- <path>`)
   - Read any existing documentation (README, inline comments, JSDoc/docstrings)
4. Save to `.agent/<topic-in-kebab-case>.md`. If a file with this name exists, ask the user before overwriting.
5. Structure the document (adapt sections based on what is relevant — not all sections apply to every topic):

```markdown
# <Topic> - Deep Dive

**Generated**: YYYY-MM-DD
**Scope**: <what this analysis covers>
**Key files**: <3-5 most important files>

## Overview
<2-3 paragraphs: what this subsystem does, its role in the larger system, core abstractions>

## Architecture
<Internal structure. Mermaid diagram if it clarifies relationships.>

### Key Components
<For each significant module/class/function: what it does, why it exists, what it depends on>

### Data Flow
<How data moves through this subsystem. Mermaid sequence diagram if helpful.>

## API Surface
<Public interfaces, exported functions, configuration options. Focus on what consumers need to know.>

## Patterns & Conventions
<Coding patterns, error handling, naming conventions, state management. What a developer needs to know to work here.>

## Edge Cases & Gotchas
<Non-obvious behavior. Known limitations. Things that look wrong but are intentional. Race conditions. Performance characteristics.>

## Dependencies
<Internal and external dependencies. What depends on this subsystem.>

## Testing
<How this is tested. Coverage gaps. How to run relevant tests.>

## Improvement Opportunities
<Technical debt. Concrete, actionable items with clear rationale. Not a wish list.>
```

6. After creating, summarize the key findings and any surprises.

## Quality Standards

- Every section must contain specific, accurate information from reading the actual code.
- Use pointers over content: reference file paths and function names, don't duplicate large code blocks.
- If you cannot determine something with confidence, say so explicitly rather than guessing.
- Aim for the depth of a senior engineer who spent a full day studying the code.

$ARGUMENTS
