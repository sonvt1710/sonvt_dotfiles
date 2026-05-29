# Safety Rules

## Never Commit

- API keys or tokens
- Passwords or passphrases
- `.env` files with real values
- Production credentials
- SSH keys or certificates

## Always Ask Before

- Deleting files or directories
- Dropping database tables or columns
- Rewriting migrations
- Upgrading major dependencies
- Changing auth or permission logic
- Changing production deployment config
- Force-pushing to any branch

## Destructive Database Operations

Before any destructive migration:

1. Explain the full impact.
2. Provide a rollback plan.
3. Require explicit human approval.

## Destructive Git Commands — Never Run Without Explicit Request

```bash
git reset --hard
git clean -fd
git push --force
```

## Output Format After Work

```md
## Summary
- What was done

## Changed Files
- `path/to/file`: reason

## Tests
- Ran: ...
- Not run: ...

## Risk
- Low / Medium / High — reason
```
