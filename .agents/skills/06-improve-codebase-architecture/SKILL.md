---
name: improve-codebase-architecture
description: >-
  Use when a codebase feels fragmented, hard to test, or error-prone for AI agents to
  identify shallow modules and propose consolidating them into deep, testable modules.
---

# Improve Codebase Architecture

## Purpose in the Big Picture
*Bad codebases make bad agents.* When AI agents work unguided, they tend to scatter logic across many small, interdependent **shallow modules**, making navigation and testing brittle. This skill periodically reshapes the codebase into **deep modules**—giving AI clean test boundaries and giving humans a manageable "gray-box" mental model.

## Procedure

1. **Load Design Vocabulary**
   - Read [codebase-design-glossary.md](./references/codebase-design-glossary.md) so all analysis uses precise terms (`Module`, `Interface`, `Seam`, `Adapter`, `Deletion Test`).

2. **Isolated Codebase Scan**
   - Dispatch a **read-only subagent** to inspect high-friction directories, recent commits, or areas with low test coverage.
   - Look for:
     - Clusters of tightly coupled shallow files that always change together.
     - Business logic lacking tests because it requires heavy mocking.
     - Pass-through layers that fail the **Deletion Test** (if deleted, complexity actually drops).

3. **Propose Deepening Candidates**
   - Rank 2–4 concrete refactoring candidates by impact (*Strong*, *Worth Exploring*, *Speculative*).
   - For each candidate, show:
     - **Current Friction**: Coupled files / missing test boundary.
     - **Proposed Deep Module**: The narrow public interface + encapsulated internals.
     - **Test Boundary**: How it becomes testable without mocks (e.g., via in-memory adapter or local DB).

4. **Align Before Refactoring**
   - Present the candidates to the user and use `project-bootstrap-grill` if interface trade-offs need alignment before creating PRD/issues for the refactor.
