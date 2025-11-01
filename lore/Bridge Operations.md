Perfect—here’s the **consolidated and regenerated Bridge Crew & Command Systems Codex**, with all the updates we’ve discussed integrated into one authoritative version. This is ready to be committed as a reference document.

---

# 📘 Bridge Crew & Command Systems Codex

## 🌌 Lore Layer
- **Bridge Crew as Core Systems**  
  - Only officers are explicitly tracked; the rest of the crew is abstracted.  
  - Officers are treated as **command modules**—human components slotted into the ship’s systems.  
  - Each officer represents a department and interprets Operator orders into crew actions.  

- **Command Node & Operator**  
  - The Operator issues doctrinal orders via the Command Node.  
  - Orders are transmitted to the ship’s **Central Mainframe**, which distributes them to officers.  
  - Lag, delay, or time dilation are explained as **crew interpretation and Command Node sync**.  

- **Executive Officer (XO)**  
  - The Operator’s proxy aboard ship.  
  - Handles routine operations, ensures orders are executed, and issues surrender if TEK/DSB is triggered.  
  - Provides a “crew discipline” buff—reduces randomness in execution.  
  - When Operators are offline, the XO has autonomy to act (see Persistence & Autonomy).  

---

## ⚙️ Department Definitions

### 1. Tactical
- **Scope**: Weapons control, targeting solutions, shield phase tuning.  
- **Buffs**: Accuracy, crit chance, tracking, shield bypass tuning.  
- **Attrition Impact**: Reduced RoF, slower phase tuning, degraded accuracy.  

### 2. Stellar Cartography & Navigation (SCN)
- **Scope**: Strategic positioning, FTL plotting, sensor mapping.  
- **Buffs**: Warp accuracy, faster course plotting, better sensor overlays.  
- **Attrition Impact**: Slower warp prep, degraded sensor resolution.  

### 3. Helm Control
- **Scope**: Real‑time ship maneuvering, evasive patterns, deflector orientation.  
- **Buffs**: Dodge chance, transversal velocity, deflector glancing blow probability.  
- **Attrition Impact**: Reduced agility, slower maneuver execution.  

### 4. Communications
- **Scope**: Sensor locks, electronic warfare, fleet coordination.  
- **Buffs**: Sensor lock stability, jamming/spoofing effectiveness, taunt success.  
- **Attrition Impact**: Increased lock times, weaker EW, reduced fleet coordination.  

### 5. Engineering
- **Scope**: Power management, repairs, shield cycling, heat dissipation.  
- **Buffs**: Energy efficiency, repair rate, shield blowout resistance.  
- **Attrition Impact**: Slower repairs, higher risk of shield failure, reduced power output.  

### 6. Environmental Support
- **Scope**: Life support, medical, habitat integrity.  
- **Buffs**: Crew survivability, reduced attrition penalties, faster recovery.  
- **Attrition Impact**: Faster morale collapse, higher crew loss rates.  

### 7. Unified Logistics Management (ULM)
- **Scope**: Inventory, munitions, supplies, cargo.  
- **Buffs**: Faster reloads, efficient resupply, reduced upkeep costs.  
- **Attrition Impact**: Slower reloads, reduced resupply efficiency.  

---

## 🧩 Crew Capacity & Scaling
- **Officer Crew Capacity**: Each officer can manage a set number of crew (e.g., 50–200).  
- **Scaling with Ship Size**:  
  - Frigates: 1 officer per department.  
  - Cruisers: Some departments may require 2 officers.  
  - Capitals: Multiple officers per department; departments may subdivide.  
- **Attrition Debuffs**:  
  - 100% crew = full bonuses.  
  - 75% crew = –10% effectiveness.  
  - 50% crew = –25% effectiveness.  
  - 25% crew = –50% effectiveness.  
  - 0% crew = officer incapacitated, department offline.  

---

## 🖥️ Views & Assistant Operators
- **Views as Interfaces**: Each department is a “view” into the ship’s systems.  
- **Loosely Coupled Paradigm**: Departments can be run on different devices (PC, phone, tablet).  
- **Assistant Operators**:  
  - Human players can connect to manage departments.  
  - Normal for capital ships to have multiple Operators.  
  - Frigates may be solo‑operated; capitals may need 3–5 Operators.  
- **Access Control Lists (ACLs)**:  
  - Define who can view vs. control each department.  
  - Example: Multiple viewers for SCN, but only one controller for Tactical.  
- **Player‑Created Clients**:  
  - Default HTML5 web client provided.  
  - API endpoints exposed for community‑built clients.  
  - Supports monitoring‑only roles (e.g., checking sensor feeds without control).  

---

## ⏳ Persistence & XO Autonomy
- **Persistent Ships**: Ships remain in runtime even when Operators log off.  
- **XO Autonomy Timeline**:  
  - **0–2 hours**: Ship executes standing orders.  
  - **2–24 hours**: XO may invoke **Emperor’s Protection** (safe zone near a star).  
  - **24–72 hours**: XO initiates random jumps to avoid detection.  
  - **72+ hours**: XO docks at nearest station → **abandoned command** → fine applied.  
- **Standing Orders**: Operators can pre‑program XO behavior (patrol, orbit, scan, defensive posture).  
- **Sue for Peace**:  
  - If Operator absent ≥ 2 hours, XO may sue for peace.  
  - IRS impounds ship at nearest starbase.  
  - Operator must pay fees to reclaim.  
- **Imperial Law**:  
  - Engaging Operatorless ships is frowned upon.  
  - Ignoring DSB or sue‑for‑peace is a severe crime.  

---

## 🧑‍💻 Technical Layer
- **Officer Buffs**: Cached per ship; recompute only when officer changes or crew attrition occurs.  
- **Command Queue**: Orders merged from multiple clients; XO resolves conflicts.  
- **ACL Enforcement**: Lightweight checks for view/control rights.  
- **Persistence**: XO autonomy modeled as a state machine (Normal → Protection → Random Jumps → Docked).  
- **Scalability**: Departments and views scale linearly with ship size.  

---

## 📚 Lore Hooks
- **“Meat modules”**: Officers as biological modules in Imperial doctrine.  
- **Factional emphasis**: Different navies emphasize different departments.  
- **Bridge chatter**: Officers provide diegetic feedback on attrition, orders, and autonomy.  
- **Cultural norms**:  
  - Capital ships with multiple Operators are standard.  
  - Abandoned command fines are a mark of shame.  
  - Emperor’s Protection is a sacred right.  

---

✅ This **Bridge Crew & Command Systems Codex** now consolidates:  
- Department definitions and officer roles.  
- Crew capacity and attrition mechanics.  
- Views, assistant operators, ACLs, and player‑created clients.  
- XO autonomy, persistence, and Imperial law.  
- Technical models for buffs, orders, and access control.  
- Lore justification for distributed command and persistence.  

---

This is the **final consolidated version**—ready to commit as the canonical reference for bridge crew and command systems.
