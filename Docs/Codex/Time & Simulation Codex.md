---
# 📏 Time & Simulation Codex

Purpose
- Formalizes time semantics for the engine, describes ISD temporal accelerators, provides tuning knobs, API signatures, data models, and UX guidance so designers can make planets variably desirable and create governor upgrade paths.

1. Time Semantics — Principles
- Separate clocks where helpful: `combat_clock` (real‑time, high frequency) and `strategic_calendar` (in‑game days/months, low frequency).
- Prefer expressing long‑term progress as **colony capacity** (infrastructure readiness) rather than immediate colonist counts.
- Temporal accelerators compress local construction/assembly work on planetary facilities; they do not teleport colonists or bypass fundamental biosphere constraints — instead they reduce effective calendar time for eligible tasks.

2. Temporal Accelerator (TA) — Concept
- Deployed/installed by ISD or large Houses/Corporations with ISD approval.
- Localized: affects tasks within a planet or a defined region (e.g., orbital + surface work).
- Configurable properties: `tier`, `max_throughput_cs_per_hour`, `stabilizer_rating`, `energy_draw_kw`, `sync_range`, `certified`.

3. Data Model (example YAML)
```yaml
TemporalAccelerator:
  id: string
  planet_id: string
  tier: int # 1..N
  max_throughput_cs_per_hour: float
  speed_multiplier: float
  energy_draw_kw: float
  stabilizer_rating: float
  certified: bool
  owner: faction_id
  status: enum(active|inactive|overdrive|failed)
```

4. Tuning — Suggested Defaults (design starting point)
- Tier 1 — Prototype Accelerator
  - `speed_multiplier = 5.0`
  - `max_throughput_cs_per_hour = 10.0`
  - `energy_draw_kw = 5000`
  - `stabilizer_rating = 0.85`
  - `install_cost_shares = 10`
- Tier 2 — Fielded Accelerator
  - `speed_multiplier = 10.0`
  - `max_throughput_cs_per_hour = 50.0`
  - `energy_draw_kw = 18000`
  - `stabilizer_rating = 0.93`
  - `install_cost_shares = 40`
- Tier 3 — ISD Grand Accelerator (rare)
  - `speed_multiplier = 25.0`
  - `max_throughput_cs_per_hour = 200.0`
  - `energy_draw_kw = 100000`
  - `stabilizer_rating = 0.99`
  - `install_cost_shares = 250`

Notes on tuning
- `speed_multiplier` directly scales task execution time for eligible tasks: `effective_time = nominal_time / speed_multiplier` (bounded by `max_throughput`).
- `max_throughput_cs_per_hour` prevents infinite scaling for very large projects; once throughput exhausted, remaining tasks execute at nominal rates or must wait for next window.
- `stabilizer_rating` reduces the probability and severity of quality degradation and temporal anomalies when operating at high load or overdrive.

5. Example formulas
- Eligible work accumulation: `accelerated_cs = min(available_cs, max_throughput_cs_per_hour * active_hours)`
- Effective calendar advancement for facility construction: `calendar_hours_consumed = work_cs / (base_cs_per_hour * speed_multiplier)` (clamped by throughput)
- Failure chance per hour under load: `p_fail = base_fail_rate * (load_factor) * (1 - stabilizer_rating)` where `load_factor = max(1, requested_cs / max_throughput_cs_per_hour)`.

6. Governor Upgrade Path & Desirability
- Governors can be given access to upgrade accelerators as part of their progression (unlocking higher tiers, improving stabilizers, increasing certified throughput).
- Planet desirability score (example):
  - `desirability = w1*colony_capacity + w2*accelerator_tier + w3*resource_richness + w4*stability + w5*ISD_priority`
  - Use a weighted sum; accelerators increase `colony_capacity_growth_rate` making planets more desirable for investment and contestation.
- Upgrades: `GovernorLevel` unlocks features: `level 1: manage Tier1`, `level 3: request Tier2 ISD deployment`, `level 5: pilot Tier3 joint-installation`.

7. API Sketch (server authoritative)
- `install_accelerator(planet_id, spec) -> accelerator_id | error`
- `activate_accelerator(accelerator_id)` — start consuming energy and begin acceleration window
- `tick_accelerator(accelerator_id, dt_seconds)` — server tick; apply `accelerated_cs` to eligible tasks, consume energy, compute anomalies
- `query_accelerator(planet_id) -> list[accelerator]`
- `request_isd_certificate(faction_id, accelerator_id) -> approval_token | rejection`

8. UX & Messaging
- UI shows: `Accelerator: Tier 2 — Active — 10× build speed (capped)`; tooltip shows `max throughput`, `energy draw`, `stabilizer rating`, `ISD certification` and `risk` meter.
- When an accelerator triggers an anomaly, present clear explainers and immediate mitigation options (shut down, roll back, emergency vent).
- Show projected `colony_capacity` timeline with and without the accelerator (helpful for governor decisions).

