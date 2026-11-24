---
name: throwaway-ui-prototype
description: >-
  Use when designing new UI/UX flows where human visual taste is required, generating 3
  interactive throwaway variants in an isolated route before committing to production components.
---

# Throwaway UI Prototype

## Purpose in the Big Picture
UI/UX quality is multimodal and depends on **human taste**. Even with browser inspection tools, AI rarely nails visual hierarchy on the first try inside a mature codebase. Instead of iterating blindly on production components, generate fast, disposable options for human selection.

## Procedure

1. **Isolate from Production**
   - Create a temporary, **throwaway route or sandbox page** (e.g., `/prototype-<feature>`) with mock/static data.
   - **Hard Rule**: Do not refactor or pollute production components or schemas during prototyping.

2. **Generate 3 Distinct Variants**
   - Build **3 genuinely different UI approaches** (e.g., layout density, interaction flow, visual hierarchy) accessible via a simple switcher on the throwaway route.
   - Keep styling self-contained so the entire prototype can be deleted cleanly afterward.

3. **Human Visual Selection (HITL)**
   - Present the local URL/route to the user so they can click through all 3 variants and give concrete visual/UX feedback.

4. **Feed Back Into Planning & Clean Up**
   - Feed the chosen direction and refinements back into `project-bootstrap-grill` or `architecture-first-prd`.
   - Delete the throwaway route once the production vertical slice is scheduled.
