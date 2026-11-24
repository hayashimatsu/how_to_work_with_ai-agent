---
name: architecture-first-prd
description: >-
  Use after design alignment (grilling) is complete to synthesize the shared design concept
  into an ephemeral destination PRD under issues/ that locks deep module boundaries,
  testing strategies, and out-of-scope decisions.
---

# Architecture-First PRD

## Purpose in the Big Picture
This is **Stage 2 (Day Shift — HITL)**. A PRD is a **destination document**—it defines what "done" looks like without slipping into "specs-to-code" (which ignores code structure). You must anchor the specification directly to concrete **deep modules** and **test boundaries**.

## Procedure

1. **Gather Context Without Bloat**
   - Synthesize decisions from the preceding grilling session (or, if started fresh, run a brief codebase exploration via read-only subagent first).
   - Read [prd-template.md](./references/prd-template.md) for the required document structure.

2. **Lock the Architectural Shape First**
   - Before writing user stories, propose the specific modules to create or modify.
   - Enforce **Deep Modules**: consolidate cohesive logic behind narrow, stable interfaces so callers and tests stay simple. Avoid proposing fragmented shallow files.
   - Identify **local substitutables** (e.g., in-memory DB, fake adapters at seams) so tests can run fast without external network/service dependencies.

3. **Write the Destination Document**
   - Save the output to `issues/PRD-<slug>.md` using the 7 sections in [prd-template.md](./references/prd-template.md).
   - Capture negative decisions explicitly under **Out of Scope** (with rationale) so downstream agents do not re-introduce rejected ideas.

4. **Validation & Handoff**
   - Present the proposed module map and testing boundaries concisely for human sanity-check (humans should not need to line-edit prose if alignment was already reached).
   - Note that this PRD is **ephemeral**: once all child issues pass QA, it must be deleted/closed to prevent **doc rot**.
   - Next step: start a fresh session and invoke `vertical-slice-kanban`.
