---
description: Generate conventional commit message from staged changes
agent: build
---

Generate a conventional commit message for these staged changes:

**Change summary:**
!`git diff --cached --stat`

**Detailed changes:**
!`git diff --cached`

**Instructions:**
Follow the conventional commit format:
- Format: `type(scope): description`
- Types: feat, fix, docs, style, refactor, test, chore, perf, ci, build, revert
- Keep first line under 72 characters
- Add body with details if changes are complex or need explanation
- Add footer for breaking changes: `BREAKING CHANGE: description`

**Examples:**
- `feat(auth): add OAuth2 login support`
- `fix(api): handle null response in user endpoint`
- `docs(readme): update installation instructions`
- `refactor(utils): simplify date formatting logic`

Be specific and descriptive. Focus on the "why" and "what", not the "how".
