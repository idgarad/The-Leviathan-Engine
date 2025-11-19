# Skill certifications codex (final)

## Core objectives

- **Scope:** Define suite certifications, meta-certifications, faction gating (USO/factions), enhancement bonuses, XP curves, and fleet-wide performance considerations.
- **Design goals:** Deterministic server-side evaluation, explicit stacking order, cache-friendly aggregates, per-tick fleet recompute strategy, auditable state.
- **Player experience:** **Ranks 1–10** per skill; **Rank 5 = Mastery**; **post‑mastery global bonuses**; **certifications** unlock content and enhance global bonuses of member skills.

---

## Structure and progression

### Skill suites and mastery

- **Baseline (Fitting):** Core operation and fitting impacts; pre-master scaling; post-master diminished scaling.
- **Efficiency:** Resource usage and sustainability; energy, heat, wear.
- **Efficacy:** Outcome quality; crit, accuracy, penetration.
- **Mastery threshold:** **Rank 5** caps core curve; **Ranks 6–10** grant small core increments plus **global bonuses** (explicit, data-driven).

### Certifications and enhancement bonuses

- **Suite certification:** Granted when all three skills in a suite are **rank ≥ 5** and standing requirements are met.
- **Enhancement bonuses:** Certification applies explicit buffs to the suite’s **global bonuses** (e.g., “Global Damage Bonuses of member skills: +10%”; “Range Bonuses: +2%”).
- **Semantics:** Enhancements can be **multiplicative (multiplier)** or **additive (flat)**, resolved in a fixed order.

### Meta-certification tree

- **Weapons Master:** Laser + Missile + Railgun + Gunnery certifications; unlock prototype weaponry; enhances weapon global bonuses (e.g., global_damage ×1.10).
- **Defensive Systems Commander:** Shield + Armor certifications; unlock fortress-class hulls; enhances defensive global bonuses (e.g., global_resist ×1.08).
- **Systems Architect:** Engineering + Logistics certifications; unlock capital construction; enhances fleet support bonuses (e.g., resupply_speed +2% additive).
- **Navigator Prime:** Navigation + FTL certifications; unlock exploration/wormhole ops; enhances navigational bonuses (e.g., jump_accuracy ×1.05).
- **Fleet Commander (grand meta):** Weapons Master + Defensive Systems Commander + Systems Architect; unlock command-class ships; fleet aura potency ×1.05 and radius +5% additive.

---

## Availability and gating

- **Skill availability:** Requires **standing(faction) ≥ required(skill)**; USO typically gates Baseline skills.
- **Suite certification availability:** All three skills **≥ 5** and meet multi-faction thresholds (e.g., USO ≥ 70, Navy ≥ 60).
- **Meta-cert availability:** Possess required certifications and multi-faction standings; optional prestige XP to formalize.

---

## Mathematical model

### XP cost curves

- **Per-rank cost:** \(XP(r) = XP_0 \cdot 2^{(r-1)}\) (default \(XP_0 = 100\)).
- **Total to rank R:** \(XP_{\text{total}}(R) = XP_0 \cdot (2^R - 1)\).

### Core vs post-master scaling

- **Pre-master:** **Linear or gently sublinear** per suite, e.g., Baseline damage +2%/rank (1–5).
- **Post-master:** **Diminished** increments, e.g., +0.5%/rank (6–10).
- **Global bonuses:** Explicit per skill (6–10), e.g., repair_cost_reduction +10% per rank beyond 5; structured and addressable by type.

### Stacking order (deterministic)

- **Order:** Base stats → Baseline (multiplicative) → Efficiency (multiplicative reductions) → Efficacy (multiplicative) → Global bonuses (additive/multiplicative as defined) → Certification enhancements → Meta-cert enhancements → Fleet auras → External buffs/debuffs → Caps.
- **Caps:** Apply final clamps (e.g., energy_mul ≥ 0.50; heat_mul ≥ 0.50).

---

## Data model (schemas)

### Skill (member of a suite)

```yaml
name: "Integrated Laser Operations"
kind: "Efficacy"
pre_master_core:
  crit_add: 0.005         # +0.5% per rank (1–5)
  accuracy_mul: 0.01      # +1% per rank (1–5)
post_master_core:
  crit_add: 0.001         # +0.1% per rank (6–10)
global_bonuses:
  - { type: "repair_cost_reduction", additive: 0.10 }  # per rank beyond 5
requirements:
  - { faction: "USO", standing: 60 }
```

