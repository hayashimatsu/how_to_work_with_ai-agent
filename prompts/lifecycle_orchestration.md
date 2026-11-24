# Lifecycle Orchestration Playbook

Use these prompts to orient new agents, transition between **Day Shift (HITL)** and **Night Shift (AFK)** phases, and keep every session inside the Smart Zone.

---

## Stage 0: New Agent Onboarding (Big-Picture Orientation)

**When to use**: Starting work with a new agent instance on this repository.

```text
Read `AGENTS.md` first as your operating constitution, and scan the YAML frontmatter (`name`, `description`) of all skills in `.agents/skills/`—do not load full `SKILL.md` bodies yet.

Next, dispatch a read-only exploration subagent to inspect the project structure and current `issues/` backlog.
Report back concisely (under 150 words):
1. The core architectural and Smart Zone rules governing this project.
2. Which lifecycle stage the project is currently in, and which skill you recommend invoking next.
```

---

## Stage 1: Day Shift — Idea Alignment (`project-bootstrap-grill`, HITL)

**When to use**: Starting a new project or feature from a rough idea, client brief, or meeting notes.

```text
Start from a clean context. Load `.agents/skills/01-project-bootstrap-grill/SKILL.md`.

Here is the initial brief / goal:
[Paste brief, notes, or transcript here]

Follow the skill strictly: explore the codebase via subagent if files exist, then walk down the design tree asking ONE question at a time with your recommended answer. Do not write specs or code until we reach a shared understanding.
```

---

## Stage 2: Day Shift — Destination Spec (`architecture-first-prd`, HITL)

**When to use**: Grilling is complete and key design decisions are aligned.

```text
Design alignment is complete. Load `.agents/skills/02-architecture-first-prd/SKILL.md` and its reference template.

Synthesize our agreed design concept into a destination PRD under `issues/PRD-<slug>.md`. Pay special attention to defining Deep Modules (narrow interfaces, encapsulated internals), Testing Boundaries with local substitutables, and an explicit Out of Scope section.
```

---

## Stage 3: Day Shift — Vertical Slice Kanban (`vertical-slice-kanban`, HITL)

**When to use**: PRD is ready and needs to be decomposed into parallelizable, Smart-Zone-sized tasks.

```text
Start a fresh session. Load `.agents/skills/03-vertical-slice-kanban/SKILL.md` and read `issues/PRD-<slug>.md`.

Propose a vertical-slice breakdown and dependency DAG before creating issue files so I can verify:
1. `ISSUE-001` is a true end-to-end Tracer Bullet (not a horizontal schema-only or backend-only task).
2. Each issue can be completed by a single agent well within 60K tokens.
3. Independent issues have `blocked_by: []` for parallel execution, and `type` is accurately tagged `AFK` or `HITL`.
```

---

## Stage 4: Night Shift — Autonomous Implementation (`strict-tdd-loop`, AFK)

**When to use**: Executed per-issue in a fresh session (manually or via `08-ralph-orchestrator` / `swarm` / `run_workflow`).

```text
You are operating in a fresh Smart Zone session. Follow `AGENTS.md`.

1. Inspect `issues/*.md` and the last 5 commits (`git log -n 5 --oneline`).
2. If all unblocked `type: AFK` issues are complete, output `<promise>NO MORE TASKS</promise>` and stop.
3. Otherwise, select ONE unblocked `type: AFK` issue (priority: Critical Bug > Dev Infra > Tracer Bullet > Feature/Polish).
4. Load `.agents/skills/04-strict-tdd-loop/SKILL.md` and implement the issue via strict Red-Green-Refactor.
5. Verify all tests, typechecks, and linters pass, commit atomically, update the issue status to `READY_FOR_REVIEW`, and stop immediately.
```

---

## Stage 5: Night Shift — Fresh-Context Review (`fresh-context-review`, AFK)

**When to use**: Immediately after an Implementer commits, in a **new, clean session** (ideally using a high-reasoning model).

```text
You are an independent Fresh-Context Reviewer. Your context is clean and unbiased.

Force-load (Push):
- `AGENTS.md`
- `.agents/skills/05-fresh-context-review/SKILL.md`
- The target `issues/ISSUE-*.md` (and `issues/PRD-*.md` if present)

Inspect `git show HEAD` (or the branch diff). Audit tests first (anti-cheat & boundary coverage), then architecture (deep modules & vertical slice integrity), then coding standards. Output `<review>APPROVED</review>` or `<review>CHANGES_REQUESTED</review>` with exact file/line findings.
```

### Stage 5b: Handling `<review>CHANGES_REQUESTED</review>`

```text
Start a fresh Implementer session. Load `.agents/skills/04-strict-tdd-loop/SKILL.md` and read only the target issue plus the reviewer's findings below:
[Paste reviewer findings]

Fix each finding using TDD, verify all checks pass, commit, and set status back to `READY_FOR_REVIEW`.
```

---

## Stage 6: Human QA, Defect Capture & Anti-Doc-Rot Cleanup (HITL)

**When to use**: After automated review passes and a human manually tests the vertical slice.

- **If defects or UX tweaks are found**: Do NOT patch in a long chat. Create a new `issues/ISSUE-XXX-<slug>.md` (tagged `AFK` or `HITL`, blocking downstream work if needed) and feed it back into Stage 4.
- **Once the slice/feature passes human QA**:

```text
Human QA passed. To prevent Doc Rot from misleading future agents:
1. Delete completed `issues/ISSUE-*.md` files (and the `issues/PRD-*.md` once all its child issues are done).
2. Check if `AGENTS.md` needs any minimal architectural update (keep it concise).
3. Commit the cleanup (`chore: remove completed ephemeral specs`) so code and tests remain the single source of truth.
```
