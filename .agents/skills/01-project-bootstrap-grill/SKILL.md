---
name: project-bootstrap-grill
description: >-
  Use when starting a new project, feature, or vague brief (e.g. client brief, meeting notes)
  to relentlessly interview the user branch-by-branch until human and agent reach a shared
  design concept before writing any specs or code.
---

# Project Bootstrap Grill

## Purpose in the Big Picture
This is **Stage 1 (Day Shift — HITL)**. Do not rush to generate a plan or write code—premature plans cause misalignment. Your goal is to reach a **shared understanding (design concept)** with the human by resolving every hidden assumption along the design tree.

## Procedure

1. **Isolate Codebase Exploration**
   - If the repository already contains source files, dispatch a **read-only subagent** to map existing modules, tech stack, data models, and conventions.
   - Keep only the distilled summary in your main context so you stay in the Smart Zone.

2. **Build and Walk the Design Tree**
   - Identify unresolved branches in dependency order:
     1. **Core behavior & contracts**: Inputs, outputs, user/system interactions, and data flow.
     2. **Edge cases & history**: Failure modes, concurrency, retroactivity/backfills, permissions.
     3. **Architectural shape**: Which existing or new **deep modules** own this logic.
     4. **Verification boundary**: How correctness will be proved via automated tests and local substitutables.
     5. **Explicit exclusions**: What is intentionally out of scope for now.

3. **Interview Rules (Strict)**
   - **Ask ONE question per turn.** Never dump a numbered list of questions.
   - **Always provide a Recommended Answer** with a brief rationale (e.g., *"Recommendation: Skip retroactive backfill for now because..."*).
   - Use plain conversational text rather than rigid multi-choice popups unless the user prefers structured choices.
   - Adapt depth to the user: if the user asks to speed up or accept recommendations in bulk, summarize the remaining branches clearly and confirm before proceeding.

4. **Exit Criterion**
   - Stop interviewing only when all critical branches are resolved and confirmed.
   - Explicitly declare: *"Shared design understanding is complete. Ready to run `architecture-first-prd` to lock the destination document."*
   - Never write implementation code or generate a PRD without user confirmation.
