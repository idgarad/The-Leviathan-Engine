---
# 🔬 Science & Exploration Codex

Purpose
- Define expeditionary science and exploration missions (classic away missions), orbital and anomaly scans, crew deployment rules, mission durations and costs, data models for discoveries, and ties into the `Codex Necronomicon` (the mounting evidence of past catastrophic events).

1. Mission Types — Overview
- **Away Mission (Surface/Interior):** Deploy a small team (officers + specialists) to a planet surface, ruin, derelict or facility for a bounded period (hours → days real time) to collect samples, perform repairs, or recover artifacts.
- **Orbital Survey:** Orbit a body for X hours to collect high‑fidelity telemetry, map surface features, or detect anomalous signatures. Low risk, adjustable duration.
- **Anomaly Scan:** Focused mission to scan, probe, or enter anomalous zones (time slips, sensor echoes). High risk, high reward; often ties to Necronomicon lore.
- **Long‑Range Expedition:** Multi‑stage mission involving staging at Nexus/Wormhole, multi‑day operations, and durable resource/crew logistics.

2. Crew Roles & Composition
- Away missions use abstracted squads of deployable crew rather than ship bridge officers. Wardens/remote commanders provide mission orders and oversight, but the on‑site work is handled by squads abstracted as counts and role mix (this keeps missions light-weight and scalable).
- Typical squad composition (configurable per mission):
  - **Small Squad (default):** 1x Scientist, 1x Engineer, 1x Medic — (3 crew units)
  - **Standard Squad:** 1x Scientist, 1x Engineer, 1x Medic, 1x Security — (4 crew units)
  - **Expanded Squad:** Standard + 1x Specialist (Archaeology/Xenotech) or +1x Security — (5 crew units)
- Mechanics:
  - Each crew unit is an abstract resource with skill tags (science, engineering, medical, security, specialist). Missions consume crew units for duration; skills modify success chance, time, and anomaly mitigation.
  - Bridge officers remain ship systems (navigation, tactical, comms) and are **not** consumed by away missions.
  - Specialist certs/skills (Science, Archaeology, Xenotech) on crew units increase success, reduce time, and reduce anomaly risk.
  - Persistence: deployed crew units accrue fatigue, contamination, and experience; long missions need rotation or risk attrition. Track squad-level state (`fatigue`, `contamination_level`, `xp_gained`).

3. Mission Life Cycle
- `plan_mission(spec) -> mission_id` — define objectives, duration, crew, equipment, and risk tolerance.
- `dispatch_team(mission_id)` — reserves crew and gear, snapshots pre‑mission state.
- `tick_mission(mission_id, dt)` — apply mission progression, roll for discoveries, hazards, and sample returns.
- `complete_mission(mission_id)` — generate results (data packages, artifacts, contamination reports, XP), apply crew state changes, and log events to archives.

4. Time & Duration
- Missions use `mission_clock` (real seconds). Some mission effects are eligible for acceleration by local Temporal Accelerators (see `Time & Simulation Codex`) — e.g., robotic prep tasks, sample processing — but crew subjective time and psychological effects are not compressible.
- Typical durations: orbital scans (1–6 hours), away missions (2–48 hours), anomaly expeditions (variable, risk of extension), long expeditions (multi‑day/week with staging).

5. Outcomes, Rewards & Data
- **Data Packages:** telemetry, maps, spectrographs, artifact manifests — deliverable to research facilities or sold (ATECs). Data yields research points, unlocks tech, or advances Necronomicon evidence.
- **Artifacts:** physical objects requiring containment (ATECs or vaults). Some artifacts increase Doomsday Clock increments depending on classification (dangerous tech, misaligned physics).
- **Experience & Prestige:** crew gain XP and potential certifications; successful missions raise House/Player prestige and can trigger Imperial interest.

- 6. Risks & Failure Modes
- **Environmental hazards:** toxic atmospheres, radiation, gravity, seismic events.
- **Anomalies:** temporal slips, sensor echoes causing hallucinations, memory loss, or corruption of data. Tied to Necronomicon: cumulative evidence may reveal catastrophic past events.
- **Contamination & Quarantine:** recovered biological or memetic hazards require quarantine; mishandling can spread corruption to ship systems or crew (mechanics: contamination_level accumulates; above thresholds triggers quarantine, crew attrition, or Doomsday Clock effects).
- **Siphons and Raids:** long missions reduce fleet readiness; adversaries may intercept convoys or attack staging points.
- **Abandonment & Legal Consequences:** Abandoning deployed crew is a severe crime under Imperial law. If crew are left behind (deliberately or through ship incapacitation) they may issue an automated distress beacon from the evac site. Imperial Recovery Services (IRS) or ISD recovery teams can be summoned to attempt retrieval of inaccessible crew, but recovery carries costs, delays, and political exposure.
  - **Distress Beacons:** crew at evac sites may deploy a `distress_beacon` if their ship cannot pick them up; the beacon broadcasts location and limited telemetry and can be detected by friendly Wardens, opportunistic raiders, or Imperial rescue teams. Using a beacon may expedite rescue but increases risk of interception.
  - **IRS Recovery:** calling Imperial Recovery Services triggers an audit ticket and an estimated recovery fee (credits/shares plus administrative delay). Recovery attempts are probabilistic and can fail; recovered crew may be quarantined or medically damaged.
  - **Consequences for Abandonment:** consequences include heavy Imperial fines, loss of standing, seizure of assets, possible arrest or warrantry against responsible Wardens/commanders, and increased mutiny risk among remaining crew. Repeated or deliberate abandonment can trigger criminal prosecution by the Empire and long‑term political penalties for the owning faction.
  - **Mutiny & Morale:** abandoned or high‑casualty missions dramatically reduce morale fleet‑wide; surviving crew and officers may suffer mutiny risk, reduced performance, and higher attrition on subsequent missions. Morale effects should be modeled as fleet/faction level debuffs that scale with severity of loss.
  - **Full Losses:** Away missions carry the risk of partial or total loss of deployed squads. Designers must ensure players understand that casualties can be permanent and have cascading political, economic, and narrative consequences.

