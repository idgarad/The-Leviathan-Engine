**Organizing Codex for NPC Decision API**

Alright, I need to finalize the codex with a title that focuses on the administrative impulses in the NPC decision API. It'll include Rust examples along with some docs, but nothing too long. I’m thinking of using markdown for clearer presentation — bold headings and lists to make it easier to digest. I’ll include the necessary structs and traits, like manager handling impulses, promotion, and vacancy. Data schema and JSON snippets will be included too. I’ll keep it between 6 and 8 sections for clarity. Let’s get started!
# Codex of grand strategy npc decision and administrative impulses

This codex defines the fundamental, manager-agnostic data model and API for Active NPCs in a grand strategy environment, integrated with administrative Impulses for diegetic narrative and market steering. It supports faction leadership, coalition staffing, espionage, diplomacy, warfare, and economics, drawing lessons from Civilization, Europa Universalis, and Crusader Kings while preserving your NPC Interaction Codex lifecycle.

---

## Core concepts and roles

- **Identity:** Unique agent with public titles and private intent.
- **Authority:** Decision rights and jurisdictions over domains (economy, military, diplomacy, espionage).
- **Faction membership:** Primary faction, coalitions, liege/vassal links; claims and succession.
- **Capabilities:** Skills, traits, modifiers; learned doctrines/policies.
- **Resources:** Personal vs. controlled assets, stocks/flows, logistics capacity.
- **Posture & doctrine:** Strategic vectors and preferred operational styles.
- **Reputation:** Global prestige/infamy plus bilateral opinions, trust, fear, grievances.
- **Relationships:** Typed graph edges (family, patronage, rivalry, alliance, debt, secret).
- **Knowledge:** Intel facts/rumors with confidence, secrets/blackmail, fog-of-war.
- **Risk & ethics:** Risk appetite, honor/mercy/corruption, taboo boundaries.
- **Goals & constraints:** Multi-horizon objectives with legal, cultural, and treaty constraints.
- **Plans & rationale:** Chosen actions with utility/risk/confidence and explanations for telemetry/UI.
- **Lifecycle state:** Pool, Lore, Active; promotion and vacancy handling integrated.
- **Administrative impulses:** High-priority, time-bounded diegetic mandates that steer behavior.

---

## Minimal api schema (manager-agnostic)

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

---

## Administrative impulses

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

- **Injection rule:** Impulses become top-priority goals across targeted NPCs/factions. Managers bias utility/scoring accordingly.
- **Conflict handling:** If an impulse violates constraints/ethics, managers seek alternative means (embargo, buy orders, covert procurement).
- **Observability:** Impulse can be public (edict) or covert (sealed directive). Public impulses affect reputation and market behavior.

---

## Rust reference implementation

### Data structures

```rust
// Cargo.toml: serde = { version = "1", features = ["derive"] }, serde_json = "1", bitflags = "2"

use serde::{Deserialize, Serialize};
use std::collections::HashMap;

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum NpcState { Pool, Lore, Active }

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Identity {
    pub name: String,
    pub titles: Vec<String>,
    pub public_persona: String,
    pub private_intent: Option<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct RoleGrant {
    pub role: String,
    pub scope: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Authority {
    pub roles: Vec<RoleGrant>,
    pub decision_rights: Vec<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Capabilities {
    pub skills: HashMap<String, i32>,   // e.g., intrigue: 92
    pub traits: Vec<String>,            // e.g., "Calculating"
    pub modifiers: HashMap<String, f32> // e.g., "Networked": 0.1
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Resources {
    pub personal: HashMap<String, i64>,  // gold, influence
    pub controlled: HashMap<String, i64> // agents, fleets, provinces
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Posture {
    pub vector: HashMap<String, f32>,   // covert: 0.8, overt: 0.2
    pub doctrines: Vec<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Bilateral {
    pub opinion: i32,   // -100..100
    pub trust: i32,     // 0..100
    pub fear: i32,      // 0..100
    pub grievances: Vec<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Reputation {
    pub global: HashMap<String, i32>, // prestige, legitimacy, infamy
    pub bilateral: HashMap<String, Bilateral>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct RelationshipEdge {
    pub to: String,    // target NPC or faction id
    pub kind: String,  // family, rival, alliance, debt, secret
    pub weight: f32,   // 0..1 intensity
    pub freshness: f32 // 0..1 recency
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct KnowledgeItem {
    pub subject: String,
    pub kind: String,      // fact, estimate, rumor, secret
    pub confidence: f32,   // 0..1
    pub owner: Option<String>,
    pub leverage: Option<f32>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct GoalItem {
    pub id: String,
    pub kind: String,     // economic_siphon, diplomatic_block, acquire_resource, etc.
    pub target: Option<String>,
    pub priority: f32,    // 0..1
    pub horizon: String,  // short, mid, long
    pub metrics: HashMap<String, f32>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ConstraintSet {
    pub truces: Vec<(String, i32)>, // with, until_year
    pub laws: Vec<String>,
    pub taboos: Vec<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct PlanAction {
    pub kind: String, // infiltrate, embargo, buy_order, ally, mobilize
    pub target: Option<String>,
    pub params: HashMap<String, String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Plan {
    pub goal_id: String,
    pub actions: Vec<PlanAction>,
    pub utility: f32,
    pub risk: f32,
    pub confidence: f32,
    pub rationale: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Observability {
    pub public_stance: String,
    pub deception: f32,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Npc {
    pub id: String,
    pub state: NpcState,
    pub identity: Identity,
    pub authority: Authority,
    pub factions: HashMap<String, Vec<String>>, // primary -> [House Keitel], coalitions -> [...]
    pub capabilities: Capabilities,
    pub resources: Resources,
    pub posture: Posture,
    pub reputation: Reputation,
    pub relationships: Vec<RelationshipEdge>,
    pub knowledge: Vec<KnowledgeItem>,
    pub risk_ethics: HashMap<String, f32>, // risk, honor, corruption, mercy
    pub goals: Vec<GoalItem>,
    pub constraints: ConstraintSet,
    pub plans: Vec<Plan>,
    pub observability: Observability,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Impulse {
    pub id: String,
    pub kind: String, // market_demand, council_edict, prophecy, crisis
    pub scope_faction: Option<String>,
    pub scope_npc: Option<String>,
    pub objective: GoalItem,  // embedded as a goal with max priority
    pub priority: f32,        // typically 1.0
    pub start_ts: String,
    pub end_ts: String,
    pub justification: String,
    pub constraints: Vec<String>,
    pub effects: HashMap<String, f32>, // demand_multiplier, price_bias, etc.
}
```

