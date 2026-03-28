---
description: Review PR comments for current branch
argument-hint: [additional-instructions]
---

Check the PR for this branch. Review ALL comment types:

## 1. First: Understand the PR

Before looking at any comments:
- Read the branch commits (`git log main..HEAD --oneline`)
- Read the changed source files (actual files, not just diffs)
- Understand what the PR does and why

## 2. PR Comments (general discussion)
```
gh pr view --json comments -q '.comments[] | {author: .author.login, body: .body}'
```

## 3. Reviews (user review summaries)
```
gh pr view --json reviews -q '.reviews[] | {author: .author.login, state: .state, body: .body}'
```

## 4. Review Threads (line comments) - filter by resolution
First, get repo info:
- `gh pr view --json number -q '.number'`
- `gh repo view --json owner -q '.owner.login'`
- `gh repo view --json name -q '.name'`

Then fetch threads via GraphQL (use hardcoded values in query):
```
echo '{"query": "query { repository(owner: \"OWNER\", name: \"REPO\") { pullRequest(number: PR_NUMBER) { reviewThreads(first: 100) { nodes { isResolved path line comments(first: 10) { nodes { body author { login } } } } } } } }"}' | gh api graphql --input -
```

**For review threads: only show unresolved** (isResolved: false) unless the user requests otherwise.

## 5. Verify each comment against the actual code

For each comment (including Copilot):
1. Read the actual source file(s) it references — not the diff
2. Trace the claim: if the comment says "X is a problem", read the code path to confirm or refute
3. If you can't point to the exact line that proves or disproves the comment, you haven't verified it
4. Check if the issue was already addressed in a later commit on the branch

Verdict for each comment must be one of:
- **Confirmed**: with the specific line/evidence proving the issue exists
- **Wrong**: with the specific line/evidence disproving the claim
- **Outdated**: addressed in a later commit (cite which one)

Do NOT add your own suggestions or observations beyond what was commented. Scope is verifying existing comments only.

$ARGUMENTS
