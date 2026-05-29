# zsh

ZSH configuration

## Context

Read `.ai/context.md` for architecture and domain rules.
Read `.ai/style.md` for coding conventions.
Read `.ai/commands.md` for build and test commands.

## Behaviour

- Suggest completions consistent with the existing code style.
- Prefer small, focused functions over large monolithic ones.
- Always include type annotations and return types.
- Follow the testing conventions in this repo.
- Preserve existing naming and architecture.
- Do not suggest new dependencies without a clear reason.

## Safety

See `.ai/safety.md`. Do not suggest code that:

- Commits secrets or credentials
- Runs destructive git or database commands
- Changes auth or permission logic without a comment explaining why
