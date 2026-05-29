# AI Agent Guide — zsh

This directory is the shared "brain" for all AI coding assistants working in this repo.
Every tool (Claude Code, Gemini CLI, Codex, Cursor, etc.) is pointed here.

## Files

| File | Purpose |
|------|---------|
| `workflow.md` | Spec → Plan → Implement → Review process |
| `context.md` | Architecture, modules, domain rules |
| `commands.md` | Build, test, lint, run commands |
| `style.md` | Coding conventions |
| `safety.md` | What the agent must never do |
| `review-checklist.md` | Diff review checklist |
| `prompts/` | Reusable prompt templates |

## How to Use

Load context before starting any task:

```
Read .ai/context.md, .ai/commands.md, .ai/style.md before making changes.
```

For a new feature, use the workflow:

```
Follow .ai/workflow.md — create a spec first, then a plan, then implement.
```
