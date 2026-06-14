# TDD (Test-Driven Development)

Always follow the Red-Green-Refactor cycle:

1. **Write a failing test** first (Red)
2. **Write the minimum code** to make it pass (Green)
3. **Refactor** while keeping tests green

## Workflow

- Start by understanding what the code should do
- Write tests that define the expected behavior before any implementation
- Only write enough production code to satisfy the tests
- Run tests frequently to ensure nothing breaks
- Keep tests fast, isolated, and deterministic

## What gets tested

- All business logic
- All API endpoints
- All edge cases and error paths
- All utility/helper functions
