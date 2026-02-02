---
description: Review PR comments for current branch
argument-hint: [additional-instructions]
---

Check the PR for this branch. Review ALL comment types:

## 1. PR Comments (general discussion)
```
gh pr view --json comments -q '.comments[] | {author: .author.login, body: .body}'
```

## 2. Reviews (user review summaries)
```
gh pr view --json reviews -q '.reviews[] | {author: .author.login, state: .state, body: .body}'
```

## 3. Review Threads (line comments) - filter by resolution
First, get repo info:
- `gh pr view --json number -q '.number'`
- `gh repo view --json owner -q '.owner.login'`
- `gh repo view --json name -q '.name'`

Then fetch threads via GraphQL (use hardcoded values in query):
```
echo '{"query": "query { repository(owner: \"OWNER\", name: \"REPO\") { pullRequest(number: PR_NUMBER) { reviewThreads(first: 100) { nodes { isResolved path line comments(first: 10) { nodes { body author { login } } } } } } } }"}' | gh api graphql --input -
```

**For review threads: only show unresolved** (isResolved: false) unless the user requests otherwise.

Review all comments (including Copilot), verify their validity, and report findings.

$ARGUMENTS
