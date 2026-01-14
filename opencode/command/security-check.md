---
description: Perform security audit on codebase and dependencies
agent: plan
---

Perform a comprehensive security audit of this project.

**Dependency vulnerabilities:**
!`npm audit --json 2>/dev/null || npm audit 2>/dev/null || yarn audit 2>/dev/null || pnpm audit 2>/dev/null || pip-audit 2>/dev/null || safety check 2>/dev/null || cargo audit 2>/dev/null || go list -json -m all 2>/dev/null | nancy sleuth 2>/dev/null || echo "No dependency audit tool found"`

**Git secrets scan:**
!`git log --all --pretty=format: --name-only | sort -u | grep -iE '\.(env|pem|key|p12|pfx|crt|cer|der|pkcs12|jks|keystore|secret|credential|password|token)$' | head -20 || echo "No obvious secret files in git history"`

**Sensitive patterns in code:**
!`git grep -iE '(password|secret|api_key|apikey|token|private_key|access_key|auth).*=.*["\047][^"\047]{8,}' | head -20 || echo "No hardcoded secrets pattern found"`

**Configuration files check:**
!`find . -type f \( -name ".env*" -o -name "*secret*" -o -name "*credential*" -o -name "*.pem" -o -name "*.key" \) -not -path "*/node_modules/*" -not -path "*/.git/*" | head -20`

**Permissions audit:**
!`find . -type f -perm -u+x -not -path "*/.git/*" -not -path "*/node_modules/*" | head -20`

**Security analysis instructions:**
Based on the above findings:

1. **Dependency Vulnerabilities:**
   - Identify critical/high severity vulnerabilities
   - Suggest version updates or patches
   - Recommend alternative packages if needed

2. **Secrets Management:**
   - Check for hardcoded credentials
   - Identify improperly stored secrets
   - Suggest using environment variables or secret managers

3. **Code Security:**
   - Look for common vulnerabilities (SQL injection, XSS, etc.)
   - Check input validation
   - Review authentication/authorization logic

4. **Configuration Security:**
   - Verify secure defaults
   - Check for exposed configuration files
   - Review file permissions

5. **Best Practices:**
   - Suggest security improvements
   - Recommend security tooling
   - Point out compliance issues

Provide actionable recommendations with priority levels (Critical, High, Medium, Low).
