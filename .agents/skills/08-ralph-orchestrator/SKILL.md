---
name: ralph-orchestrator
description: >-
  Use when automating Night Shift execution of AFK issues in fresh Smart Zone sessions,
  either sequentially (ralph-once / ralph-afk) or in parallel via Antigravity swarm/workflow.
---

# Ralph Orchestrator

## Purpose in the Big Picture
This bridges **Stage 3 (Kanban)** and **Stages 4–5 (Night Shift Execution & Review)**. Each iteration spawns a **brand-new, stateless session** (Memento principle) with only the minimum required context: current `issues/*.md` and the last 5 `git log` commits.

## Execution Modes

1. **Single Verification Pass (`ralph-once`) — Run First!**
   - Always run a single iteration under human observation before unattended loops so you can tune prompts and verify test commands.
   - Scripts: [ralph-once.ps1](./scripts/ralph-once.ps1) (Windows) or [ralph-once.sh](./scripts/ralph-once.sh) (Bash/Docker).

2. **Sequential AFK Loop (`ralph-afk`)**
   - Bounded loop (e.g., max 10 iterations) that repeatedly runs fresh sessions until `<promise>NO MORE TASKS</promise>` is detected.
   - Script: [ralph-afk.ps1](./scripts/ralph-afk.ps1).
   - **Safety**: Run unattended loops inside an isolated container/sandbox or dedicated branch—never on an unprotected main branch.

3. **Parallel DAG Execution (Antigravity `swarm` / `run_workflow` or Sandcastle)**
   - When multiple issues in `issues/` have `blocked_by: []`, follow the 4-stage pipeline:
     1. **Planner**: Identify unblocked `type: AFK` issues.
     2. **Parallel Implementers**: Spawn isolated workers (`workspace: "share"` or `"branch"` in Antigravity `swarm`, or Git Worktrees) running `strict-tdd-loop`.
     3. **Fresh-Context Reviewers**: Run `fresh-context-review` in clean sessions against each worker's diff.
     4. **Merger**: Merge approved branches sequentially and resolve any integration/typecheck conflicts.
