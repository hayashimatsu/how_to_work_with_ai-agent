---
name: strict-tdd-loop
description: >-
  Use when implementing any issue or code change to enforce strict Red-Green-Refactor
  test-driven development, preventing test-cheating and ensuring reliable feedback loops.
---

# Strict TDD Loop

## Purpose in the Big Picture
This is **Stage 4 (Night Shift — AFK)**. Automated feedback loops are the ceiling of AI coding quality. Writing implementation before tests causes agents to write superficial tests that merely mirror bugs. Always instrument behavior at the module boundary **first**.

## Procedure

1. **Scoped Context Loading**
   - Read only the active `issues/ISSUE-*.md` and its `target_modules`. Do not load unrelated files.
   - Confirm the project's test and typecheck commands work before making changes.

2. **RED — Write a Failing Test First**
   - Write one test targeting the **external interface** (test boundary) of the deep module for the next DoD item.
   - Run the test runner and **confirm it fails for the expected reason** (e.g., missing behavior/module, not a syntax error).
   - **Hard Rule**: Do not create or edit production logic until you have observed the Red failure output.

3. **GREEN — Minimal Implementation**
   - Write the simplest production code that makes the failing test pass.
   - Run the test runner and confirm Green.

4. **REFACTOR & Feedback Loop Gate**
   - Check module shape: did you accidentally scatter logic into shallow helper files? Consolidate into the deep module if needed.
   - Repeat steps 2–4 for each remaining DoD item in the issue.
   - Run the **entire** verification suite (unit/integration tests, typecheck, linter). Fix every error.

5. **Atomic Handoff**
   - Commit the changes cleanly (`git commit`) and update the issue's `status` to `READY_FOR_REVIEW`.
   - Stop immediately. Never start a second issue in the same session—let `fresh-context-review` audit this commit in a clean context.
