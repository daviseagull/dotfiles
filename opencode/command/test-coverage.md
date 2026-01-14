---
description: Analyze test coverage and suggest improvements
agent: plan
---

Run tests and analyze coverage for this project:

**Test execution:**
!`npm test -- --coverage 2>/dev/null || npm run test:coverage 2>/dev/null || yarn test --coverage 2>/dev/null || pnpm test --coverage 2>/dev/null || pytest --cov --cov-report=term-missing 2>/dev/null || go test -cover ./... 2>/dev/null || cargo test 2>/dev/null || mvn test 2>/dev/null || gradle test 2>/dev/null || echo "No test command found. Please run tests manually and paste the results."`

**Project structure:**
!`find . -type f \( -name "*.test.*" -o -name "*.spec.*" -o -name "*_test.*" \) -not -path "*/node_modules/*" -not -path "*/vendor/*" -not -path "*/.git/*" | head -20`

**Analysis instructions:**
Based on the test results and project structure:
1. Identify untested or poorly tested areas
2. Highlight critical paths that need coverage
3. Suggest specific test cases to add
4. Recommend testing strategies (unit, integration, e2e)
5. Point out any flaky or problematic tests
6. Suggest improvements to test organization

Focus on practical, actionable recommendations.
