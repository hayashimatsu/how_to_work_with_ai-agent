# Codebase Design Glossary

Use this vocabulary when analyzing architecture or proposing refactors:

- **Deep Module**: A module whose **public interface is much simpler than its internal implementation**. It maximizes leverage and gives tests a single, stable boundary.
- **Shallow Module**: A module whose interface is nearly as complex as its implementation, adding indirection without hiding real complexity.
- **Interface**: Everything a caller must know to use a module safely (function signatures, types, invariants, error modes).
- **Seam**: A boundary where behavior can be swapped (e.g., for testing) without editing the module's internal code.
- **Adapter**: A concrete implementation at a seam (e.g., a production Postgres repository vs. an in-memory test repository).
- **Deletion Test**: Ask *"If I delete this wrapper/layer, does complexity actually disappear or just move elsewhere?"* If complexity disappears, the layer was shallow and should be removed or merged.
- **Gray Box**: A deep module whose interface and invariants are owned by the human maintainer, while its internal implementation can be safely delegated to AI agents.
