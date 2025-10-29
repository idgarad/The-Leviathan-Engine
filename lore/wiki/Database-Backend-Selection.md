# Database Backend Selection

> **Update Notice:** Accurate as of October 29, 2025. This page documents the approach for supporting both SQLite and PostgreSQL in development and production environments.

## Philosophy
- The engine supports both SQLite and PostgreSQL backends for maximum flexibility, portability, and scalability.
- Developers and CI/CD pipelines can test both backends concurrently by planning for a runtime switch.

## Implementation Overview
- All database operations are abstracted behind a common interface.
- The backend is selected at runtime via configuration or environment variable (e.g., `DB_BACKEND=sqlite` or `DB_BACKEND=postgres`).
- Both backends should be tested in development environments to ensure compatibility and performance.

## Usage
- Set the desired backend in your configuration before starting the engine.
- Run automated tests and benchmarks against both backends.
- Document any backend-specific features, limitations, or migration steps in this wiki.

## Further Reading
- [Go Database/sql Documentation](https://pkg.go.dev/database/sql)
- [SQLite Documentation](https://www.sqlite.org/docs.html)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)

---
Update this page as backend support evolves or new features are added.