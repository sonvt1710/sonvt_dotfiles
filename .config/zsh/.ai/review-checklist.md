# Review Checklist

## Correctness

- [ ] Requirement implemented as specified?
- [ ] Edge cases handled?
- [ ] Error cases handled?
- [ ] Existing behavior preserved?

## Code Quality

- [ ] Diff is small and focused?
- [ ] No duplicate logic introduced?
- [ ] Naming consistent with the rest of the codebase?
- [ ] No dead code left behind?

## Tests

- [ ] Unit tests added or updated?
- [ ] Integration tests added or updated?
- [ ] Manual test steps documented?

## Risk

- [ ] Auth or permission logic touched?
- [ ] Database schema or data touched?
- [ ] Public API contract changed?
- [ ] Deployment config changed?

## Final Response Format

```md
## Summary
- ...

## Files Changed
- `path`: reason

## Tests
- Ran: ...
- Not run: ...

## Risk
- Low / Medium / High — reason
```
