---
name: strict-code-review
description: Enforces rigorous code review standards including security, performance, maintainability, and best practices. Use
 when reviewing code, analyzing PRs, or auditing code quality.
allowed-tools: [Read, Grep, Glob, Bash]
---

# Strict Code Review

## Review Standards

Analyze code with zero tolerance for:

### Security
- Input validation and sanitization
- SQL injection, XSS, command injection vulnerabilities
- Authentication and authorization flaws
- Secrets in code
- Insecure dependencies

### Code Quality
- Unclear naming or poor readability
- Missing error handling
- Code duplication
- Complex functions (>50 lines)
- Missing documentation for public APIs

### Performance
- N+1 queries
- Unnecessary allocations
- Missing indexes
- Inefficient algorithms

### Testing
- Missing tests for critical paths
- Poor test coverage
- Untested edge cases

## Review Process
1. Read all changed files completely
2. Check each category systematically
3. Report ALL issues found, no matter how small
4. Provide specific line references
5. Suggest concrete fixes
