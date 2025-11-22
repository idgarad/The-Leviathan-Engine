# 📘 Operator Codex

## 🌌 Lore Layer

- **Operator as Imperial Overseer**  
  - The Operator embodies the **Imperial Eye**—an omnipresent, unseen force maintaining the cosmic order.  
  - They are the custodians of the simulation, ensuring the galaxy persists even in the absence of active Wardens.  
  - Operators are not players but administrators, wielding god-like powers to shape campaigns, enforce lore, and safeguard the Sacred Rule.  

- **Zero-Player Persistence**  
  - The engine runs as a **living simulation**—NPCs trade, factions war, and economies evolve without human intervention.  
  - Operators monitor this "dreaming galaxy," intervening only to correct imbalances or introduce events.  
  - Persistence ensures the world feels alive, with history accumulating across sessions.  

- **Multiplayer Integration**  
  - When Wardens connect, they join the ongoing simulation as active participants.  
  - Operators facilitate multiplayer by managing server state, authentication, and conflict resolution.  
  - The game is intrinsically multiplayer, but the simulation core is zero-player—players are optional guests in a persistent universe.  

---

## ⚙️ Operator Responsibilities

### 1. Server Management

- **Deployment & Maintenance**: Launch and monitor the simulation server, handling restarts, updates, and backups.  
- **Resource Allocation**: Scale compute resources for NPC ticks, world updates, and player connections.  
- **Lore Enforcement**: Ensure all systems adhere to codex rules (e.g., sovereignty decay, manufacturing loops).  

### 2. Simulation Oversight

- **Zero-Player Mode**: Run the engine with no active players, allowing NPCs to pursue goals autonomously.  
- **Event Injection**: Introduce anomalies, cult activities, or economic shocks to maintain narrative tension.  
- **Balance Tuning**: Adjust parameters (e.g., attrition rates, FTL costs) based on telemetry and codex guidelines.  
- **Impulse Management**: Issue high-weighted motivations ("Impulses") to NPCs and factions to steer campaign direction, simulating organizational directives from entities like the USO, ISD, IRS, and Imperial Throne.  
- **Diegetic Adjustments**: Communicate balance changes via patch notes framed as decrees or policies from in-lore organizations, maintaining immersion without breaking the fourth wall.  

### 3. Multiplayer Facilitation

- **Authentication & Access**: Issue Imperial Credentials for Wardens and Assistant Operators.  
- **Session Management**: Handle logins, ACLs, and department views for connected players.  
- **Conflict Resolution**: Mediate disputes, enforce Sacred Rule compliance, and manage tribunal cases.  

### 4. Admin Tools & Interfaces

- **Admin Client**: Web-based dashboard for monitoring grids, sovereignty states, and economic flows.  
- **API Endpoints**: Expose REST/WebSocket APIs for third-party clients and automation.  
- **Telemetry & Logging**: Collect metrics on command latency, NPC activity, and player actions for analysis.  

---

## 🧩 Persistence Mechanics

- **World State Persistence**: All entities (ships, stations, NPCs) are serialized to storage, surviving server restarts.  
- **Timeline Continuity**: Campaigns accumulate history—past wars, economic cycles, and Warden legacies endure.  
- **Autonomy Levels**:  
  - **Full Simulation**: NPCs operate independently, pursuing impulses and goals.  
  - **Guided Mode**: Operators can inject directives or pause for events.  
  - **Interactive**: Active players influence the simulation in real-time.  

---

## 🖥️ Client & API Architecture

- **Integrated HTML5 Client**: Unified web-based interface for all users—Wardens access department views, Assistant Operators monitor roles, and Operators manage admin dashboards and issue commands.  
- **Loosely Coupled System (LCS)**: All functionality exposed via API enables custom clients for various devices (e.g., engineering on tablet, main controls on one monitor, comms on another, navigation on cell phone). Supports end-user to many interfaces to one ship relationships, allowing multiple Wardens to control a single ship.  
- **Client Load Distribution**: Operators must monitor and balance client connections, as load can be spread across multiple sources to optimize performance and user experience.  
- **API Surface**:  
  - Public endpoints for community tools (e.g., custom scanners).  
  - Private admin APIs for server control and data export.  
- **ACL Integration**: Role-based access (Operator > Warden > Assistant > Observer) with lore-flavored error messages. Includes player-derived ACLs for shared infrastructure (e.g., system-wide Single Boosters, player-managed comm-channels, structures, coalitions), with full logging for auditing and compliance.  

---

## ⏳ Safeguarding & Compliance

- **Sacred Rule Enforcement**: Operators audit for violations, triggering fines, surrenders, or narrative consequences.  
- **Player Wellness**: Monitor for toxic behavior, provide opt-outs for horror elements, and ensure ICM principles.  
- **Narrative Integrity**: Prevent exploits that break lore (e.g., infinite manufacturing loops) through automated checks.  

---

## 📊 Telemetry & Monitoring

- **Key Metrics**: Track NPC ticks, command throughput, sovereignty changes, and player engagement.  
- **Dashboards**: Real-time views of the galaxy state, with alerts for anomalies or imbalances.  
- **Reporting**: Generate executive summaries with lore-aware narratives for campaign reviews.  

---

## 🔗 Integration with Other Codices

- **Bridge Operations**: Operators oversee ship persistence and XO autonomy.  
- **Psychology of Play**: Ensures safeguarding in multiplayer interactions.  
- **Grand Strategy**: Monitors NPC decision-making in zero-player mode.  
- **Combat Codex**: Handles automated battles and TEK/DSB triggers.  

---

*This codex defines the Operator's role as the unseen hand guiding the Leviathan Engine, blending simulation persistence with multiplayer engagement.*</content>
<parameter name="filePath">/home/idgarad/Documents/The Leviathan Engine/Docs/Codex/Operator Codex.md