### Manager traits and impulse handling

```rust
pub trait Manager {
    // Read-only view of NPC; returns proposed plan deltas (actions + rationale)
    fn plan(&self, npc: &Npc, world: &WorldState) -> Vec<Plan>;

    // Apply impulses by injecting/adjusting goals. Returns updated NPC.
    fn apply_impulses(&self, npc: &mut Npc, impulses: &[Impulse]);
}

pub struct WorldState {
    pub market: HashMap<String, f32>, // resource -> price index
    pub factions: HashMap<String, FactionState>,
    pub visibility: HashMap<String, f32>, // intel coverage
}

#[derive(Debug, Clone)]
pub struct FactionState {
    pub id: String,
    pub policies: Vec<String>,
    pub stability: f32,
}
```

```rust
pub struct EconomicManager;

impl Manager for EconomicManager {
    fn plan(&self, npc: &Npc, world: &WorldState) -> Vec<Plan> {
        // Example: prioritize acquire_resource goals (native or injected via impulses)
        let mut plans = Vec::new();
        for goal in npc.goals.iter().filter(|g| g.kind == "acquire_resource") {
            let resource = goal.metrics.get("resource_name")
                .and_then(|_| Some("Mineral X")).unwrap(); // simplified
            let price = world.market.get(resource).copied().unwrap_or(1.0);
            let action = PlanAction {
                kind: "buy_order".into(),
                target: Some(resource.into()),
                params: HashMap::from([("amount".into(), format!("{}", goal.metrics.get("amount").unwrap_or(&0.0)))]),
            };
            plans.push(Plan {
                goal_id: goal.id.clone(),
                actions: vec![action],
                utility: (1.0 / price).min(1.0) * goal.priority,
                risk: 0.2,
                confidence: 0.7,
                rationale: format!("Stockpiling {resource} while price={price:.2} aligns with mandate."),
            });
        }
        plans
    }

    fn apply_impulses(&self, npc: &mut Npc, impulses: &[Impulse]) {
        for imp in impulses {
            if imp.scope_faction.as_deref() == npc.factions.get("primary").and_then(|v| v.first()).map(|s| s.as_str())
                || imp.scope_npc.as_deref() == Some(npc.id.as_str())
            {
                // Inject or update objective as a top-priority goal
                let mut injected = imp.objective.clone();
                injected.priority = injected.priority.max(imp.priority);
                // Attach effect hints
                injected.metrics.extend(imp.effects.iter().map(|(k, v)| (k.clone(), *v)));
                // Ensure kind is consistent
                if injected.kind == "acquire_resource" {
                    injected.metrics.insert("resource_name".into(), 1.0); // placeholder
                }
                // Replace same goal id if present
                npc.goals.retain(|g| g.id != injected.id);
                npc.goals.push(injected);
            }
        }
        // Optional: re-sort goals by priority descending
        npc.goals.sort_by(|a, b| b.priority.partial_cmp(&a.priority).unwrap());
    }
}
```

### Vacancy and promotion helpers

```rust
pub fn fill_vacancy(role: &str, faction: &str, pool: &mut Vec<Npc>, active: &mut Vec<Npc>, relationship_depth: u8) -> Option<String> {
    // **Label:** Candidate selection
    let candidate_pos = pool.iter().position(|n| n.factions.get("primary")
        .and_then(|v| v.first()).map(|s| s == faction).unwrap_or(false));
    let idx = candidate_pos?;
    let mut npc = pool.remove(idx);
    // **Label:** Promotion
    npc.state = NpcState::Active;
    npc.authority.roles.push(RoleGrant { role: role.into(), scope: faction.into() });
    // **Label:** Relationship promotion (lore only)
    if relationship_depth >= 1 {
        // Here you would lift immediate family/rivals into Lore state records (not shown)
    }
    active.push(npc.clone());
    Some(npc.id)
}
```

