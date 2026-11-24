---
name: vertical-slice-kanban
description: >-
  Use after a PRD is written to decompose it into independently grabbable, end-to-end
  tracer bullet issues in issues/ with DAG blocking dependencies and AFK/HITL labels.
---

# Vertical Slice Kanban

## Purpose in the Big Picture
This is **Stage 3 (Day Shift — HITL)**. It translates the **destination (PRD)** into the **journey (Kanban backlog)**. Well-sliced issues allow Night Shift agents to work autonomously in parallel while staying comfortably inside the Smart Zone.

## Core Decomposition Rules

1. **Tracer Bullets Over Horizontal Layers**
   - **Forbidden**: "Issue 1: All DB schemas", "Issue 2: All backend services", "Issue 3: All UI". Horizontal slicing delays end-to-end feedback until the final phase.
   - **Required**: `ISSUE-001` must be a thin **vertical slice** cutting across every layer (minimal schema/state + core module + minimal observable UI/CLI/API output) so it can be tested and demoed immediately.

2. **Smart Zone Sizing (< 60K Tokens)**
   - Every issue must be small enough for a fresh agent to explore target files, run TDD, pass typechecks, and commit within **60K tokens**. Split oversized slices vertically.

3. **DAG Dependencies for Parallelism**
   - Use `blocked_by` arrays instead of rigid sequential phases. Any issues with `blocked_by: []` (or whose blockers are resolved) can be grabbed in parallel across separate worktrees/sandboxes.

4. **HITL vs. AFK Classification**
   - Tag `type: AFK` for self-contained backend/logic/testable slices.
   - Tag `type: HITL` for tasks requiring human taste, visual UI selection, or architectural judgment.

## Procedure

1. Read the target `issues/PRD-*.md` and [issue-template.md](./references/issue-template.md).
2. Draft the **slice list + DAG summary** first and present it to the user for approval (explicitly highlight why `ISSUE-001` is a true vertical slice).
3. After approval, write each ticket as `issues/ISSUE-00X-<slug>.md` using [issue-template.md](./references/issue-template.md).
4. Next step: run a single verification pass (`ralph-once` / `strict-tdd-loop`) before launching parallel or AFK execution.
