---
description: Review PR comments for current branch
argument-hint: [additional-instructions]
---

Verify every posted comment against current code, then hand off to user. Scope is comment verification, not freelance review.

## 1. Fetch PR context (parallel)

Run all of the following in a single message — they have no dependencies:

- `git log main..HEAD --oneline` — branch commits
- `git diff main...HEAD --stat` — files changed
- `gh pr view --json number,title,body,state,baseRefName,headRefName,author` — PR metadata
- `gh pr view --json comments -q '.comments[] | {author: .author.login, body: .body, createdAt: .createdAt}'` — discussion comments
- `gh pr view --json reviews -q '.reviews[] | select(.state != "PENDING") | {author: .author.login, state: .state, body: .body, submittedAt: .submittedAt}'` — review summaries (drop own PENDING)
- `gh pr checks` — CI signal (failing checks often drive review feedback)

## 2. Fetch review threads (line comments)

```bash
PR=$(gh pr view --json number -q '.number')
OWNER=$(gh repo view --json owner -q '.owner.login')
REPO=$(gh repo view --json name -q '.name')

gh api graphql -f query='
  query($owner:String!,$repo:String!,$pr:Int!) {
    repository(owner:$owner,name:$repo) {
      pullRequest(number:$pr) {
        reviewThreads(first:100) {
          nodes {
            id
            isResolved
            path
            line
            comments(first:10) {
              nodes { body createdAt author { login } }
            }
          }
        }
      }
    }
  }' -F owner="$OWNER" -F repo="$REPO" -F pr="$PR"
```

Default: keep `isResolved: false` only. If a resolved thread's claim still matches current code, surface it anyway (resolution may be premature).

## 3. Read the code

Before verifying anything:
- Read each changed file in full (not just the diff).
- Read related/upstream files comments reference.
- Map commenters' claims to actual lines.

Reading 1–2 files is sampling, not understanding.

## 4. Verify each comment

For every comment (including Copilot — treat its suggestions with lower prior, often stylistic or wrong):

1. Locate the exact line(s) referenced.
2. Trace the claim. Confirm or refute against code.
3. Check whether a later commit on the branch already addressed it (`git log -p --since="$COMMENT_CREATED_AT" -- <path>`).
4. Deduplicate: if multiple reviewers raised the same issue, collapse into one row, list all authors.

Each comment gets:

- **Verdict**: `Confirmed` | `Wrong` | `Outdated` | `Stylistic`
- **Severity** (Confirmed only): `critical` | `blocking` | `should-fix` | `nit`
- **Evidence**: exact `path:line` proving verdict (for Outdated, cite the commit SHA that fixed it)

Do not invent issues outside posted comments.

## 5. Output

Group by verdict. One row per comment:

```
path:line · author(s) · severity · verdict · evidence · suggested action
```

Order within Confirmed: `critical` → `blocking` → `should-fix` → `nit`.

## 6. Hand off

After the table, STOP and ask:

> Confirmed: N (critical: A, blocking: B, should-fix: C, nit: D). Wrong: W. Outdated: O. Stylistic: S.
> Address Confirmed (all/subset/skip)? Push back on any Wrong items?

Wait for explicit direction before editing code or replying to comments.

$ARGUMENTS
