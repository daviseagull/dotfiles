---
description: Generate or update documentation for the project
agent: build
---

Generate comprehensive documentation for this project.

**Project structure:**
!`find . -maxdepth 3 -type f \( -name "*.md" -o -name "*.json" -o -name "*.yaml" -o -name "*.yml" -o -name "*.toml" \) -not -path "*/node_modules/*" -not -path "*/vendor/*" -not -path "*/.git/*" | head -30`

**Existing documentation:**
!`find . -type f -name "README.md" -o -name "CONTRIBUTING.md" -o -name "CHANGELOG.md" -o -name "LICENSE" | head -10`

**Package/Config files:**
!`cat package.json 2>/dev/null || cat Cargo.toml 2>/dev/null || cat go.mod 2>/dev/null || cat pyproject.toml 2>/dev/null || cat composer.json 2>/dev/null || echo "No package configuration found"`

**Recent changes:**
!`git log -10 --oneline 2>/dev/null || echo "Not a git repository"`

**Documentation tasks:**
Please analyze the project and:

1. **If README.md doesn't exist:** Create a comprehensive README with:
   - Project overview and purpose
   - Installation instructions
   - Usage examples
   - Configuration guide
   - Contributing guidelines
   - License information

2. **If README.md exists:** Review and suggest improvements:
   - Check for outdated information
   - Suggest missing sections
   - Improve clarity and organization
   - Add examples where helpful

3. **Additional documentation:**
   - Suggest what other documentation would be helpful
   - Identify undocumented features or configurations
   - Recommend inline code documentation improvements

Use clear, concise language and proper markdown formatting.
