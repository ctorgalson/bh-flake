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
2. Check for ADRs (docs/adr/, adr/, architecture/) and review relevant decisions
3. Check each category systematically
4. Report ALL issues found, no matter how small
5. Provide specific line references
6. Suggest concrete fixes
7. If recommending against an ADR: acknowledge it explicitly, explain why circumstances changed, provide evidence, propose updated ADR
