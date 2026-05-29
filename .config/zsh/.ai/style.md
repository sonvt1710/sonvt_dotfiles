# Code Style

## General

- Use clear, descriptive names.
- Keep functions small and focused.
- Prefer explicit error handling.
- Do not hide business logic inside UI components or controllers.
- Do not duplicate constants or business rules.
- Prefer simple code over clever code.
- Preserve existing style and naming when editing.

## Backend

- Keep controllers / routes thin.
- Put business logic in services or use-cases.
- Validate input at system boundaries.
- Return consistent error formats.
- Log important failures with context, not every trivial event.

## Database

- Use migrations for all schema changes.
- Avoid nullable fields unless the null carries meaning.
- Add indexes for common filter columns.
- Do not change existing column semantics without migration notes.
