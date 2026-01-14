---
description: Generate PR description based on repo template and changes
agent: build
---

Generate a pull request description for the following changes.

**Default branch detection:**
!`git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@' || git remote show origin | grep 'HEAD branch' | cut -d' ' -f5 || echo "main"`

**Changes in this branch:**
!`DEFAULT_BRANCH=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@' || git remote show origin | grep 'HEAD branch' | cut -d' ' -f5 || echo "main") && git diff $(git merge-base HEAD origin/$DEFAULT_BRANCH)..HEAD`

**PR template (if exists):**
!`cat .github/pull_request_template.md 2>/dev/null || cat .github/PULL_REQUEST_TEMPLATE.md 2>/dev/null || cat docs/pull_request_template.md 2>/dev/null || echo "No template found - use standard format with: Summary, Changes, Testing, and Notes sections"`

**Recent commits for context:**
!`DEFAULT_BRANCH=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@' || git remote show origin | grep 'HEAD branch' | cut -d' ' -f5 || echo "main") && git log $(git merge-base HEAD origin/$DEFAULT_BRANCH)..HEAD --oneline`

**Instructions:**
1. Follow the PR template structure if one exists
2. Fill in all sections based on the actual code changes
3. Be specific and descriptive
4. Highlight the most important changes
5. Include any breaking changes or migration notes
6. Use markdown formatting