### Certification (suite-level)

```yaml
name: "Laser Weapons Specialist"
suite: "Laser Weapons"
requirements:
  skills:
    - { name: "Laser Weapon Operations", min_rank: 5 }
    - { name: "Laser Modulation", min_rank: 5 }
    - { name: "Integrated Laser Operations", min_rank: 5 }
  standings:
    - { faction: "USO", standing: 70 }
    - { faction: "Navy", standing: 40 }
enhancement_bonuses:
  - { type: "global_damage_bonus", multiplier: 1.10 }
  - { type: "range_bonus", additive: 0.02 }
```

### Meta-certification

```yaml
name: "Weapons Master"
requires_certs:
  - "Laser Weapons Specialist"
  - "Missile Weapons Specialist"
  - "Railgun Specialist"
  - "Gunnery Specialist"
standing_requirements:
  - { faction: "USO", standing: 75 }
  - { faction: "Navy", standing: 60 }
enhancement_bonuses:
  - { type: "global_damage_bonus", multiplier: 1.10 }
  - { type: "global_tracking_bonus", multiplier: 1.05 }
```

---

## Coding examples

### Python

```python
from dataclasses import dataclass
from typing import Dict, List, Tuple

MASTER, MAXR = 5, 10

def xp_cost(rank: int, base: int = 100) -> int:
    return base * (1 << (rank - 1))

def xp_total(R: int, base: int = 100) -> int:
    return base * ((1 << R) - 1)

@dataclass
class Bonus:
    type: str
    multiplier: float = 1.0
    additive: float = 0.0

@dataclass
class SkillTuning:
    pre_core: Dict[str, float]
    post_core: Dict[str, float]
    globals_post: List[Bonus]  # applied per-rank beyond mastery

def core_effect(rank: int, t: SkillTuning) -> Dict[str, float]:
    r = max(1, min(rank, MAXR))
    out = {}
    if r <= MASTER:
        for k, v in t.pre_core.items(): out[k] = r * v
    else:
        for k, v in t.pre_core.items(): out[k] = MASTER * v
        for k, v in t.post_core.items(): out[k] = out.get(k, 0.0) + (r - MASTER) * v
    return out

def global_bonuses(rank: int, t: SkillTuning) -> Dict[str, float]:
    r = max(1, min(rank, MAXR))
    n = max(0, r - MASTER)
    out: Dict[str, float] = {}
    for b in t.globals_post:
        # store as scalar value; multiplier bonuses represented as (multiplier - 1)
        if b.multiplier != 1.0:
            out[b.type] = out.get(b.type, 0.0) + n * (b.multiplier - 1.0)
        if b.additive != 0.0:
            out[b.type] = out.get(b.type, 0.0) + n * b.additive
    return out

def apply_cert_enhancements(skill_globals: Dict[str, float], cert_enh: List[Bonus]) -> Dict[str, float]:
    out = dict(skill_globals)
    for enh in cert_enh:
        if enh.type in out:
            out[enh.type] = out[enh.type] * enh.multiplier + enh.additive
    return out

def can_learn_skill(standings: Dict[str, int], req: Tuple[str, int]) -> bool:
    return standings.get(req[0], 0) >= req[1]

def can_certify(skill_ranks: Dict[str, int], standings: Dict[str, int], reqs: List[Tuple[str, int]]) -> bool:
    if not all(r >= MASTER for r in skill_ranks.values()): return False
    return all(standings.get(f, 0) >= v for f, v in reqs)

def has_meta_cert(player_certs: set, required: List[str], standing_reqs: List[Tuple[str, int]], standings: Dict[str, int]) -> bool:
    if not all(c in player_certs for c in required): return False
    return all(standings.get(f, 0) >= v for f, v in standing_reqs)

# Fleet per-tick recompute (sketch)
def update_fleet_bonuses(ships, auras, grid):
    for aura in auras:
        targets = grid.query_radius(aura.pos, aura.range)  # spatial index
        for idx in targets:
            ships[idx].fleet_scalars[aura.bonus_type] += aura.value
```

### Rust

