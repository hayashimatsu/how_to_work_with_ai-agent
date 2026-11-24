# AGENTS.md — Smart Zone Project Constitution

Welcome. Before reading files, planning, or writing code, orient yourself with how this repository operates. This document is intentionally concise so you stay inside the **Smart Zone**.

---

## 1. The Big Picture: Two-Shift Lifecycle

This project separates **human-aligned design** from **autonomous execution**:

1. **Day Shift (Human-in-the-Loop — Alignment & Shape)**
   - **Orient**: Read this file and scan `.agents/skills/` descriptions (do not load full skill files unless needed).
   - **Grill (`project-bootstrap-grill`)**: Stress-test the idea via a decision tree until human and agent share one design concept.
   - **Specify (`architecture-first-prd`)**: Lock the destination, proposed **deep modules**, testing boundaries, and explicit `Out of Scope`.
   - **Slice (`vertical-slice-kanban`)**: Break the PRD into end-to-end **tracer bullet** issues in `issues/` with `blocked_by` dependencies and `AFK`/`HITL` tags.
2. **Night Shift (Autonomous / Isolated — Build & Verify)**
   - **Implement (`strict-tdd-loop`)**: Pick **one** unblocked `AFK` issue in a fresh session. Follow Red → Green → Refactor. Commit when all checks pass.
   - **Review (`fresh-context-review`)**: Start a **new, clean session** to audit the diff against tests, architecture, and standards.
3. **Human Taste & Maintenance**
   - **QA & Feedback**: Humans verify vertical slices manually and convert defects into new `issues/` tickets (never patch blindly in a stale chat).
   - **Refactor (`improve-codebase-architecture`)**: Periodically consolidate fragmented files into deep, testable modules.
   - **Cleanup**: Delete or close completed `issues/` artifacts so outdated specs never mislead future agents (**Anti-Doc-Rot**).

---

## 2. Smart Zone Physics (Non-Negotiable)

- **100K Token / 40% Ceiling**: Attention degrades quadratically as context grows. Beyond ~100K tokens lies the **Dumb Zone**. Size every execution unit to finish comfortably under **60K tokens**.
- **Clear Over Compact (Memento Principle)**: Treat each session as stateless. Never rely on conversation compaction—its residual summary pollutes attention. Persist state in files (`issues/`, `git log`, tests), then start fresh.
- **One Session, One Atomic Goal**: Complete one issue or one lifecycle phase per session, then stop.
- **Isolate Exploration**: Delegate broad codebase searches or multi-file reads to a read-only subagent. Only bring distilled summaries (file paths, interfaces, key constraints) back into the main context.

---

## 3. Engineering Fundamentals

1. **Code Shape Over Specs-to-Code**: Specs define the destination; the codebase architecture is the battleground. Always design module boundaries explicitly.
2. **Deep Modules > Shallow Modules**: Prefer few modules with **simple, narrow interfaces** and **rich, encapsulated implementations** over dozens of tiny interdependent files. Human maintainers treat deep modules as "gray boxes"—owning the interface while delegating the internals.
3. **Vertical Slices (Tracer Bullets) > Horizontal Layers**: Never build all schemas, then all APIs, then all UI. Every early ticket must cut thin across all layers so the system is end-to-end testable immediately.
4. **Feedback Loops Are Your Ceiling**: AI output quality is capped by automated verification. Confirm tests, typecheck, and linters run before writing logic.

---

## 4. Knowledge Loading (Pull vs. Push)

- **When Implementing (Pull)**: Load only the relevant `SKILL.md` from `.agents/skills/` and only the files listed in your active issue.
- **When Reviewing (Push)**: Force-load this constitution, relevant coding standards, and the target issue/PRD into a **fresh** context alongside the `git diff`.
