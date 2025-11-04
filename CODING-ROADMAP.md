# The Leviathan Engine - Coding Roadmap (Rust Edition)

> **NOTICE:** Instructions were accurate at time of publishing (November 2025). Verify tooling versions and APIs before implementation.

This roadmap closes out preplanning and establishes a fine-grained, lore-aligned build sequence. Sprints are grouped into week-long sub-sprints (A/B) to reinforce iterative learning, with explicit ties to the codex library, Copilot notes, and architectural guardrails (message bus first, crate boundaries, validation layers, admin ACLs).

---

## Sprint 0A (Week 1): Codex Intake & Standards Baseline
**Documents:** All codices, `lore/README.md`, main `README.md`, Copilot Notes

- Catalog glossary terms, enums, and canonical identifiers into `docs/DATA_DICTIONARY.md`
- Capture doctrine constraints (ICM, Sacred Rule, NPC sovereignty) in `docs/DEVELOPMENT_GUARDRAILS.md`
- Scaffold Cargo workspace with crates: `domain`, `protocol`, `world`, `infrastructure`, `client-admin`, `telemetry`
- Configure formatting (rustfmt), linting (clippy), pre-commit hooks, and doc generation pipeline (rustdoc + mdBook/wiki sync)
- Establish message bus abstraction crate skeleton per Copilot guidance (async channels, trait-based publishers/subscribers)

Deliverables: repo layout, data dictionary seed, guardrail doc, CI formatting checks, baseline message bus traits.

## Sprint 0B (Week 2): Toolchain, Test Harness & Snapshot Strategy
**Documents:** Psychology of Play, Operator, Copilot Notes

- Implement integration test harness crate (`tests/harness`) with ability to spawn subsystems via message bus mocks
- Define snapshot/rollback plan referencing lore (Imperial Archives) and codify in `docs/RESILIENCE_PLAN.md`
- Wire telemetry hooks (tracing) with no-op sink to ensure instrumentation consistency
- Prototype load-test harness stub (10k dummy actors) per Copilot Notes to validate message bus design

Deliverables: test harness crate, resilience plan, tracing instrumentation, load-test scaffold.

---

## Sprint 1A (Week 3): Operator Contracts & Shares Domain
**Documents:** Operator Codex, Sovereignty & Territory

- Model core structs (Operator, Clan, House, Array, Contract, Share, Dividend, TribunalCase) with Serde derives
- Implement contract lifecycle FSM (open → pledged → active → cooling → renegotiation) matching codex timelines
- Encode share/dividend rules (Imperial guarantees, sequestration for fines) with time-based accrual engine
- Provide seed fixtures representing campaign auctions and sue-for-peace events

Deliverables: `domain` crate alpha, unit tests for contract/share engines, fixture pack.

## Sprint 1B (Week 4): Governance Validation & Audit Logging
**Documents:** Sovereignty & Territory, Psychology of Play & Safeguarding

- Build validation layer enforcing NPC sovereignty (no direct player ownership), Sacred Rule compliance, contract caps
- Introduce structured audit logging (Imperial Oversight) with message bus events for infra subscribers
- Author developer-facing lore notes explaining guardrail violations and responses (e.g., forced sue-for-peace)

Deliverables: validation module, audit log publisher, documentation of enforcement flows.

---

## Sprint 2A (Week 5): Command Node Protocol & ACL Foundation
**Documents:** Bridge Operations, Combat, Copilot Notes

- Implement JSON-lines command envelope with signature, payload, metadata, officer chatter channels
- Map ACL scopes to bridge departments (Tactical, Helm, Comms, SCN, Engineering, ULM, XO) using operator roles
- Integrate validation layer to enforce ACLs before dispatching to world state (lore-consistent “Imperial Cipher”)
- Provide protocol schema documentation with examples for assistant operators

Deliverables: `protocol` crate, ACL policy structs, doc examples.

## Sprint 2B (Week 6): Message Bus Spine & Scheduler
**Documents:** Copilot Notes, Bridge Operations

- Implement central dispatcher service using message bus abstraction (Tokio select loop)
- Create tick scheduler driving command processing, world updates, telemetry pulses
- Support event replay and idempotency for snapshots
- Document event flow diagrams (“Operator order → dispatcher → world grid → telemetry return”)

