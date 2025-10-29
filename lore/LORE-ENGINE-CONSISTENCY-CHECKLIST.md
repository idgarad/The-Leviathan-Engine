# Lore Consistency & Engine Simplification Checklist

> **Update Notice:** Accurate as of October 29, 2025. Use this checklist to track lore/engine alignment and clarify implementation details.

## 1. Ship Damage & Survival Protocols
- No CU detachment; crew remain with disabled ship for safety and local gravity.
- Mainframe activates surrender mode and distress beacon upon disablement.
- Ships are engineered for survivability, not to explode; USO crews ships, not bombs.
- Pirates and other factions respect distress beacons per USO law.

## 2. H-Space Sensitivity & Officer Effects
- Officers sensitive to H-Space may suffer penalties or lose buffs they provide to the crew.
- Engine should model officer traits and apply effects during/after H-Space jumps.

## 3. TRS & Cooldown Calculation
- Ship hulls have a baseline cooldown stat.
- TRS modules act as coefficients to reduce cooldown duration.
- Engine should document formula for cooldown: `Cooldown = Baseline * TRS_Coefficient`.

## 4. Wormhole Space Mechanics
- Navigation and communication function as in normal space; wormhole gates are semi-organic structures stabilizing W-Space.
- Engine should treat wormhole travel as a variant of H/J-Space with unique gate mechanics.

## 5. Star Gate Construction & Safety
- Star gates can be built by people; gates are evacuated before initialization, which is automated and lethal to living organisms.
- Engine should model gate construction, evacuation, and initialization events.

## 6. Faction/Clan/Corporation Interaction
- Players interact via NPCs, contracts, and consequences of actions.
- Reputation system tracks player actions (e.g., attacking faction ships affects standing).
- Engine should document NPC interaction types and reputation consequences.

---
Update this checklist as lore and engine features evolve. Use it to ensure all gameplay and technical systems remain consistent with established worldbuilding.