7. Anomaly Scanning — Mechanics & Lore
- **Probe Ladder:** use staged probes with increasing risk (remote → semi‑autonomous → crewed). Each stage improves data fidelity and increases anomaly exposure.
- **Evidence Accrual:** assign `evidence_score` for anomalous finds; reaching thresholds unlocks Necronomicon entries, advances Doomsday Clock stages, or attracts cult attention.
- **Diegetic Framing:** anomalies tie to the Codex Necronomicon — evidence may support theories (First War artifacts, vanished horrors). Designers should specify how discoveries alter narrative arcs.

8. Data Model Examples (JSON)
```json
{
  "mission_id": "m_0001",
  "type": "away",
  "planet_id": "PL-AX12",
  "crew": ["ward_12","sc_off_03","eng_07","med_05"],
  "duration_hours": 12,
  "objectives": ["sample_core","map_ruins","recover_vault"],
  "risk_tolerance": "medium",
  "outcomes": {"data_points": 120, "artifacts": ["ATEC-43"], "evidence_score": 3}
}
```

9. UI & Player Feedback
- Mission planning HUD: show required crew, expected duration, chance of success, potential rewards, XP, contamination risk, and whether tasks are `accelerator_eligible` (robotic sample processing).
- While mission is active: show mission status, partial telemetry, and crew condition (fatigue, contamination, morale). Offer mid‑mission decisions:
  - **Abort:** attempt to pull squad back to ship. If ship is incapacitated or cannot reach evac site, abort may not be possible and abandonment rules apply.
  - **Push:** extend or escalate objectives at added risk to crew and equipment.
  - **Shift Objectives:** reprioritize tasks to reduce risk or focus on high‑value targets.
  - **Trigger Distress Beacon:** deploy an evac-site beacon that broadcasts location and limited telemetry. The UI shows estimated detection window, interception risk, and which factions/IRS units may respond. Beacons expedite rescue but increase exposure.
  - **Attempt Local Pickup:** authorize a local extraction (shuttles/remote drones). Display estimated success probability, added fuel/repair costs, and casualty risk.
  - **Call Imperial Recovery Services (IRS):** request formal recovery; UI displays estimated recovery fee, administrative delay, and probability of successful retrieval. Calling IRS opens an audit ticket and may affect faction standing.

For each action the UI should present estimated costs, success probabilities, and likely secondary effects (morale change, political exposure, contamination handling). If the player chooses an action that leads to abandoned crew, present explicit warnings about legal penalties, fines, and mutiny risk.

10. Multiplayer & Persistence
- Server authoritative mission simulation. Mission events are logged to archives (used for lore and NPC reactions).
- Public/Private missions: some missions are public (shared telemetry), others private (classified) and may trigger political consequences if leaked.

11. Integration Points
- **Codex Necronomicon:** evidence scoring ties to the Doomsday Clock; certain artifacts or anomalies increment the clock. Define thresholds for lore events.
- **Time & Simulation Codex:** determines which processing steps may be accelerated; crew subjective effects remain real-time.
- **Cargo & Storage / ATECs:** artifacts and data packages must be containerized and handled by ATECs or Vaults.

12. Example Mission Templates
- `Sample Core`: remote drill + robotic retrieval; eligible for acceleration; low crew risk.
- `Ruin Foray`: crewed exploration of ancient structure; high risk of anomalies; potential artifact recovery.
- `Sensor Net Deployment`: orbital mission to plant scanners; medium risk; increases local detection and reduces future mission risk.

13. Designer Guidance & Balancing
- Tag mission objectives with `difficulty`, `eligible_for_acceleration`, `evidence_value`, `contamination_risk`, and `required_certificates`.
- Use evidence accrual to pace story arcs — avoid revealing too much too quickly. Higher evidence may attract NPC/House interest or cult activity.
- Test mission durations and rewards carefully; ensure orbital/remote options remain attractive for players who avoid high‑risk crewed runs.

---

This codex provides a framework for classic sci‑fi away missions integrated with your campaign systems and the Necronomicon narrative. I can now:
- add sample mission JSON fixtures and a small mission simulator (Python) to validate balancing, or
- generate a design spreadsheet (CSV) with example missions, durations, rewards, and evidence scores for tuning.