Deliverables: dispatcher service, scheduler module, event flow doc in `/docs/DESIGN/dispatcher.md`.

---

## Sprint 3A (Week 7): Spatial Topology & Sovereignty Engine
**Documents:** Sovereignty & Territory

- Build multi-resolution spatial model (system → array → sector) with diegetic IDs and metadata persistence
- Implement sovereignty FSM handling contested/stewarded/fiefdom states, decay, and Imperial Eye completion triggers
- Model ISC gate throughput, bootstrap mechanics, and shares updates

Deliverables: `world` crate base, sovereignty engine tests, persistence schema drafts.

## Sprint 3B (Week 8): Snapshot Persistence & Timeline Replay
**Documents:** Sovereignty & Territory, Copilot Notes

- Introduce snapshot service (incremental diffs + full dumps) tied to Imperial Archives lore
- Support timeline replay for campaign recap and debugging; include share/dividend adjustments
- Write CLI tools for snapshot inspection and rollback

Deliverables: snapshot subsystem, CLI utilities, replay documentation.

---

## Sprint 4A (Week 9): Manufacturing & Logistics Services
**Documents:** Crafting & Manufacturing, Cargo & Storage

- Integrate `sqlx` with dual backends (SQLite dev, PostgreSQL prod) behind `StorageBackend` trait per Copilot Notes
- Model ATEC manifests, job queues, Cs tracking (threshold rule, compression overhead), tax layers, and audit trails (Operator ID, factory ID, jurisdiction)
- Implement job scheduler microservice with message bus integration and expose Data Vault handling (mass counts even when Cs rounds to zero)

Deliverables: manufacturing service crate, migrations, job scheduler, compliance logs.

## Sprint 4B (Week 10): Admin Interface (Phase I) & ACL Enforcement
**Documents:** Crafting & Manufacturing, Cargo & Storage, Bridge Operations, Psychology of Play

- Stand up `client-admin` crate (Leptos/Yew) with WebSocket connection to dispatcher
- Build admin dashboards for contract oversight, job queues, Cs utilization, sovereignty states; enforce ACLs (admin vs observer vs assistant)
- Implement authentication (Imperial Credential) and session handling with lore-driven error messages

Deliverables: admin web app alpha, ACL middleware, integration tests for permission boundaries.

---

## Sprint 5A (Week 11): Bridge Crew Simulation Core
**Documents:** Bridge Operations, Psychology of Play

- Implement officer roster, crew capacity curves, attrition debuffs, XO autonomy states
- Build department services as independent crates communicating over message bus (Tactical, Helm, Comms, Engineering, SCN, ULM)
- Encode XO state machine (logoff behavior, Emperor’s Protection, random jumps, dock/fine) with timers

Deliverables: bridge subsystem crates, behavior-driven tests.

## Sprint 5B (Week 12): Assistant Operator Controls & Monitoring
**Documents:** Bridge Operations, Copilot Notes

- Expand admin interface with department-specific views (read-only vs full control) respecting ACLs
- Instrument officer chatter telemetry for UI (“Deflector deflected shot!”)
- Provide mobile-friendly dashboards for assistant operators

Deliverables: admin UI module updates, telemetry channels, UX documentation.

---

## Sprint 6A (Week 13): Combat Stack Implementation
**Documents:** Combat, Bridge Operations

- Implement layered damage resolution (deflector, shields, armor, hull, LIH)
- Encode targeting logic (tracking vs transversal, sensor factor, dodge bursts) using codex math
- Add EW effects (jamming, spoofing, taunt) honoring crew/officer modifiers

Deliverables: combat engine crate, deterministic test suite, codex cross-reference doc.

## Sprint 6B (Week 14): TEK/DSB, Salvage & IRS Workflows
**Documents:** Combat, Sovereignty & Territory

- Implement The Emperor’s Kiss (TEK) monitoring, Distress Surrender Beacon (DSB) triggers, sue-for-peace automation
- Build salvage, ransom, IRS payout pipelines with share adjustments
- Provide admin UI panels for salvages and tribunal cases

Deliverables: surrender engine, IRS service, admin workflows.

---

## Sprint 7A (Week 15): FTL Dynamics & Navigation
**Documents:** FTL Codex, Bridge Operations

- Implement Intrinsic Field tracking, spin-up, cooldown, heat accumulation, forced jumps
- Model interdiction bubbles, emergency jumps, Imperial Eye progress tracking
- Provide instrumentation for IF metrics and navigation logs

