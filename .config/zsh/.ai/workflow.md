# Agent Workflow

Always follow this 4-step process. Do not skip steps.

## 1. Spec

Before implementation, clarify:

- Goal
- Input / Output
- Edge cases
- Affected files
- Required tests
- Constraints

Template:

```md
## Spec

### Goal
...

### Input
...

### Output
...

### Edge Cases
- ...

### Affected Files
- ...

### Tests
- ...
```

Do not edit files during this step.

## 2. Plan

Create a small implementation plan.

Template:

```md
## Plan

1. Inspect existing implementation at ...
2. Add/update domain logic in ...
3. Add/update API/UI layer in ...
4. Add tests at ...
5. Run: <lint / test / build commands>
```

Do not edit files until the plan is accepted, unless the user explicitly asks
for direct implementation.

## 3. Implement

Rules:

- Change the fewest files possible
- Keep naming consistent with existing code
- Use existing patterns and utilities
- Avoid new dependencies without justification
- Add comments only when logic is non-obvious

## 4. Review

After implementing, always check:

- Does the implementation match the spec?
- Are edge cases handled?
- Are errors handled?
- Are tests updated?
- Did any unrelated files change?
- Is there any migration or deployment risk?

Use the format in `.ai/review-checklist.md` when summarising.