```rust
use std::collections::{HashMap, HashSet};

const MASTER: u32 = 5;
const MAXR: u32 = 10;

pub fn xp_cost(rank: u32, base: u32) -> u32 { base * (1 << (rank - 1)) }
pub fn xp_total(r: u32, base: u32) -> u32 { base * ((1 << r) - 1) }

#[derive(Clone)]
pub struct Bonus {
    pub bonus_type: &'static str,
    pub multiplier: f64, // 1.0 = none
    pub additive: f64,   // 0.0 = none
}

#[derive(Clone)]
pub struct SkillTuning {
    pub pre_core: HashMap<&'static str, f64>,
    pub post_core: HashMap<&'static str, f64>,
    pub globals_post: Vec<Bonus>,
}

pub fn core_effect(rank: u32, t: &SkillTuning) -> HashMap<&'static str, f64> {
    let r = rank.clamp(1, MAXR);
    let mut out = HashMap::new();
    if r <= MASTER {
        for (k, v) in &t.pre_core { out.insert(*k, (r as f64) * *v); }
    } else {
        for (k, v) in &t.pre_core { out.insert(*k, (MASTER as f64) * *v); }
        for (k, v) in &t.post_core {
            let e = out.entry(*k).or_insert(0.0);
            *e += ((r - MASTER) as f64) * *v;
        }
    }
    out
}

pub fn global_bonuses(rank: u32, t: &SkillTuning) -> HashMap<&'static str, f64> {
    let r = rank.clamp(1, MAXR);
    let n = r.saturating_sub(MASTER) as f64;
    let mut out = HashMap::new();
    for b in &t.globals_post {
        if b.multiplier != 1.0 {
            let e = out.entry(b.bonus_type).or_insert(0.0);
            *e += n * (b.multiplier - 1.0);
        }
        if b.additive != 0.0 {
            let e = out.entry(b.bonus_type).or_insert(0.0);
            *e += n * b.additive;
        }
    }
    out
}

pub fn apply_cert_enhancements(mut skill_globals: HashMap<&str, f64>, cert_enh: &[Bonus]) -> HashMap<&str, f64> {
    for enh in cert_enh {
        if let Some(v) = skill_globals.get_mut(enh.bonus_type) {
            *v = *v * enh.multiplier + enh.additive;
        }
    }
    skill_globals
}

pub fn can_learn_skill(standings: &HashMap<&str, i32>, req: (&str, i32)) -> bool {
    standings.get(req.0).unwrap_or(&0) >= &req.1
}

pub fn can_certify(skill_ranks: &[u32; 3], standings: &HashMap<&str, i32>, reqs: &[(&str, i32)]) -> bool {
    if !skill_ranks.iter().all(|&r| r >= MASTER) { return false; }
    reqs.iter().all(|(f, v)| standings.get(*f).unwrap_or(&0) >= v)
}

pub fn has_meta_cert(certs: &HashSet<&str>, required: &[&str], reqs: &[(&str, i32)], standings: &HashMap<&str, i32>) -> bool {
    if !required.iter().all(|r| certs.contains(r)) { return false; }
    reqs.iter().all(|(f, v)| standings.get(*f).unwrap_or(&0) >= v)
}

// Fleet update sketch
pub fn update_fleet_bonuses(ships: &mut [Ship], auras: &[Aura], grid: &SpatialGrid) {
    for aura in auras {
        let targets = grid.query_radius(aura.pos, aura.range);
        for idx in targets { ships[idx].fleet_scalars.apply(&aura); }
    }
}
```

### C++