Deliverables: navigation/FTL crate, math validation tests, telemetry integration.

## Sprint 7B (Week 16): Campaign Bootstrap & Stargate Economics
**Documents:** FTL Codex, Sovereignty & Territory, Crafting & Manufacturing, Cargo & Storage

- Simulate campaign bootstrap loop (limited ISC gate throughput, manufacturing ramp, Cs storage pressure)
- Expose admin dashboards for economic monitoring (factory utilization, Cs capacity, share payouts)
- Provide scenario scripts for campaign start/end recaps, including ATEC/Data Vault flow constraints

Deliverables: bootstrap simulation scripts, admin economic panels, docs.

---

## Sprint 8A (Week 17): Skills & Certifications Engine
**Documents:** Skill Codex, Certification Codex

- Implement skill progress curves (pre-master, post-master, generalized bonuses)
- Create certification gating with faction standings, share achievements, lore triggers
- Support meta-certification stacking (Weapons Master, Fleet Commander) with buff pipelines

Deliverables: progression engine, regression tests, serialized examples.

## Sprint 8B (Week 18): Player & NPC Integration
**Documents:** Bridge Operations, Skill Codex

- Integrate skill bonuses into bridge departments, combat, FTL, manufacturing
- Harmonize player/NPC systems (“as above, as below”) with shared components
- Provide documentation on how skills influence departments and fleets

Deliverables: integrated progression stack, documentation updates, scenario tests.

---

## Sprint 9A (Week 19): Safeguarding & Compliance Tooling
**Documents:** Psychology of Play, Operator

- Build compliance services enforcing Sacred Rule logs, NPC sovereignty audits, contract breaches
- Automate sue-for-peace notifications, tribunal escalations, fines via shares
- Provide admin compliance dashboards and alerting integrations (Prometheus/Grafana)

Deliverables: safeguarding microservice, dashboards, alert configuration.

## Sprint 9B (Week 20): Plugin & Extension Framework
**Documents:** Copilot Notes, Bridge Operations, Combat

- Define plugin API boundaries (event handlers, AI modules, economics) using traits and message bus subscriptions
- Provide example module (e.g., pirate AI) loadable at runtime
- Document extension patterns and safety constraints

Deliverables: plugin framework, sample plugin, developer guide.

---

## Sprint 10A (Week 21): Client/Admin Enhancements & Accessibility
**Documents:** Bridge Operations, Psychology of Play

- Expand admin client with scenario playback (timeline replay) and compliance actions
- Implement accessibility features (screen reader support, colorblind palettes, adjustable telemetry density)
- Provide assistant operator mobile modes with quick commands

Deliverables: admin UI enhancements, accessibility checklist, mobile layouts.

## Sprint 10B (Week 22): External API & Authentication Refinement
**Documents:** Operator, Bridge Operations

- Finalize public API surface for third-party clients (with ACL scopes)
- Harden authentication (Imperial Credential refresh, audit trails)
- Publish API reference (OpenAPI + lore annotations)

Deliverables: API spec, auth library, documentation.

---

## Sprint 11A (Week 23): Observability & Load Testing
**Documents:** Combat, FTL, Crafting & Manufacturing, Copilot Notes

- Instrument Prometheus metrics for command latency, grid load, NPC ticks, IF burn, factory throughput
- Build load-testing scenarios (10k NPCs, mass combat, manufacturing spikes)
- Generate HTML performance reports featuring lore-aware executive summaries

Deliverables: monitoring stack, load-test suites, reporting scripts.

## Sprint 11B (Week 24): Regression Automation & Time Dilation Controls
**Documents:** Combat, FTL, Psychology of Play

- Automate regression suite execution with codex fixtures (combat, FTL, manufacturing, contracts)
- Implement time dilation controls when performance thresholds breached, with diegetic messaging
- Provide CI dashboards summarizing pass/fail and lore impact

Deliverables: CI regression jobs, time dilation service, dashboards.

---

## Sprint 12A (Week 25): Documentation Sync & Tutorial Authoring
**Documents:** All Codices, `lore/README.md`

- Update codices with implementation notes, new diagrams, update notices, further reading, book recommendations
- Refresh wiki, tutorials, onboarding lessons; produce ICM-tiered walkthroughs (Individual/Group/Faction)
- Generate SVG diagrams (system architecture, command flow, FTL timelines)