9. Multiplayer & Design Rules
- Authoritative server resolves accelerator ticks and anomalies.
- Region locks: installing or overdriving an accelerator can impose temporary region locks (prevents contradictory strategic rewrites while accelerator is active).
- Political consequences: unauthorized use or overdrive creates audit logs, allowing Houses/Empire to levy fines or trigger diplomatic effects.

10. Examples
- Example: Planet A needs `500 Cs` of infrastructure to reach `colony_capacity=0.6`. With Tier2 accelerator (`50 cs/hour` throughput, 10× speed) the installation processes `50 cs/hour` accelerated; effective build time is `500 / 50 = 10 hours` of accelerator time. The server converts this to the strategic calendar according to campaign rules and reports a `colony_capacity` jump when thresholds are met.

Appendix: designer checklist
- Declare which tasks are `accelerator_eligible` (assembly, automation setup, prefab deployment).
- Choose default tier availability per campaign (rare Tier3, limited Tier2 deployments).
- Tune `max_throughput` so accelerators become strategic chokepoints (targets for raids/defense).
- Define governor unlock schedule and certification costs.

---

This codex is intentionally prescriptive but tunable — designers should iterate on `speed_multiplier`, `max_throughput`, and `stabilizer_rating` with playtests to reach the desired pacing and campaign economy.

11. Diminishing Returns, Maintenance, and Siphon Risk

- Rationale: larger, higher‑tier accelerators are powerful levers for rapid infrastructure build‑out, but they must carry correspondingly increased long‑term costs and risks so they remain strategic, contested, and meaningful goals rather than trivially dominant options.

- Designer goals for diminishing returns:
  - Make each incremental tier more expensive to deploy and operate (upfront + ongoing).  
  - Increase political and tactical exposure (higher value = bigger target for raids, siphons, and sabotage).  
  - Reduce marginal benefit per cost step so players must weigh tradeoffs (cost vs speed vs risk).

- Practical mechanics:
  1. Upkeep scaling: `upkeep_per_hour = base_upkeep * (tier ^ alpha_upkeep)` where `alpha_upkeep ∈ [1.2, 2.0]` (superlinear growth). Higher upkeep forces governors/Houses to consider long‑term OP costs.
 2. Marginal speed diminishing: model `speed_multiplier` as a concave function of tier instead of purely linear. Example: `speed_multiplier(t) = base * (1 + ln(1 + k*(t-1)))` or a power law with exponent < 1. This gives large initial gains but diminishing incremental returns.
 3. Throughput vs efficiency: increasing `max_throughput` yields higher absolute capacity but lower energy efficiency: `energy_per_cs = base_energy * (1 + beta*(tier-1))` so Tier3 costs more energy per unit accelerated work.
 4. Siphon/attack surface: define `siphon_risk = base_siphon * (1 + gamma*(tier-1))` and `sabotage_probability = base_sabotage * (1 + delta*(exposed_value/threshold))`. Higher tier → larger payouts for attackers and higher probability of targeted attacks or stealth siphons.
 5. Overdrive penalty: allow temporary overdrive (increase `speed_multiplier` by factor) at the cost of sharply increased `p_fail` and possible long cooldowns or degraded stabilizer_rating. Example: `p_fail_overdrive = base_fail * overdrive_factor / stabilizer_rating`.

- Example balancing numbers (illustrative)
  - `base_upkeep = 10 credits/hour`, `alpha_upkeep = 1.5` → Tier1 upkeep=10, Tier2 ≈ 28, Tier3 ≈ 52.
  - `speed_multiplier` approx: Tier1=5, Tier2=9 (not 10), Tier3=14 (not 25) under diminishing model — designers choose exact curve.
  - `energy_per_cs` increases linearly with tier: Tier1=1 unit/CS, Tier2=1.2, Tier3=1.5.
  - `siphon_risk` base 0.01/hour → Tier2 0.02/hour → Tier3 0.04/hour (example).

- Gameplay consequences & narrative hooks:
  - High tier accelerators become strategic chokepoints: attackers aim to cut throughput via sabotage, siphoning energy, or stealing stabilizers. Protecting an accelerator requires fleets, orbital defenses, and local political capital.
  - Overdependence risk: Houses that rely heavily on accelerators may become vulnerable to cascading failures if a single accelerator is disabled.
  - Insurance & maintenance markets: Emergent gameplay where corporations sell stabilizer maintenance, anti‑siphon modules, insurance policies, and ISD certification services.

- UI & designer guidance:
  - Show `marginal_benefit_per_credit` and `siphon_risk` prominently when players consider upgrades or overdrive — e.g., a small chart: cost vs expected CS/hour vs expected downtime risk.
  - Provide tooltips explaining that higher tiers reduce build time but raise upkeep, targetability, and the chance of anomalies under overdrive.

---

