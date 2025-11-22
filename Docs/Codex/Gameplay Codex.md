# 📜 Gameplay Codex

## 🌌 Lore Layer

- **Persistent Emergent Universe**: The Leviathan Engine simulates a living galaxy where NPCs and players coexist in a shared, ever-evolving world. Events unfold continuously, economies fluctuate, and factions pursue goals without human intervention, creating a sense of a "dreaming galaxy" that players can join at any time.
- **Equal Access Principle**: NPCs and players operate under the same rules, with access to identical tools, information, and mechanics. This ensures fairness—players aren't "gods" but participants in a balanced ecosystem, where NPC actions can surprise and challenge just as player actions can.
- **Single Ship Command Focus**: Gameplay centers on commanding individual ships, with distributed crew roles allowing for solo or cooperative control. This emphasizes tactical depth, crew management, and ship-specific strategies, while integrating into larger fleet or universe-scale narratives.

---

## ⚙️ Design Layer

### Core Inspirations

- **Dwarf Fortress Worldgen & Simulation**: Procedural generation of rich, interconnected worlds with emergent stories. Economies, politics, and disasters arise from simulation rules, not scripts—factions form alliances, wars erupt over resources, and individual NPCs have lifecycles and motivations.
- **Sci-Fi Expectations from Classics**:
  - **Eve Online**: Player-driven economies, sovereignty conflicts, and large-scale PvP/PvE in a persistent universe.
  - **Elite**: Open-world exploration, trading, and ship customization in a vast, procedurally generated galaxy.
  - **Star Trek Online**: Fleet coordination, diplomacy, and episodic missions in a lore-rich sci-fi setting.
  - **Trade Wars 2020**: Strategic trading, piracy, and empire-building through economic warfare.
  - **VGA Planets**: Turn-based strategy with resource management, diplomacy, and multiplayer competition.
  - **X4**: Realistic ship operations, station management, and emergent faction dynamics in a living economy.

### Key Principles

- **Emergent Gameplay**: Systems interact to create unexpected outcomes—e.g., a trade war sparked by NPC decisions cascades into player opportunities.
- **Balanced Agency**: Players command ships with the same capabilities as NPCs (e.g., FTL, combat, crafting), ensuring competitive parity. No "player-only" advantages; success comes from skill, strategy, and timing.
- **Single Ship Immersion**: Each ship is a microcosm—crew attrition, department management, and XO autonomy create depth. Players can solo small ships or coordinate fleets, but individual command remains central.
- **Persistent Participation**: The universe runs 24/7; players log in to influence ongoing events, not restart scenarios. NPCs continue goals, maintaining continuity.
- **Lore-Integrated Mechanics**: All systems tie to the Imperial narrative—e.g., sovereignty as "divine mandate," markets as "contract veins," combat as "doctrinal clashes."

### Player Experience Goals

- **Exploration & Discovery**: Procedurally generated systems encourage charting unknown space, uncovering anomalies, and adapting to emergent threats.
- **Economic Depth**: Trading, manufacturing, and espionage create layered strategies, with player actions rippling through the economy.
- **Social & Political Play**: Coalitions, diplomacy, and reputation systems allow for alliances, betrayals, and faction wars.
- **Tactical Command**: Real-time ship control with crew buffs, attrition, and autonomy options for varied engagement levels.
- **Narrative Emergence**: Stories arise from player/NPC interactions—e.g., a player's piracy sparks an NPC crusade, leading to epic conflicts.

### NPC Decision-Making and Administrative Impulses

#### Core Concepts and Roles

- **Identity**: Unique agent with public titles and private intent.
- **Authority**: Decision rights and jurisdictions over domains (economy, military, diplomacy, espionage).
- **Faction Membership**: Primary faction, coalitions, liege/vassal links; claims and succession.
- **Capabilities**: Skills, traits, modifiers; learned doctrines/policies.
- **Resources**: Personal vs. controlled assets, stocks/flows, logistics capacity.
- **Posture & Doctrine**: Strategic vectors and preferred operational styles.
- **Reputation**: Global prestige/infamy plus bilateral opinions, trust, fear, grievances.
- **Relationships**: Typed graph edges (family, patronage, rivalry, alliance, debt, secret).
- **Knowledge**: Intel facts/rumors with confidence, secrets/blackmail, fog-of-war.
- **Risk & Ethics**: Risk appetite, honor/mercy/corruption, taboo boundaries.
- **Goals & Constraints**: Multi-horizon objectives with legal, cultural, and treaty constraints.
- **Plans & Rationale**: Chosen actions with utility/risk/confidence and explanations for telemetry/UI.
- **Lifecycle State**: Pool, Lore, Active; promotion and vacancy handling integrated.
- **Administrative Impulses**: High-priority, time-bounded diegetic mandates that steer behavior.

#### Minimal API Schema (Manager-Agnostic)

