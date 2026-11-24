# PRD: [Feature / Initiative Name]

> **Status**: Draft | Active | Ready to Archive (Delete after all child issues pass QA)

## 1. Problem Statement
- Describe the user or system pain point in 2–3 concrete sentences.

## 2. Solution Overview
- Summarize the end-to-end mechanism that solves the problem.

## 3. User / System Stories
- List observable behaviors:
  - *When [trigger/condition], [actor/system] produces [observable outcome].*

## 4. Proposed Deep Modules & Interfaces
> Anchor the spec to real code shape. Prefer few deep modules over many shallow files.

| Module Name | Action (New / Modify) | Narrow Public Interface | Encapsulated Responsibilities |
| :--- | :--- | :--- | :--- |
| `example-service` | New | `execute(input): Result` | Validation, state transition, persistence |

## 5. Implementation Decisions
- Key technical choices agreed during alignment (data structures, libraries, edge-case rules).

## 6. Testing & Verification Strategy
- **Test Boundaries**: Which deep module interfaces are wrapped in integration/unit tests.
- **Local Substitutables**: In-memory DBs, fake clocks, or adapter seams used to run fast, deterministic tests.
- **Verification Commands**: Exact commands (e.g., `npm test`, `npm run typecheck`, `pytest`).

## 7. Out of Scope (Negative Decisions)
- Explicitly list what will **not** be built in this PRD and *why*, preventing scope creep by autonomous agents.
