---
description: Fix wrong, redundant, and bloated comments on changed code and the docs they drifted from
argument-hint: [additional-instructions]
---

Audit and fix the comments and documentation on the changed code (default: uncommitted; pass a ref
or range to scope it otherwise). Read every changed file in full — comment problems do not show up
in a diff.

**First, list the comments you are keeping** — the ones carrying a *why* that is not derivable from
the code. Do this before proposing a single cut. A pass that eats those is a net loss.

Then fix, most severe first:

**Wrong** — a comment stating something untrue. Check for:
- identifiers renamed since the comment was written
- claims invalidated by a later change in the same set
- comments copied from another file where the premise held and here does not
- doc links and anchors — resolve them, do not eyeball them

**Redundant** — restates the code, repeats what a doc already says, or is a verbatim copy of a
comment living in another file. Remove it.

**Verbose** — the claim earns its place, the wording does not. Cut the worked example and the
editorializing; keep every claim.

**Drifted docs** — does the change make any statement in `docs/` or `README` wrong? Fix those too.

Judge density against comparable existing files in the same repo, never an absolute number. It is a
signal to go read, not a target to hit.

Finish by running the project's own check (tests, typecheck, lint) — this should be a no-op change
to behavior. Report what you changed, and what you deliberately left.

$ARGUMENTS