```json
{
  "npc": {
    "id": "npc_001",
    "identity": {
      "name": "Dame Elira Keitel",
      "titles": ["Spymaster of Keitel"],
      "public_persona": "Reserved, methodical",
      "private_intent": "Contain House Veyra"
    },
    "authority": {
      "roles": [{"role": "Spymaster", "scope": "House Keitel"}],
      "decision_rights": ["appoint_agents", "authorize_ops", "allocate_spy_budget"]
    },
    "factions": {"primary": "House Keitel", "coalitions": ["Northern Compact"]},
    "capabilities": {
      "skills": {"intrigue": 92, "diplomacy": 68, "stewardship": 54, "warfare": 35},
      "traits": ["Calculating", "Loyal"], "modifiers": [{"name": "Networked", "value": 0.1}]
    },
    "resources": {
      "personal": {"gold": 1200, "influence": 45},
      "controlled": {"agents": 14, "spy_network": 65, "safehouses": 6}
    },
    "posture": {"vector": {"covert": 0.8, "overt": 0.2}, "doctrines": ["Infiltration"]},
    "reputation": {
      "global": {"prestige": 38, "legitimacy": 72, "infamy": 12},
      "bilateral": {"House Veyra": {"opinion": -35, "trust": 20, "fear": 55}}
    },
    "relationships": {
      "edges": [
        {"to": "npc_002", "type": "rival", "weight": 0.7},
        {"to": "npc_010", "type": "mentor", "weight": 0.5}
      ]
    },
    "claims": [{"type": "title", "target": "Master of Intelligence", "strength": 0.4}],
    "knowledge": {
      "intel": [{"subject": "veyra_route", "type": "estimate", "confidence": 0.6}],
      "secrets": [{"subject": "npc_002_affair", "leverage": 0.8, "owner": "npc_001"}]
    },
    "risk_ethics": {"risk": 0.65, "honor": 0.3, "corruption": 0.2, "mercy": 0.4},
    "goals": [
      {"id": "g1", "type": "diplomatic_block", "target": "House Veyra", "priority": 0.8, "horizon": "short"}
    ],
    "constraints": {"truces": [{"with": "House Veyra", "until": 1205}], "taboos": ["Assassination of nobles"]},
    "plans": [
      {
        "goal": "g1",
        "actions": [{"type": "forge_alliance", "with": "Northern Compact"}],
        "utility": 0.72, "risk": 0.35, "confidence": 0.68,
        "rationale": "Allied pressure yields leverage without violating truce."
      }
    ],
    "observability": {"public_stance": "Neutral", "deception": 0.3},
    "state": "active"
  }
}
```

#### Administrative Impulses

```json
{
  "impulse": {
    "id": "imp_mineral_x_oversupply",
    "type": "market_demand",
    "scope": {"faction": "House Keitel"},
    "objective": {"kind": "acquire_resource", "resource": "Mineral X", "amount": 100000},
    "priority": 1.0,
    "duration": {"start": "1204-05", "end": "1204-09"},
    "justification": "Oversupply has crashed prices; Keitel mandates stockpiling to stabilize markets.",
    "constraints": ["no_open_war"],
    "effects": {"demand_multiplier": 3.0, "price_bias": -0.25},
    "decay": {"mode": "linear", "half_life_days": 30}
  }
}
```

- **Injection Rule**: Impulses become top-priority goals across targeted NPCs/factions. Managers bias utility/scoring accordingly.
- **Conflict Handling**: If an impulse violates constraints/ethics, managers seek alternative means (embargo, buy orders, covert procurement).
- **Observability**: Impulse can be public (edict) or covert (sealed directive). Public impulses affect reputation and market behavior.

#### Rust Reference Implementation

Includes data structures, manager traits, impulse handling, vacancy/promotion helpers, action vocabulary, evaluation hooks, and integration notes. (Full code examples from Grand Strategy Codex integrated here for completeness.)

#### Action Vocabulary and Evaluation

- **Standard Actions**: Economy (invest, sanction), Military (mobilize, raid), Diplomacy (ally, ultimatum), Espionage (infiltrate, sabotage).
- **Evaluation**: Utility (goal alignment), Risk (detection), Constraints (treaties), Ethics veto.

#### Integration with NPC Interaction Codex

- Lifecycle alignment, vacancy symmetry, espionage vectors, administrative control.

---

## 🔗 Integration with Other Codices

- **Bridge Operations**: Embodies single ship command with crew and XO mechanics.
- **Market Management**: Drives economic simulation and emergent trading.
- **Grand Strategy**: Ensures NPC equal access and persistent faction goals.
- **Combat Codex**: Provides tactical depth for ship-vs-ship engagements.
- **Psychology of Play**: Safeguards player wellness in a competitive, emergent universe.

---

*This codex defines the philosophical and mechanical foundation of the Leviathan Engine, blending simulation depth with sci-fi adventure for a universe where every action matters.*</content>
<parameter name="filePath">/home/idgarad/Documents/The Leviathan Engine/Docs/Codex/Gameplay Philosophy Codex.md
