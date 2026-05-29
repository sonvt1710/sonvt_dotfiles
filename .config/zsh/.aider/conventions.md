# zsh

ZSH configuration

## Project
- **Languages**: shellscript, ssh
- **Frameworks**: none specified
- **Test coverage target**: 80%

## Code Style
- Prefer immutability; never mutate existing objects
- Small focused files (<800 lines), small functions (<50 lines)
- Explicit error handling at every layer — never swallow errors
- Validate all user input at system boundaries
- No hardcoded secrets — use environment variables

## Testing
- Minimum 80% test coverage
- Test-driven development: write tests first (RED → GREEN → REFACTOR)
- Unit tests for pure logic, integration tests for I/O, E2E for critical flows

## Git
- Conventional commits: feat/fix/refactor/docs/test/chore/perf/ci
- Small, focused commits; one logical change per commit
## Aider Conventions

- Commit after every successful change with a conventional commit message
- Prefer /architect mode for new features, /code for targeted fixes
- Use /ask before making large structural changes
