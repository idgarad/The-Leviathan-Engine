\## Idgarad Conceptual Model (ICM) - Feature Design Framework



\### Three-Tier Content Philosophy

Every gameplay feature must be analyzed across three interaction tiers:



\*\*Tier 1 - Individual/Solo Content\*\*

\- Single-player experience and personal progression

\- What can one player accomplish alone?

\- Personal skill development and mastery

\- Individual resource gathering and crafting



\*\*Tier 2 - Group Content\*\*  

\- Small group cooperation (2-10 players)

\- Shared objectives requiring coordination

\- Enhanced capabilities through teamwork

\- Group-specific mechanics and rewards



\*\*Tier 3 - Faction/Alliance Content\*\*

\- Large-scale organizational activities

\- Political and economic influence

\- Territory control and resource management

\- Inter-faction conflict and cooperation



\### ICM Feature Analysis Template

When implementing any gameplay feature, document all applicable tiers:



```markdown

\# Feature: \[Feature Name]



\## Justification

\*\*Why Added\*\*: \[Clear explanation of why this feature enhances the virtual reality]



\## Tier Analysis



\### Tier 1 - Individual Content

\- \*\*Core Mechanics\*\*: \[How individuals interact with this feature]

\- \*\*Progression\*\*: \[Personal advancement opportunities]

\- \*\*Resources\*\*: \[Individual resource requirements and rewards]



\### Tier 2 - Group Content  

\- \*\*Cooperative Elements\*\*: \[How groups enhance the experience]

\- \*\*Coordination Requirements\*\*: \[What teamwork enables]

\- \*\*Shared Benefits\*\*: \[Group-specific advantages]



\### Tier 3 - Faction/Alliance Content

\- \*\*Organizational Impact\*\*: \[Large-scale implications]

\- \*\*Political Elements\*\*: \[How this affects faction relationships]

\- \*\*Economic Influence\*\*: \[Market and resource control aspects]



\## Implementation Notes

\- \*\*Database Schema\*\*: \[Required data structures]

\- \*\*Game Logic\*\*: \[Core processing requirements]  

\- \*\*User Interface\*\*: \[Player interaction methods]

\- \*\*Lore Integration\*\*: \[How this fits the game world]

```



### Example: Fishing System ICM Analysis

```markdown
# Feature: Fishing System

## Justification
**Why Added**: Fishing provides a meditative, skill-based activity that enhances the virtual world's realism and offers alternative progression paths beyond combat.

## Tier Analysis

### Tier 1 - Individual Content
- **Core Mechanics**: Personal fishing skill, equipment management, bait selection
- **Progression**: Fishing skill levels, rare fish collections, crafting fishing gear
- **Resources**: Individual catch quotas, personal fishing spots, tackle consumption

### Tier 2 - Group Content
- **Cooperative Elements**: Charter boat expeditions, commercial fishing operations
- **Coordination Requirements**: Crew roles (captain, navigator, net handlers)
- **Shared Benefits**: Larger catches, access to deep-water fishing grounds

### Tier 3 - Faction/Alliance Content
- **Organizational Impact**: Fishing fleet management, maritime territory control
- **Political Elements**: Fishing rights negotiations, trade route protection
- **Economic Influence**: Market manipulation through supply control, fishing monopolies
```

### Dynamic Content Scaling Philosophy
**Content should scale to players, not the reverse:**

```markdown
# Example: Pirate Hideout Encounter

## Scaling Implementation
- **Single Player**: Skeleton crew, basic defenses, personal loot
- **Small Group (2-6)**: Full crew, moderate defenses, shared treasure
- **Large Force (7+)**: Reinforcements arrive, heavy defenses, faction-level rewards

## Technical Requirements
- Dynamic NPC spawning based on player count
- Scalable reward systems (loot quality/quantity)
- Adaptive difficulty that maintains challenge without frustration
- Lore-consistent explanations for scaling (reinforcements, alert levels)
```

**Scaling Principles:**
1. **Player-Centric Design**: Content adapts to participant numbers, not vice versa
2. **Meaningful Challenge**: Difficulty scales to remain engaging at all levels
3. **Proportional Rewards**: Benefits scale appropriately with increased participation
4. **Lore Consistency**: Scaling feels natural within the game world context
5. **Accessibility**: Content remains accessible regardless of group size

### Feature Justification Requirements
**Every feature addition must include clear justification:**

- **Lore Compliance**: How does this enhance the fictional virtual reality?
- **Engagement Value**: What type of "hobby" experience does this provide?
- **Tier Interaction**: How do the three tiers create meaningful progression?
- **World Integration**: How does this feature interconnect with existing systems?
- **Scaling Design**: How does this feature adapt to different participant levels?

### Documentation Standards for ICM
All feature documentation must include:

1. **Justification Statement**: Clear reason for adding the feature
2. **Tier Analysis**: Complete breakdown of all applicable interaction levels
3. **Integration Map**: How the feature connects to existing systems
4. **Progression Paths**: Individual to organizational advancement opportunities
5. **Emergent Possibilities**: Unplanned interactions the feature might enable

### ICM Implementation Guidelines
When coding features:

```go
// Every gameplay feature should be designed with ICM tiers in mind
type GameplayFeature interface {
    // GetTierCapabilities returns what's possible at each interaction tier
    GetTierCapabilities() TierCapabilities
    
    // ProcessIndividualAction handles Tier 1 interactions
    ProcessIndividualAction(player *Player, action Action) (*Result, error)
    
    // ProcessGroupAction handles Tier 2 interactions  
    ProcessGroupAction(group *Group, action Action) (*Result, error)
    
    // ProcessFactionAction handles Tier 3 interactions
    ProcessFactionAction(faction *Faction, action Action) (*Result, error)
    
    // ScaleToParticipants dynamically adjusts content based on player count
    ScaleToParticipants(participants []Player) ScalingParameters
}

// TierCapabilities documents what's possible at each level
type TierCapabilities struct {
    Individual []Capability // Tier 1 possibilities
    Group      []Capability // Tier 2 enhancements  
    Faction    []Capability // Tier 3 organizational features
}

// ScalingParameters define how content adapts to different group sizes
type ScalingParameters struct {
    Difficulty      float64 // Challenge scaling factor
    Rewards         RewardScale // Loot and experience scaling
    NPCCount        int     // Number of opponents/allies
    Reinforcements  bool    // Whether additional forces arrive
    LoreExplanation string  // In-world reason for scaling
}

// Example: Scalable encounter implementation
func (encounter *PirateHideout) ScaleToParticipants(participants []Player) ScalingParameters {
    playerCount := len(participants)
    
    switch {
    case playerCount == 1:
        return ScalingParameters{
            Difficulty:      1.0,
            Rewards:         RewardScale{Personal: true, Quantity: 1.0},
            NPCCount:        3, // Skeleton crew
            Reinforcements:  false,
            LoreExplanation: "A small outpost with minimal defenses",
        }
    case playerCount <= 6:
        return ScalingParameters{
            Difficulty:      1.2,
            Rewards:         RewardScale{Shared: true, Quantity: 1.5},
            NPCCount:        8, // Full crew
            Reinforcements:  true,
            LoreExplanation: "The pirates call for backup when facing multiple attackers",
        }
    default: // Large force
        return ScalingParameters{
            Difficulty:      1.5,
            Rewards:         RewardScale{Faction: true, Quantity: 2.0},
            NPCCount:        15, // Multiple ships respond
            Reinforcements:  true,
            LoreExplanation: "Allied pirate ships converge to defend the stronghold",
        }
    }
}
```
