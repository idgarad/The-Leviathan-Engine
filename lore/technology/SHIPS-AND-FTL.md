- The Right to Ransom policy is a major factor in the creation and persistence of pirate factions, who exploit formal ransom procedures for profit and influence.
- Aggressors have a 'Right to Ransom' if a ship is taken in combat. Survivors may be held hostage and ransomed as a formal act, especially among USO members.
- The ransom rate is set by the Imperial Throne and paid by the USO, as all USO members carry Ransom Insurance.
- Officers must carry personal policies; Operators (players) pay regular premiums to the USO to cover their insurance while crewing a ship.
### Survival Protocols & Damage Response
- Corridor Units (CU) do not detach; crew remain with the disabled ship for safety and local gravity.
- Upon disablement, the ship's mainframe enters surrender mode and activates a distress beacon, per USO policies and Imeperial Law.
- Ships are engineered for survivability, not to explode; USO crews ships, not bombs.
- Pirates and other factions respect distress beacons and cease fire when activated.
### H-Space Sensitivity & Officer Effects
- Officers sensitive to H-Space may suffer penalties or lose buffs they provide to the crew during/after jumps.
- Engine models officer traits and applies effects accordingly.
- Ship hulls have a baseline cooldown stat.
- TRS modules act as coefficients to reduce cooldown duration.
- Cooldown formula: `Cooldown = Baseline * TRS_Coefficient`.
- Navigation and communication function as in normal space; wormhole gates are semi-organic structures stabilizing W-Space.
- Wormhole travel is a variant of H/J-Space with unique gate mechanics.
- Star gates can be built by people; gates are evacuated before initialization, which is automated and lethal to living organisms.
- Engine models gate construction, evacuation, and initialization events.
- Players interact with factions, clans, and corporations via NPCs, contracts, and consequences of actions.
- Reputation system tracks player actions (e.g., attacking faction ships affects standing).
- FTL travel exploits compressed spacial dimensions, with two discovered so far:
## FTL Mechanics: Relative Space & Energy Effects

- There is no true "faster than light" travel; ships are still bound by the speed of light in their current space.
- FTL exploits the fact that J-Space and H-Space are "smaller" relative to Conventional Space (C-Space), so distances are compressed and travel appears much faster.
- A major side effect is the accumulation of excess energy during jumps due to the mismatch between spaces.
- Star Gates are massive and equipped to handle the excess energy and heat; ships are not.

### Thermal Regulation Subsystem (TRS) & Cooldown
- FTL jumps generate tremendous excess heat; ships must dissipate this to avoid catastrophic failure.
- Ships are equipped with TRS (Thermal Regulation Subsystem) modules to bleed off excess energy and heat.
- Only a tiny fraction (<1%) of jump energy can be stored; the rest must be radiated away.
- Without proper TRS, a ship exiting H-Space could reach temperatures over 8,000°C.
- After a jump, energy subsystem breakers engage until heat/energy returns to safe levels—this is the "cooldown" period.
- Cooldown duration scales with ship mass and TRS capacity:
	- Covert ships invest heavily in TRS to reduce cooldown (target: <20 seconds).
	- Capital ships may require hours or days to cool down.
- During cooldown, ships emit intense radiation and are highly visible to sensors.
- Tactical implication: Ships are vulnerable and easily detected during cooldown; stealth/capital ship strategies must account for this.
# Ships & FTL Lore Reference

> **Update Notice:** Accurate as of October 29, 2025. For latest lore and technical details, consult this document and related lore files.

## Core Design Principles
- **No windows in space ships:** All visual feedback is via sensors, tactical overlays, or camera feeds. USO mandates double hull design, making windows structurally impossible and tactically unsound.
- **Safety, modularity, and redundancy** are prioritized in ship design.

## Ship Design Philosophy

### Corridor Units (CU)
- Ships are constructed from standardized, modular Corridor Units (CU), similar to "lego bricks".
- Each CU is sealed at both ends by sheer doors capable of cutting through any obstruction to isolate sections instantly.
- Every CU is engineered as a self-contained survival pod, supporting up to 10 people for 60 days with independent life support and resources.
- Cargo holds and specialized rooms are scaled in CUxCUxCU measurements and assembled into the ship's Spine.

### Hull Construction
- The ship's Spine, engines, and infrastructure are assembled first.
- A flexible, cast-like laminate is applied to form the Inner Laminate Hull (ILH), protecting crew from environmental hazards (e.g., radiation).
- The External Perimeter Hull (EPH) is constructed around the ILH, typically in upper/lower "clam-shell" halves clamped together, creating an equator seam for major maintenance.
- The space between ILH and EPH is the Inter Hull Cavity (IHC), filled with Nanite Mediation Compound (NMC):
	- NMC is a semi-liquid scaffolding material for maintenance drones/nanites.
	- When exposed to vacuum or oxygen, NMC expands and hardens, sealing breaches ("Scabbing").
	- NMC is engineered to smell like rotten eggs, alerting crew to leaks.

### Bridge Placement
- The bridge is always located at the core of the ship, maximizing distance from the exterior for crew safety.

## FTL (Faster-Than-Light) Travel Philosophy

### Physics of FTL: Compressed Spacial Dimensions
- FTL travel exploits compressed spacial dimensions, with two discovered so far:
	- **Hilbert Space (H-Space, "Hyper-space")**: Used for inter-solar system jumps, requires no external infrastructure. Lower energy, lower risk, but some individuals are sensitive to H-Space transitions.
	- **Jump Space (J-Space)**: Used for interstellar travel, requires Star Gates except for massive ships with Slip Drives. Higher energy, greater risk, and requires precise mapping.

### Star Gates & Quantum Shadow Map (QSM)
- Star Gates enable J-Space travel by mapping ships to a Quantum Shadow Map (QSM).
- QSM is linked to an entangled particle pair: one at the departure gate, one at the arrival gate.
- The QSM acts as a "True Reference Point of Reality," ensuring all mapped matter arrives intact and unaltered.
- Without QSM mapping, J-Space travel risks catastrophic reassembly ("scrambled egg" effect).

### FTL Drives & Propulsion
- Ship propulsion combines force field emitters, maneuvering thrusters, main thrusters, and FTL drives (for H-Space jumps).
- Large ships may be equipped with Slip Drives, enabling direct J-Space travel without gates.

### Safety & Regulation
- USO and other authorities regulate FTL travel, screening for individuals sensitive to H-Space jumps.
- Civilian ships rely on Star Gates for J-Space; military/courier vessels may have advanced FTL capabilities.

## Narrative Context
- The absence of windows and reliance on sensors reinforces the tactical, non-cinematic nature of ship operations.
- FTL travel is a strategic resource, shaping trade, warfare, and exploration.
- Ship design and FTL mechanics are deeply integrated into gameplay, progression, and faction politics.

## Further Reading
- [Leviathan Engine Lore Index]
- [TERRITORY-GENERATION.md]
- [Game Physics Engine Development by Ian Millington]
- [Designing Games by Tynan Sylvester]

---
For additional ship and FTL lore, add new markdown files to this folder. Keep this resource up to date for your team!
