# Consolidated Documentation for Manual Parsing

---

## PRIMARY-NARRATIVE.md

# The Leviathan Engine - Primary Narrative

> **NOTICE:** This lore document was accurate at the time of publishing (October 2025). The narrative and world details may evolve as development progresses. Always refer to the latest version for updates.




---

## TERRITORY-GENERATION.md

## Survival Protocols & Damage Response
- Ships do not eject escape pods; crew remain with disabled ships for safety and local gravity.
- Distress beacons are activated by ship mainframes upon disablement, and all factions respect these signals per USO law.
- Navigation and communication in wormhole space function as in normal space; wormhole gates are semi-organic structures stabilizing W-Space.
- Players interact with factions, clans, and corporations via NPCs, contracts, and consequences of actions.
- Reputation system tracks player actions and affects standing with groups.
# Core Design Principle: There are no windows in space ships
- All visual feedback is via sensor data, tactical overlays, or camera feeds (internal or drone-based).
- No real-time graphics; all player views are abstracted, tactical, or sensor-driven.
- USO (United Systems Organization) mandates double hull design for all spacecraft, making windows structurally impossible and tactically unsound.
# Territory Generation Expectations

> **NOTICE:** This document was accurate at the time of publishing (October 2025). Territory generation rules and structures may evolve as development progresses. Always refer to the latest version for updates.
>
> **For additional information, please see:**
> - [Book] "The Kobold Guide to Worldbuilding" by Wolfgang Baur
> - [Book] "Building Imaginary Worlds" by Mark J.P. Wolf
> - [Book] "Wonderbook: The Illustrated Guide to Creating Imaginative Fiction" by Jeff VanderMeer

## Overview
This document outlines the expectations and structural rules for generating territories in The Leviathan Engine. Territories are the primary units of play during campaigns and are designed to balance lore, gameplay, and technical constraints. All territory generation must be fully documented and reproducible for both engine and educational purposes.

## Hierarchical Structure
Territories are organized using the following hierarchy:
- **Galaxy**
  - **Sectors**
    - **Territories**
      - **Regions**
        - **Arrays** (fiefdoms)
          - **Solar Systems**
            - **Planets & Moons**

## ISC Survey Protocol
- Only "Economically Viable" star systems are mapped and included in territories.
- Each ISC-listed solar system must have at least one hospitable planet.
- Hostile or undocumented systems may exist nearby, but are not part of official campaign play.
- Starting systems available for house bidding must include at least one gas giant for shipyard infrastructure.

## Array & Fiefdom Rules
- Arrays are the fundamental fiefdoms granted to noble houses.
- Each house receives a Sovereign Array that cannot be revoked.
- Administration of an array is called a Stewardship; each solar system is managed by a Governor.
- Governorships may be offered to Clans; powerful Clans may be granted stewardship of entire arrays.
- Houses must petition the Imperial Throne for claim rights; arrays may be granted to rivals or set as 'Contested.'
- Minimum 5 arrays must separate any two initial house homeworlds, with at least 20 jumps between them for strategic balance.

## Planetary & Orbital Infrastructure
- Colonized planets must have a terrestrial space port (Imperial Engineering Co. & CISP requirement).
- Orbital infrastructure is regulated by CISP:
  - **Terra-class planets:** Max 4 space stations, up to 50,000 low orbit satellites
  - **Gas giants:** Max 6 space stations, only class allowed shipyards
  - **Moons/other bodies:** Limits set by CISP standards
- Arcologies may exist in star orbit, less regulated, often havens for cartels or free ports.

## Clans & Faction Dynamics
- 31 chartered clans available for players to join
- Clans compete and experience infighting, mirroring house rivalries
- Corporations operate in the background, seeking advantage as houses and clans vie for territory

## Campaign Contract System
- Players sign initial contracts with major houses for 1/3 campaign duration
- Open Contracts available at campaign start; more options as campaign progresses
- Contract renewal allows strategic choices: switch houses, join minor houses, or corporations

## Contested Arrays & Emergent Play
- The Imperial Throne may declare arrays or systems 'Contested,' open for any group to claim
- Minor houses and ambitious clans can rise by exploiting contested opportunities
- Only houses can hold fiefdoms; corporations influence indirectly

## Generation Guidelines
- Lore consistency (faction, history, culture)
- Gameplay variety (missions, infrastructure, contested zones)
- Technical feasibility (server load, database structure)
- Include a mix of major and minor houses, clans, and corporations
- Feature at least one contested array or system
- Provide opportunities for trade, conflict, and exploration
- Reflect the dynamic interplay of ISC, Throne, houses, clans, and corporations

## Star Gate Network Structure
- Gates are always constructed in pairs, ensuring direct two-way travel between connected systems.
- Solar systems come in four sizes, each determining the maximum number of gates:

---

## history/README.md

- Ships do not eject escape pods; crew remain with disabled ships for safety and local gravity.
- Distress beacons are activated by ship mainframes upon disablement, and all factions respect these signals per USO law.
- Players interact with factions, clans, and corporations via NPCs, contracts, and consequences of actions. Reputation is affected by player choices.
# Primary Narrative & World Design Principles

> **Update Notice:** Accurate as of October 29, 2025. For latest lore and narrative, consult this document and related lore files.

## Core Design Principle: There are no windows in space ships
- All visual feedback is via sensor data, tactical overlays, or camera feeds (internal or drone-based).
- No real-time graphics; all player views are abstracted, tactical, or sensor-driven.
- USO (United Systems Organization) mandates double hull design for all spacecraft, making windows structurally impossible and tactically unsound.

## Narrative Context
- The absence of windows is a direct result of safety, tactical, and regulatory requirements in the Leviathan universe.
- Players experience the world through advanced sensors, tactical displays, and remote camera feeds, reinforcing immersion and realism.

---
For additional lore and narrative updates, add new markdown files to this folder. Keep this resource up to date for your team!

---

## technology/SHIPS-AND-FTL.md

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

---

## wiki/Beginner-Guide-CI-CD.md

...existing content...

## wiki/Database-Backend-Selection.md

...existing content...

## wiki/Design-Concerns.md

...existing content...

## wiki/Docker-Tips.md

...existing content...

## wiki/Test-Lab-Architecture.md

...existing content...

---

# End of Consolidated Documentation
