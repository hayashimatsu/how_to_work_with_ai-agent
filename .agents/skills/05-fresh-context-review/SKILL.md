---
name: fresh-context-review
description: >-
  Use after an implementer commits an issue, in a brand-new clean session with pushed
  project standards, to audit tests first and then code quality, architecture, and spec compliance.
---

# Fresh-Context Review

## Purpose in the Big Picture
This is **Stage 5 (Night Shift — AFK)**. An agent reviewing its own work inside the same implementation session is already near the Dumb Zone and biased by prior reasoning. Review must happen in a **fresh, zero-history context** (ideally on your highest-reasoning model) with standards **pushed** directly into the prompt.

## Required Inputs (Push Context)
Ensure the following are loaded before inspecting code:
- `AGENTS.md` (and any project-specific coding standards)
- The active `issues/ISSUE-*.md` (plus `issues/PRD-*.md` if present)
- The commit diff (`git show HEAD` or branch diff)

## Audit Order (Strict)

1. **Test Validity & Anti-Cheat Audit (First!)**
   - Inspect new/modified tests before production code.
   - Verify tests exercise the **external boundary** of deep modules with real or local-substitutable dependencies—not mocked internal functions that merely mirror implementation bugs.
   - Confirm every DoD item in the issue has a corresponding assertion.

2. **Architecture & Module Shape**
   - Check whether the change respects **Deep Module** boundaries or introduced fragmented shallow files and tangled dependencies.
   - Verify the change delivers a complete vertical slice rather than half-wired horizontal layers.

3. **Standards, Edge Cases & Correctness**
   - Audit error handling, null/boundary inputs, security constraints, and adherence to project conventions.
   - Re-verify or inspect results of test and typecheck commands.

## Output Verdict
- If all checks pass:
  - Summarize verified behaviors concisely and output `<review>APPROVED</review>`.
- If any issue is found:
  - List each finding with exact **file path, line number, and concrete fix required**.
  - Output `<review>CHANGES_REQUESTED</review>`. Do not fix it in this session; hand back to a fresh Implementer session.