Deliverables: updated codex set, tutorial series, diagram pack.

## Sprint 12B (Week 26): Campaign Starter Kit & Final Review
**Documents:** Operator, Sovereignty & Territory, Crafting & Manufacturing

- Compile campaign template pack (contracts, bootstrap checklists, share ledgers, admin scripts)
- Run end-to-end rehearsal (bootstrap → conflict → surrender → persistence) capturing metrics and lore narrative
- Publish final roadmap retrospective and next-phase planning notes

Deliverables: campaign starter kit, rehearsal report, roadmap retrospective.

---

## Sprint 13A (Week 27): NPC Lifecycle & Talent Pipeline
**Documents:** NPC Interaction Codex, Grand Strategy Codex

- Implement pool → lore → active state machine with promotion triggers, relationship depth rules, and backstory template injection
- Build vacancy fill utilities (pool % vs lore % vs active %, configurable) with telemetry hooks for audit trails
- Persist NPC metadata in shared storage with serde fixtures and regression tests covering promotion/defection paths

Deliverables: `npc` subsystem crate, promotion/vacancy test suite, fixture library for narrative tooling.

## Sprint 13B (Week 28): Administrative Impulses & Manager AI
**Documents:** Grand Strategy Codex, NPC Interaction Codex, Psychology of Play

- Implement impulse injection bus (priority, duration, scope) and manager trait adapters (economic, diplomatic, military)
- Generate plan deltas with recorded rationale, utility, risk, and constraint compliance; expose over telemetry for UI playback
- Wire impulse/audit logs into compliance service (Sacred Rule enforcement) and provide scenario tests for conflict resolution

Deliverables: impulse service, manager implementations (economic baseline), compliance integration tests, documentation of impulse workflows.

---

## Sprint 14A (Week 29): Market Ledger & Order Book Infrastructure
**Documents:** Market Managment Codex, Cargo & Storage, Sovereignty & Territory

- Implement station/regional order books with partial fills, taxation layers (Imperial, House, steward, facility), and escrow pipeline
- Model reputation pledges, underwriter guarantees, and contract metadata emissions for espionage hooks
- Provide admin and analytics feeds for market monitor (liquidity, arbitrage signals, fee anomalies) with Prometheus metrics

Deliverables: market service crate, escrow/pledge modules, monitoring dashboards, contract metadata fixtures.

## Sprint 14B (Week 30): Planetary Facilities & Skimming Detection
**Documents:** Planetary Facilities Codex, Crafting & Manufacturing, Cargo & Storage

- Simulate pre-colonial facility build chains (Terraform, Orbital, Resource Extractor, Power, Habitation, Cultural Seeds) with contract obligations
- Track Cs throughput between planetary facilities and station storage, including skimming caches and detection heuristics
- Integrate audit cadence (Imperial inspections, rival sabotage) with compliance notifications and narrative outcomes

Deliverables: planetary facility simulator, skimming detection service, audit event scripts, integration tests.

---

## Sprint 15A (Week 31): Language Engine & Naming Registry
**Documents:** Language Codex, Operator Codex

- Implement canonical naming engine with grammar templates, translation tables, phoneme flavoring, and collision/profanity safeguards
- Expose naming API for ships, locations, NPCs, and arrays with registry persistence (normalized keys, diegetic differentiators)
- Provide CLI tooling and tests for bulk name generation, plus documentation for player/community client integration

Deliverables: naming service crate, profanity/collision test harness, CLI utilities, documentation.

## Sprint 15B (Week 32): Anomalies & Necronomicon Event Hooks
**Documents:** Codex Necronomicon, Psychology of Play, Sovereignty & Territory

- Implement doomsday clock subsystem with Whispers → Shadows → Echoes → Judgment stages and persistent campaign scars
- Create anomaly generation pipeline (derelicts, cult events, ISC investigations) feeding into NPC impulses and sovereignty pressure
- Integrate monitoring/UX cues ensuring horror elements respect safeguarding rules (tone controls, opt-in toggles)

Deliverables: anomaly service, doomsday telemetry dashboards, narrative event packs, safety configuration documentation.

---

> _Stay hydrated and take breaks—creative focus and wellness are part of mission success._
