# The Leviathan Engine - Coding Roadmap

> **NOTICE:** All instructions in this roadmap were accurate at the time of publishing (October 2025). Software versions, APIs, and best practices may change. Always consult the official documentation for the latest updates.

> **For additional information, please see:**
> - Go Documentation: https://golang.org/doc/
> - GitHub Docs: https://docs.github.com/en
> - [Book] "The Pragmatic Programmer" by Andrew Hunt & David Thomas
> - [Book] "Go in Action" by William Kennedy

## Milestone 1: Project Initialization

- Set up Go module and project structure
- Initialize version control (GitLab/GitHub)
- Create initial README and documentation

> **For additional information, please see:**
> - Go Modules: https://blog.golang.org/using-go-modules
> - Git Best Practices: https://git-scm.com/book/en/v2
> - [Book] "Version Control with Git" by Jon Loeliger

## Milestone 2: Core Engine Foundations

- Implement JSON-lines protocol handler and shared protocol library (with schema validation and versioning)
- Build grid-based spatial partitioning system
- Set up multi-database persistence layer (PostgreSQL default, SQLite/MySQL optional)
- Implement journaling and per-grid queues for crash recovery using established libraries (e.g., BoltDB, PostgreSQL WAL, or similar)
- Create modular plugin architecture and ensure actual module/plugin implementation (not just interface)
- Integrate performance monitoring (BTOP-style)
- Implement automated testing framework and CI integration for performance/load tests

> **For additional information, please see:**
> - SQLite Docs: https://sqlite.org/docs.html
> - Go Testing: https://golang.org/pkg/testing/
> - [Book] "Go Programming Language" by Alan Donovan & Brian Kernighan

## Milestone 3: Gameplay Systems

- PlayerManager: authentication, session, persistence
- NPC/Player unified system (external agent registration for AI managers and bot clients)
- Command processing engine
- World state and geography module
- Faction/reputation system
- Item and inventory management
- Event broadcasting and messaging
- Support for module hot-swapping (restart-based)

> **For additional information, please see:**
> - Go Concurrency: https://golang.org/doc/effective_go.html#concurrency
> - [Book] "Designing Games" by Tynan Sylvester

## Milestone 4: Testing & Monitoring

- Unit tests for all core modules
- Integration tests for player/NPC/command flows
- Performance/load tests (k6, Go benchmarks)
- Real-time metrics dashboard (Prometheus/Grafana)
- Automated regression suite
- Real-world load testing with concurrent players and external agents

> **For additional information, please see:**
> - Prometheus Docs: https://prometheus.io/docs/
> - Grafana Docs: https://grafana.com/docs/
> - k6 Docs: https://k6.io/docs/
> - [Book] "Site Reliability Engineering" by Betsy Beyer et al.

## Milestone 5: Documentation & Tutorials

- Document all structs, functions, and packages
- Update docs/ARCHITECTURE.md and API.md
- Generate SVG diagrams for system/data flow
- Write step-by-step tutorials for major features
- Maintain CHANGELOG.md with educational context
- Update DATA_DICTIONARY.md for all data structures
- Ensure documentation and implementation are always in sync (no gaps)
- Provide clear API documentation for custom client support

> **For additional information, please see:**
> - Markdown Guide: https://www.markdownguide.org/
> - [Book] "Docs for Developers" by Jared Bhatti et al.

---

> **Supplemental Reading:**
> - "Clean Code" by Robert C. Martin
> - "Refactoring" by Martin Fowler
> - "Continuous Delivery" by Jez Humble & David Farley

---

## Milestone 6: Client Implementation

- Build a stock HTML5 web client for regular players and administrative tasks
- Ensure the system supports custom clients via a well-defined API
- Provide example client documentation and usage patterns

> **For additional information, please see:**
> - MDN Web Docs: https://developer.mozilla.org/en-US/docs/Web
> - [Book] "Web Development with Go" by Shiju Varghese
