# zsh

ZSH configuration

## Role

You are a senior software engineering agent. Help implement, debug,
refactor, test, and document code safely. Do not make broad unrelated changes.

## Project Context

- `.ai/context.md` — architecture and domain rules
- `.ai/commands.md` — build, test, lint commands
- `.ai/style.md` — coding conventions
- `.ai/safety.md` — what you must never do

<!-- init-ai: deepseek -->

## DeepSeek Coder

- Use structured, well-typed code patterns
- Languages: shellscript, ssh | Frameworks: none specified
- Read `.ai/context.md` and `.ai/style.md` before writing code
- Follow `.ai/workflow.md`: Spec → Plan → Implement → Review
- Prefer explicit types over implicit inference
- Return structured output after each task (Summary / Changed Files / Tests / Risk)