---

## Action vocabulary and evaluation

- **Standard actions:**
  - **Economy:** Invest, Sanction, Tax/Edict, Buy order, Dump stock.
  - **Military:** Mobilize, Fortify, Raid, Declare war, Propose truce.
  - **Diplomacy:** Ally, Guarantee, Improve relations, Ultimatum, Trade pact.
  - **Espionage:** Infiltrate, Bribe, Blackmail, Leak, Sabotage, Counter-intel Audit.

- **Action metadata:**
  - **Preconditions:** Rights, resources, constraints pass.
  - **Costs:** Resource spend, stability hit, reputation impact.
  - **Risks:** Detection, blowback, AE/infamy.
  - **Outcomes:** Deterministic + stochastic deltas; updates intel/reputation.

- **Evaluation hooks:**
  - **Utility:** Goal alignment × expected gain × priority bias (impulse-aware).
  - **Risk:** Detection/blowback adjusted by secrecy and audit frequency.
  - **Constraints:** Treaties, laws, taboos; alternative substitution if violation.
  - **Ethics veto:** Honor/mercy thresholds block actions.
  - **Stability:** Internal unrest from taxes, war, scandals.

---

## Integration with npc interaction codex

- **Lifecycle alignment:** Pool → Lore → Active; impulses operate on any scope but primarily Active NPCs and faction controllers.
- **Vacancy symmetry:** Houses, Corporates, cults, and player coalitions use the same vacancy fill and promotion pipeline.
- **Espionage vectors:** Backstories, debts, rivalries, secrets; impulses can raise audit_frequency or lower espionage_risk to simulate crackdowns.
- **Administrative control:** Designers or dynamic systems inject impulses to steer markets, politics, or crises without breaking diegesis.

---

## Implementation notes and best practices

- **State purity:** Keep NPC core state as the single source of truth; managers produce deltas.
- **Explainability:** Store plan rationales for UI/tooling and telemetry.
- **Event sourcing:** Log impulses, promotions, vacancies, and action outcomes for replay across campaigns.
- **Configurability:** Per-faction knobs (aggression, stability sensitivity, audit frequency, ethics taboos).
- **Concurrency:** Lock shared assets during multi-manager planning to avoid inconsistent orders.
- **Testability:** Deterministic seeds for stochastic simulations; snapshot fixtures for manager regression.
- **Performance:** Use Lore references and on-demand promotion to avoid NPC bloat; purge Pool after worldgen.

---

## Quick-start examples

- **Inject market impulse (Rust):**
  ```rust
  let impulse = Impulse {
      id: "imp_mineral_x_oversupply".into(),
      kind: "market_demand".into(),
      scope_faction: Some("House Keitel".into()),
      scope_npc: None,
      objective: GoalItem {
          id: "g_mineral_x_stockpile".into(),
          kind: "acquire_resource".into(),
          target: Some("Mineral X".into()),
          priority: 1.0,
          horizon: "short".into(),
          metrics: HashMap::from([("amount".into(), 100000.0)])
      },
      priority: 1.0,
      start_ts: "1204-05".into(),
      end_ts: "1204-09".into(),
      justification: "Oversupply stockpiling mandate".into(),
      constraints: vec!["no_open_war".into()],
      effects: HashMap::from([("demand_multiplier".into(), 3.0), ("price_bias".into(), -0.25)])
  };
  let econ = EconomicManager;
  econ.apply_impulses(&mut elira_npc, &[impulse]);
  let plans = econ.plan(&elira_npc, &world);
  ```

- **Fill coalition vacancy (Rust):**
  ```rust
  let mut pool: Vec<Npc> = load_pool();
  let mut active: Vec<Npc> = load_active();
  if let Some(id) = fill_vacancy("Logistics Officer", "PlayerCoalitionAlpha", &mut pool, &mut active, 1) {
      println!("Promoted {id} to Logistics Officer.");
  }
  ```

- **Audit-driven counter-intel plan (pseudo-Rust):**
  ```rust
  // If espionage_risk > threshold or recent embezzlement detected:
  let action = PlanAction { kind: "counter_intel_audit".into(), target: Some("PlayerCoalitionAlpha".into()), params: HashMap::new() };
  let plan = Plan {
      goal_id: "g_secure_finances".into(),
      actions: vec![action],
      utility: 0.8, risk: 0.25, confidence: 0.7,
      rationale: "Heightened risk warrants audits to deter embezzlement within coalition staff."
  };
  ```

---

This codex is ready to serve as your API abstraction for Active NPC decision-making, impulse integration, and grand strategy behaviors. If you want, I can generate Rust trait implementations for Diplomacy and Espionage managers next, plus a minimal tick loop demonstrating multi-manager planning with impulse priority and constraint resolution.
