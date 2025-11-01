# The Leviathan Engine - Coding Roadmap (Rust Edition)

> **NOTICE:** All instructions in this roadmap were accurate at the time of publishing (October 2025). Software versions, APIs, and best practices may change. Always consult the official documentation for the latest updates.

## Educational Sprint Roadmap

This roadmap is structured as a series of small, focused sprints. Each sprint is designed to teach Rust fundamentals, engine architecture, and best practices, while incrementally building the Leviathan Engine. Every phase includes learning objectives, practical coding steps, and educational context.

---

### Phase 1: Rust Fundamentals & Project Setup (Sprint 1)
**Learning Objectives:**
- Understand Rust project structure, Cargo, and basic syntax
- Practice version control and documentation

**Steps:**
1. Set up Cargo workspace and project
2. Initialize GitLab/GitHub repositories
3. Write a basic README and project overview
4. Create a simple "Hello World" server in Rust
5. Document every function, struct, and module

---

### Phase 2: Protocols & Data Flow (Sprint 2)
**Learning Objectives:**
- Learn about JSON-lines protocol, schema validation, and network basics
- Explore Rust's serde, networking, and error handling libraries

**Steps:**
1. Implement a JSON-lines protocol handler using serde
2. Build a shared protocol library with schema validation
3. Write tests for protocol parsing and error handling
4. Document protocol design and rationale

---

### Phase 3: Spatial Partitioning & Persistence (Sprint 3)
**Learning Objectives:**
- Understand grid-based world partitioning and database integration
- Learn Rust database crates (diesel, sqlx), PostgreSQL, and SQLite basics

**Steps:**
1. Build a grid-based spatial partitioning system
2. Set up multi-database persistence (PostgreSQL, SQLite)
3. Implement journaling and per-grid queues for crash recovery
4. Write tests for grid and persistence logic
5. Document data flow and recovery strategies

---

### Phase 4: Default HTML5 Client & Admin Tools (Sprint 4)
**Learning Objectives:**
- Build an initial HTML5 web client (using WASM) for admin/data entry and early testing
- Integrate basic forms for world generation, faction management, and test data population
- Practice Rust web development, client-server patterns, and WASM integration

**Steps:**
1. Develop a minimal HTML5 client for admin and data entry tasks (Yew, Leptos, or Sycamore)
2. Add forms for world generation, faction creation, and content management
3. Use the client to populate test data and validate engine features
4. Document client setup, extensibility, and integration with backend APIs

---

### Phase 5: Modular Design & Plugin Architecture (Sprint 5)
**Learning Objectives:**
- Learn Rust traits, modular design, and plugin patterns
- Practice hot-swapping and module management

**Steps:**
1. Create a modular plugin architecture using Rust traits and dynamic loading
2. Implement a sample module (e.g., a simple command)
3. Integrate plugin loading/unloading
4. Document module interface and plugin lifecycle

---

### Phase 6: Gameplay Systems & Concurrency (Sprint 6)
**Learning Objectives:**
- Explore Rust concurrency (async/await, tokio, channels) and gameplay logic
- Build unified player/NPC systems and command processing

**Steps:**
1. Implement PlayerManager (auth, session, persistence)
2. Build unified NPC/Player system (as above, as below)
3. Develop command processing engine
4. Add world state, geography, and faction modules
5. Document concurrency patterns and gameplay architecture

---

### Phase 7: Testing, Monitoring & Performance (Sprint 7)
**Learning Objectives:**
- Learn Rust testing, benchmarking, and performance monitoring
- Integrate Prometheus, Grafana, and load testing tools

**Steps:**
1. Write unit and integration tests for all modules (cargo test)
2. Set up performance/load tests (k6, Rust benchmarks)
3. Integrate Prometheus metrics and Grafana dashboards
4. Build automated regression suite
5. Document testing philosophy and monitoring setup

---

### Phase 8: Documentation, Tutorials & Educational Content (Sprint 8)
**Learning Objectives:**
- Practice technical writing, API documentation, and tutorial creation
- Ensure code and docs are always in sync

**Steps:**
1. Document all structs, functions, and modules (rustdoc)
2. Update docs/ARCHITECTURE.md, API.md, and DATA_DICTIONARY.md
3. Generate SVG diagrams for system/data flow
4. Write step-by-step tutorials for major features
5. Maintain CHANGELOG.md with educational context

---

### Phase 9: Extensible API & Advanced Client Features (Sprint 9)
**Learning Objectives:**
- Expand the HTML5 client with advanced features for gameplay and administration
- Design and document APIs to enable community-developed custom clients
- Practice Rust web development, client-server patterns, and WASM integration

**Steps:**
1. Enhance the HTML5 client with advanced gameplay and admin tools
2. Integrate additional features for in-game management and extensibility
3. Concurrently design and document APIs for external/custom clients (expectation: most users will build their own)
4. Provide example client documentation, usage patterns, and extensibility guidelines
5. Document client-server interaction, authentication, and extensibility

---

> _This roadmap is designed to be followed as a course. Each sprint builds on the last, teaching Rust and engine principles through hands-on development. Update as new features and educational needs arise._