```cpp
#include <map>
#include <string>
#include <vector>
#include <algorithm>

static const unsigned MASTER = 5, MAXR = 10;

unsigned xp_cost(unsigned r, unsigned base=100){ return base * (1u << (r - 1)); }
unsigned xp_total(unsigned R, unsigned base=100){ return base * ((1u << R) - 1); }

struct Bonus { std::string type; double multiplier{1.0}; double additive{0.0}; };
struct SkillTuning {
    std::map<std::string,double> pre_core;
    std::map<std::string,double> post_core;
    std::vector<Bonus> globals_post;
};

std::map<std::string,double> core_effect(unsigned rank, const SkillTuning& t){
    unsigned r = std::clamp(rank, 1u, MAXR);
    std::map<std::string,double> out;
    if (r <= MASTER) for (auto& kv : t.pre_core) out[kv.first] = r * kv.second;
    else {
        for (auto& kv : t.pre_core) out[kv.first] = MASTER * kv.second;
        for (auto& kv : t.post_core) out[kv.first] += (r - MASTER) * kv.second;
    }
    return out;
}

std::map<std::string,double> global_bonuses(unsigned rank, const SkillTuning& t){
    unsigned r = std::clamp(rank, 1u, MAXR);
    unsigned n = (r > MASTER) ? (r - MASTER) : 0;
    std::map<std::string,double> out;
    for (auto& b : t.globals_post) {
        if (b.multiplier != 1.0) out[b.type] += n * (b.multiplier - 1.0);
        if (b.additive != 0.0) out[b.type] += n * b.additive;
    }
    return out;
}

std::map<std::string,double> apply_cert_enhancements(std::map<std::string,double> sg,
                                                     const std::vector<Bonus>& cert){
    for (auto& enh : cert) {
        auto it = sg.find(enh.type);
        if (it != sg.end()) it->second = it->second * enh.multiplier + enh.additive;
    }
    return sg;
}

bool can_learn_skill(const std::map<std::string,int>& standings,
                     const std::pair<std::string,int>& req){
    auto it = standings.find(req.first); return it != standings.end() && it->second >= req.second;
}

bool can_certify(const std::vector<unsigned>& ranks,
                 const std::map<std::string,int>& standings,
                 const std::vector<std::pair<std::string,int>>& reqs){
    for (auto r : ranks) if (r < MASTER) return false;
    for (auto& rq : reqs) { auto it = standings.find(rq.first);
        if (it == standings.end() || it->second < rq.second) return false; }
    return true;
}

// Fleet update (concept)
void updateFleetBonuses(std::vector<Ship>& ships, const std::vector<Aura>& auras, const SpatialGrid& grid){
    for (const auto& aura : auras){
        auto targets = grid.queryRadius(aura.pos, aura.range);
        for (auto idx : targets) ships[idx].fleetScalars.apply(aura);
    }
}
```

---

## Performance engineering (server-side)

- **Event-driven local recompute:** Recompute player **Local layer** aggregates (skills/certs/enhancements) only on rank/standing/loadout changes.
- **Layered model:** Final stats = **Local × Fleet × Environment**; only the **Fleet layer** updates per tick.
- **Spatial partitioning:** Use grid/octree to query aura ranges efficiently; precompute squared ranges; update on cell boundary transitions.
- **Delta-based updates:** When a ship enters/leaves an aura, apply/remove contribution instead of full recompute.
- **Batch processing:** For each aura source, compute contribution once; apply to all targets in batch; prefer SoA for cache locality.
- **Tick budgets:** Update aura proximity at lower Hz (e.g., 10Hz) vs combat resolution (e.g., 30–60Hz); interpolate client-side.
- **Determinism and caps:** Fixed stacking order, f64 or fixed-point math; final clamps to prevent runaway values.
- **Audit and security:** Log state changes; validate gating (skills/certs/meta) server-side; never trust client inputs.

---

## Example certifications and enhancements (summary)

- **Laser Weapons Specialist:** global_damage_bonus ×1.10; range_bonus +0.02.
- **Missile Weapons Specialist:** global_tracking_bonus ×1.08; ammo_efficiency +0.01.
- **Railgun Specialist:** global_penetration_bonus ×1.08; recoil_stability +0.02.
- **Shield Systems Specialist:** global_resist_bonus ×1.08; recharge_rate +0.01.
- **Armor Systems Specialist:** global_resist_bonus ×1.06; repair_material_efficiency +0.02.
- **Engineering Specialist:** power_grid_efficiency ×1.05; maintenance_interval +0.02.
- **Navigation Specialist:** jump_accuracy ×1.05; travel_wear_reduction +0.02.
- **Gunnery Specialist:** turret_accuracy ×1.06; reload_speed +0.01.
- **FTL Navigator:** interdiction_resistance ×1.05; cooldown_reduction +0.02.
- **Logistics Specialist:** resupply_speed +0.02; upkeep_cost_reduction +0.02.
- **Weapons Master (meta):** global_damage ×1.10; global_tracking ×1.05.
- **Fleet Commander (grand meta):** fleet_aura_potency ×1.05; fleet_aura_radius +0.05.

---

## Lore integration

- **USO baseline access:** Grants foundational skills across suites with moderate standing.
- **Factional gating:** Navies gate Efficacy/weapon certifications; corporate guilds gate Efficiency/logistics/engineering.
- **Meta-cert prestige:** Represents doctrinal mastery; gates command-class ships and fleet abilities.
- **Doctrine synergy:** Enhancement bonuses reflect institutional training improving all relevant global bonuses.

---

