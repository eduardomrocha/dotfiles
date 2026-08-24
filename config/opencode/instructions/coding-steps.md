# Coding Steps

All agents must follow this workflow when writing code.

## 1. Plan

- Understand the requirements and desired outcome
- Propose a concise implementation approach before touching code
- Get confirmation if anything is unclear

## 2. Write Tests (TDD — Red Phase)

- **Always write tests before implementation**
- Frontend: unit tests, integration tests, end-to-end tests
- Backend: unit tests, integration tests, end-to-end tests
- Tests must fail before implementation begins

## 3. Implement (Green Phase)

- Write the minimum code to make all tests pass
- Follow existing code style, patterns, and conventions
- Do not add new dependencies without approval

## 4. Run Tests and Fix

- **After any code change, update existing tests** for the affected code
- If no tests cover the changed code, **write new tests** for it
- Run the full test suite
- Fix all failures
- Repeat until every test passes
- Commit only when the suite is green

## 5. Format and Lint

- **Frontend**: `yarn format`, `yarn lint:style`, `yarn lint:script`
- **Backend**: `make format`, `make lint`
- Fix all warnings and errors
- No code is complete until formatter and linter pass clean
