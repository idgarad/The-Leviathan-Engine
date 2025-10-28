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
  - **Small:** 1 gate (always a dead end)
  - **Medium:** 2 gates (forms a pipe/linear connection)
  - **Large:** 3 gates (forms a branch/one-to-many connection)
  - **Extra Large:** 5 gates (major hub/crossroads)
- Small gates connect members within an array.
- Medium gates connect arrays to each other. Each array must have at least 1 medium gate (making it a dead end) and up to 4 medium gates linking to nearby arrays.
- Large gates link territories, but are only present in the special "Imperial Eye of Territory [TerritoryID]" system and are not player-accessible.
- The average distance between solar systems is 4–20 light years; between arrays, 40–90 light years.
- All system and array locations are generated assuming a disc-shaped galaxy.
- There must always be a valid path between any two systems in the network.
- ISC-provided gates have limited capacity and must be upgraded by houses for higher throughput.
- Star gates are enormous colonies, with populations reaching a million for small gates and more for larger gates.

### Lore Details
- Star gates are constructed as a pair at the same location. Once built, one gate is initialized and makes a one-time jump to its destination system. This process is fully automated and lethal to living organisms, so no one survives the initial jump.
- During world generation, the ISC only constructs initial star gates linking the Imperial Eye to each house's starting solar system. Houses are responsible for building additional gates and upgrading ISC gates.

## Beachhead Phase
- The Beachhead phase marks the initial stage of each campaign. During this period, houses race to establish strong positions and secure strategic assets before the Imperial Throne begins offering fiefdoms of the unclaimed arrays.
- Clans may also take advantage of this window, venturing into unclaimed territory to snatch up valuable resources and opportunities before potential rivals can stake their claims.

## Example: Structuring a 5000 Solar System Territory

To create a territory with 5000 solar systems that offers tactical variety—dead ends, choke points, dangerous zones, and strategic opportunities—follow this algorithm:

### Step-by-Step Algorithm
1. **Divide into Arrays:**
   - Group solar systems into arrays of 3–9 systems each (average 6).
   - For 5000 systems, generate ~555–1666 arrays (e.g., 800 arrays of 6–7 systems).

2. **Assign System Sizes:**
   - For each system, randomly assign a size:
     - Small (1 gate, dead end): ~30%
     - Medium (2 gates, pipe): ~40%
     - Large (3 gates, branch): ~25%
     - Extra Large (5 gates, hub): ~5%
   - This mix ensures plenty of dead ends, pipes, branches, and a few major hubs.

3. **Place Systems (Disc Galaxy):**
   - Use polar coordinates (r, θ) to distribute systems in a disc shape.
   - Ensure minimum distance (4–20 light years) between systems in an array.
   - Place arrays 40–90 light years apart.
   - When placing initial house homeworlds, ensure they are equidistant in terms of network traversal: require a minimum of 20 jumps and at least 5 arrays between any two house homeworlds.

4. **Connect Systems Within Arrays (Small Gates):**
   - Use a minimum spanning tree (MST) to connect all systems in each array, ensuring no isolated systems.
   - Add extra connections (up to gate limits) to create loops and redundancy.

5. **Connect Arrays (Medium Gates):**
   - For each array, assign 1–4 medium gates to connect to nearby arrays (using k-nearest neighbor).
   - Ensure every array is reachable from any other array (run a connectivity check).

6. **Assign Dangerous Zones:**
   - Mark some arrays/systems as dangerous (e.g., near black holes, hostile NPCs, environmental hazards).
   - Place these strategically to create risk/reward areas and tactical choke points.

7. **Create Choke Points and Dead Ends:**
   - Use small and medium systems to form dead ends and linear connections.
   - Place large and extra large systems at intersections to form branches and hubs.
   - Ensure some arrays have only one medium gate (dead end arrays), while others have multiple (crossroads).
   - Extra large systems may scan for and discover additional nearby star systems that the ISC missed. Each extra large system has the potential to add a 'bonus' star system to its array, expanding tactical options without requiring spurious gate connections.

8. **Validate Network:**
   - Run a pathfinding algorithm (BFS/DFS) to confirm every system is reachable.
   - Adjust connections if isolated clusters are found.

9. **Add Lore and Strategic Features:**
   - Assign names, lore, and strategic value to key systems (e.g., resource-rich, contested, historic).
   - Place Imperial Eye and initial house systems as starting points.

### Result
This approach produces a territory with:
- Dead ends for ambushes and secret bases
- Choke points for strategic control
- Dangerous zones for high-risk, high-reward gameplay
- Hubs and crossroads for trade and faction interaction
- A fully connected, disc-shaped network with organic tactical variety

## Solar System Generation Guidelines
- Each solar system contains between 3 and 12 planets.
- Non-terran rocky planets have 3–8 moons; gas giants have 0–12 moons.
- Support shattered planets and other sci-fi trope planets in hospitable orbits (e.g., ocean worlds, desert worlds, crystal planets).
- Planets may have rings; document both major and minor rings for accurate rendering and event/anomaly placement.
- Eccentric and rare non-planar orbits should occur occasionally.
- Dwarf planets are present in asteroid belts.
- Comets are named and referenced as lore items only.
- All orbits are accurate and elliptical.
- Twin star systems may be generated if a habitable zone is possible based on stellar masses.
- For canonical planet locations, briefly simulate 2,000–5,000 years of orbital movement to determine ending positions, ensuring systems are not rendered as fixed lines and reflect dynamic history.

## Hidden Wormhole Network & Alternate Territory Map
- In addition to the main ISC-mapped territory, there exists a hidden, wormhole-driven network of systems.
- This alternate map is roughly 1/5th the size of the ISC territory and includes hidden, non-ISC worlds.
- Systems in this network are linked by strange and disturbing 'natural' star gates (wormholes) that can lead to any other system in the territory, creating unpredictable shortcuts and secret routes.
- The wormhole network offers unique exploration, lore, and gameplay opportunities, and may serve as a source of anomalies, rare resources, or emergent threats.
- Unlike the ISC star gate network, the wormhole territory is 'flat'—there are no arrays or regions, just a single undifferentiated network of systems.
- There are no communications arrays in wormhole territories; communication is limited to ship-to-ship comms only, increasing isolation and risk.
- Distances between wormhole systems are unknown; they may all reside in the same galaxy or be spread across millions of galaxies.
- Initially, there are no habitable worlds or colonies in wormhole space.
- Wormholes between ISC territory and wormhole territory are unstable, appearing randomly for random durations and called unstable wormholes.
- The gates that link wormhole systems to each other are static and persistent.
- A common discovery in wormhole space is the ruins of lost colonies—sites where people once attempted to settle but ultimately failed. These ruins exhibit peculiar and unsettling features: some are impossibly ancient, others disturbingly new (e.g., a still-hot cup of coffee on the table with no one present). Some show evidence of attacks, while others are perfectly intact with no one present. These phenomena reinforce the cosmic horror themes that permeate wormhole space.

---

> **Supplemental Reading:**
> - "The Art of Game Design" by Jesse Schell
> - "Role-Playing Game Storytelling" by S. John Ross
> - "Worlds Without End" by James L. Cambias
