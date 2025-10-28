# The Leviathan Engine - AI Coding Agent Instructions

## Project Overview

The Leviathan Engine is a scalable, text-based MUD/MMO engine written primarily in Go. This project builds upon lessons learned from the BlackCitadel project, focusing on incremental delivery of working software with comprehensive documentation for educational use.

**Key Philosophy**: This project serves as both a functional MUD engine and a comprehensive tutorial/teaching reference for game engine development.

## Developer Health & Wellness Reminders

**IMPORTANT HEALTH NOTICE**: The developer (Idgarad) tends to get deeply focused on coding and forget essential self-care. As the AI assistant, you should periodically (every 2-3 hours of active coding or after significant task completions) remind them to:

- **Take a walking break** - Even 10-15 minutes helps with circulation and mental clarity
- **Eat something** - Coding sessions can easily skip meals
- **Hydrate** - Keep water nearby and drink regularly
- **Rest your eyes** - Look away from the screen, focus on distant objects
- **Stretch** - Arthritis considerations make regular movement important

**Sample gentle reminders to include in responses:**
- "Great progress! Don't forget to take a quick walk break to keep those creative juices flowing."
- "Before we tackle the next feature, might be a good time to grab a snack and stretch a bit."
- "Nice work on that implementation! Remember to stay hydrated and give your eyes a rest."

This is especially important during intensive coding sessions or complex problem-solving work.

**Design Philosophy**: Drawing inspiration from exceptional terminal-based programs like BTOP, BPYTOP, and tmux, we prioritize clean, efficient interfaces with comprehensive real-time monitoring. Our background in test environment support drives extensive metrics collection, KPI tracking, and automated testing capabilities.

**Idgarad Conceptual Model (ICM)**: The MMO is a tool to interact with a fictional virtual reality - it's less a game and more of a hobby. You can no more "beat" an MMO than you can "beat" gardening. This philosophy shapes how we design and implement all gameplay features.

## Technology Stack & Architecture

### Primary Language: Go
- **Main Engine**: Go 1.25.3+ for all core components
- **Target Platform**: Linux servers (primary), Windows development
- **Database**: SQLite for development, PostgreSQL for production scaling
- **Protocol**: JSON-lines over TCP for client communication
- **Build Tool**: Standard Go tooling (`go mod`, `go build`)

### Proven Patterns from BlackCitadel
- JSON-lines protocol for loose coupling between components
- Grid-based spatial partitioning for active game regions  
- SQLite with WAL mode for reliable persistence
- Modular plugin architecture for gameplay systems
- Comprehensive performance monitoring and regression testing

## Code Quality & Documentation Standards

### Comprehensive Self-Documentation
**Every function, struct, and package must have complete documentation:**

```go
// PlayerManager handles all player-related operations including authentication,
// session management, and state persistence. It maintains both in-memory
// active player data and coordinates with the database for long-term storage.
//
// The manager follows the "as above, as below" principle where NPCs and 
// players use identical underlying systems and capabilities.
type PlayerManager struct {
    // activePlayer maps player UUID to their current session data
    // This is the authoritative source for online player state
    activePlayers map[string]*PlayerSession
    
    // db provides persistent storage for player data
    // All player state changes must be persisted here
    db *persistence.Database
    
    // mu protects concurrent access to activePlayers map
    // Always acquire this lock before modifying player state
    mu sync.RWMutex
}

// AuthenticatePlayer verifies player credentials and establishes a new session.
// This function handles both existing player login and new player registration.
//
// The authentication process:
// 1. Validates username and token against database
// 2. Creates new PlayerSession with unique session ID  
// 3. Registers session in activePlayer map
// 4. Returns session info for client handshake
//
// Returns error if authentication fails or if player is already online.
func (pm *PlayerManager) AuthenticatePlayer(username, token string) (*PlayerSession, error) {
    // Implementation with detailed inline comments...
}
```

### Documentation Directory Structure
Maintain this structure and update with every significant change:

**Documentation Update Requirements:**
Every documentation section (in markdown, HTML, or code comments) must include:
1. An update notice stating instructions were accurate at the time of publishing and may change.
2. A "For additional information, please see ..." section with official documentation links.
3. Book recommendations for further learning, where relevant.

Maintain this structure and update with every significant change:

```
docs/
├── ARCHITECTURE.md          # High-level system design and data flow
├── API.md                   # Protocol specification and examples
├── DATABASE.md              # Schema design and persistence patterns  
├── MODULES.md               # Plugin system architecture
├── PERFORMANCE.md           # Benchmarking and optimization guidelines
├── TESTING.md               # Comprehensive testing strategies and KPI tracking
├── MONITORING.md            # Real-time metrics and dashboard configuration
├── TUTORIALS.md             # Step-by-step implementation guides
├── DATA_DICTIONARY.md       # Complete data structure reference
├── diagrams/                # SVG infrastructure diagrams
│   ├── system-overview.svg
│   ├── data-flow.svg
│   ├── grid-architecture.svg
│   ├── protocol-flow.svg
│   ├── performance-metrics.svg
│   └── testing-pipeline.svg
├── examples/                # Code examples for tutorials
│   ├── basic-client/
│   ├── simple-module/
│   ├── custom-commands/
│   └── performance-testing/
└── reports/                 # Automated test and performance reports
    ├── performance/         # Performance regression reports (HTML format)
    ├── coverage/           # Code coverage analysis (HTML dashboards)
    └── kpi/                # KPI tracking and trends (HTML reports)
```

### Human-Readable Changelog
Update `CHANGELOG.md` with every commit using this format:

```markdown
## [Unreleased]

### Added
- PlayerManager with comprehensive session handling
- JSON-lines protocol implementation with examples
- SQLite persistence layer with transaction safety

### Changed  
- Refactored command processing to use structured interfaces
- Updated documentation with new architecture diagrams

### Technical Details
- **Performance**: Player authentication now completes in <10ms (95th percentile)
- **Database**: Added indices for player lookup operations (40% query improvement)
- **Testing**: Integrated automated performance regression tests with alerting
- **KPI Metrics**: Added real-time command throughput tracking (BTOP-inspired)
- **Coverage**: Achieved 85% code coverage with integration tests

### Testing & Quality Metrics
- **Load Testing**: Validated 500 concurrent players (target: 1000)
- **Performance Regression**: No degradation detected in automated baseline comparison
- **Memory Efficiency**: 12MB per 1000 active players (within target)
- **Uptime**: 99.9% availability during 7-day stress test

### Documentation Updates
- Added tutorial: "Building Your First MUD Command"
- Updated API.md with authentication flow examples
- Generated new system architecture SVG diagram
- Updated performance metrics dashboard configuration
```

## Development Workflow & Standards

### File Organization Patterns
Follow these Go project conventions:

```
cmd/
├── server/              # Main server executable
└── tools/              # Administrative utilities

internal/
├── core/               # Core engine systems
│   ├── player/         # Player management
│   ├── world/          # World state and geography  
│   ├── command/        # Command processing
│   └── protocol/       # Network protocol handling
├── persistence/        # Database abstractions
├── modules/           # Plugin system
└── config/            # Configuration management

pkg/                   # Public APIs (if any)
docs/                  # All documentation
examples/              # Tutorial code samples
tests/                 # Integration and performance tests
├── integration/       # End-to-end integration tests
├── performance/       # Load testing and benchmarks
├── regression/        # Automated regression test suite
└── kpi/              # KPI validation and monitoring tests
lore/                  # Game world lore and content organization
├── factions/          # Political entities and organizations
├── locations/         # Worlds, systems, stations, and regions
├── history/           # Timeline and historical events
├── technology/        # Tech trees and capabilities
├── economy/           # Trade routes, resources, markets
└── cultures/          # Species, languages, customs
```

### Performance & Monitoring (Terminal-Inspired Excellence)
Implement comprehensive metrics collection inspired by BTOP/BPYTOP monitoring philosophy:

```go
// ProcessCommand handles incoming player commands with performance monitoring.
// Target: <50ms response time for local commands, <200ms for world-affecting commands.
// 
// METRICS PHILOSOPHY: Like BTOP's real-time system monitoring, we track every
// interaction for performance analysis and capacity planning.
func (e *Engine) ProcessCommand(playerID string, cmd Command) error {
    start := time.Now()
    defer func() {
        duration := time.Since(start)
        
        // Multi-dimensional metrics collection (BTOP-style granularity)
        e.metrics.RecordCommandLatency(cmd.Type, duration)
        e.metrics.IncrementCommandCounter(cmd.Type)
        e.metrics.UpdatePlayerActivity(playerID, time.Now())
        
        // Real-time performance alerting (tmux-style status awareness)
        if duration > 100*time.Millisecond {
            e.logger.Warn("Slow command detected", 
                "command", cmd.Type, 
                "duration", duration,
                "player", playerID,
                "threshold_exceeded", "100ms")
            
            // Feed into live monitoring dashboard
            e.monitoring.AlertSlowCommand(cmd.Type, duration, playerID)
        }
        
        // KPI tracking for operational excellence
        e.kpi.RecordCommandProcessingTime(duration)
        e.kpi.UpdateThroughputMetrics()
    }()
    
    // Command processing implementation...
}
```

### Comprehensive Testing & KPI Framework
Build extensive automated testing inspired by test environment best practices:

```go
// TestSuite represents comprehensive testing capabilities with detailed reporting
type TestSuite struct {
    // Performance regression testing (automated baseline comparison)
    perfBaseline *PerformanceBaseline
    
    // Load testing with detailed metrics (like stress testing production systems)
    loadGenerator *LoadGenerator
    
    // Integration testing with external dependencies
    integrationTests *IntegrationTestSuite
    
    // KPI tracking and alerting system
    kpiTracker *KPITracker
}

// PerformanceTest runs comprehensive performance analysis with detailed reporting
// Similar to how BTOP provides system performance insights, this gives engine insights
func (ts *TestSuite) RunPerformanceTest() (*PerformanceReport, error) {
    report := &PerformanceReport{
        Timestamp: time.Now(),
        TestID:    generateTestID(),
    }
    
    // Multi-dimensional performance testing
    report.CommandLatencies = ts.measureCommandPerformance()
    report.ConcurrencyMetrics = ts.measureConcurrentPlayerLoad()
    report.DatabasePerformance = ts.measureDatabaseLatency()
    report.MemoryUsagePatterns = ts.analyzeMemoryConsumption()
    report.NetworkThroughput = ts.measureNetworkPerformance()
    
    // Regression detection (prevent performance degradation)
    if regression := ts.perfBaseline.DetectRegression(report); regression != nil {
        report.RegressionAlerts = append(report.RegressionAlerts, regression)
    }
    
    // Generate comprehensive report (like detailed system diagnostics)
    return report, ts.generateDetailedReport(report)
}

// GenerateHTMLReport creates professional HTML reports for all metrics
// Default reporting format should be HTML for readability and presentation
func (ts *TestSuite) GenerateHTMLReport(report *PerformanceReport) error {
    // Create comprehensive HTML report with:
    // - Executive summary with performance grades
    // - Interactive charts and graphs
    // - Detailed metrics tables
    // - Recommendations and action items
    // - Professional styling suitable for stakeholder review
    return ts.htmlGenerator.CreateReport(report, "reports/performance/")
}
```

### Error Handling Patterns
Use descriptive, actionable error messages:

```go
// Wrap errors with context for debugging and user feedback
if err := pm.db.SavePlayer(player); err != nil {
    return fmt.Errorf("failed to persist player %s to database: %w", 
        player.Username, err)
}

// Create custom error types for different failure modes
type AuthenticationError struct {
    Username string
    Reason   string
}

func (e AuthenticationError) Error() string {
    return fmt.Sprintf("authentication failed for user %s: %s", 
        e.Username, e.Reason)
}
```

## Educational & Tutorial Focus

### Code as Teaching Material
Every implementation should serve as a learning example:

```go
// This example demonstrates the MUD command pattern used throughout
// the engine. New developers should study this as a template for
// implementing additional commands.

// MoveCommand handles player movement between rooms/locations.
// This showcases several key MUD engine concepts:
// - Input validation and sanitization
// - World state queries and updates  
// - Event broadcasting to affected players
// - Error handling with user-friendly messages
type MoveCommand struct {
    // Direction contains the movement direction (north, south, etc.)
    // This should be validated against available exits
    Direction string `json:"direction"`
    
    // Target allows movement to specific named locations
    // This enables commands like "go tavern" or "enter shop"
    Target string `json:"target,omitempty"`
}
```

### Inline Learning Notes
Include educational context in comments:

```go
// Grid represents a spatial region of active gameplay.
// 
// LEARNING NOTE: This implements the "diegetic sharding" concept where
// game world partitioning is explained as in-universe "Command Nodes".
// Players experience network latency as "quantum communication delays"
// making technical limitations feel like natural game mechanics.
//
// This pattern allows seamless scaling - when a region becomes too busy,
// the game can spawn additional "Command Nodes" to handle the load while
// maintaining immersion.
type Grid struct {
    // ID uniquely identifies this grid instance  
    ID string
    
    // SystemID references the star system this grid represents
    // Multiple grids can exist per system (planets, stations, etc.)
    SystemID string
    
    // Players contains all active player sessions in this grid
    // This map provides O(1) lookup for player operations
    Players map[string]*PlayerSession
}
```

### Tutorial Documentation Requirements
Generate step-by-step tutorials for major features:

1. **"Building Your First Command"** - Complete walkthrough
2. **"Adding New World Content"** - Room, item, NPC creation  
3. **"Creating Custom Modules"** - Plugin development guide
4. **"Performance Optimization"** - Profiling and improvement techniques
5. **"Database Integration"** - Persistence patterns and migrations

## Infrastructure Documentation

### SVG Diagram Generation
Automatically generate and update these diagrams:

```go
// Include this pattern for diagram generation utilities
//go:generate go run tools/generate-diagrams.go

// GenerateSystemDiagram creates an SVG visualization of the current
// system architecture. This should be regenerated whenever major
// components are added or modified.
func GenerateSystemDiagram() error {
    // Implementation that creates docs/diagrams/system-overview.svg
}
```

### Data Dictionary Maintenance
Keep `docs/DATA_DICTIONARY.md` current with every struct change:

```markdown
## Player Data Structure

### PlayerSession
Active player session data (in-memory only)

| Field | Type | Description | Example |
|-------|------|-------------|---------|
| ID | string | Unique session identifier | "sess_1234567890" |  
| Username | string | Player display name | "AdventurerJoe" |
| GridID | string | Current grid location | "grid_sol_earth" |
| LastCommand | time.Time | Timestamp of last activity | "2025-10-27T15:30:00Z" |

### PlayerRecord  
Persistent player data (database storage)

| Field | Type | Description | Constraints |
|-------|------|-------------|-------------|
| UUID | string | Permanent player ID | Primary key, immutable |
| Username | string | Display name | Unique, 3-20 characters |  
| PasswordHash | string | Hashed authentication | bcrypt, never logged |
| Created | timestamp | Account creation time | UTC, indexed |
```

## AI Assistant Guidelines

### Code Generation Preferences
1. **Favor simplicity** - Use standard Go patterns, avoid complex abstractions
2. **Include examples** - Every function should have usage examples in comments  
3. **Performance awareness** - Always consider concurrent access and latency
4. **Educational value** - Code should teach Go and MUD concepts simultaneously
5. **Comprehensive testing** - Generate tests that serve as additional documentation
6. **Metrics integration** - Every component should expose performance metrics (BTOP-style)
7. **Terminal-friendly interfaces** - Clean, efficient status displays like tmux
8. **KPI-driven development** - Include measurable success criteria for all features

### Documentation Generation
When creating new features:
9. Ensure every section includes an update notice, further reading links, and book recommendations as described above.

### Automated Testing Requirements
Every feature must include:
1. **Unit Tests**: 90%+ code coverage with meaningful assertions
2. **Integration Tests**: End-to-end scenarios with real data flows
3. **Performance Tests**: Baseline measurements and regression detection
4. **Load Tests**: Concurrent user simulation with resource monitoring
5. **KPI Validation**: Automated verification of success metrics
6. **Regression Suites**: Automated baseline comparison and alerting

### Error Handling Standards
All errors must be user-friendly with plain language explanations:

```go
// Error messages should be clearly understandable to players and administrators
type PlayerError struct {
    Code        string // Technical error code for logging
    UserMessage string // Plain language explanation for players
    Context     map[string]interface{} // Additional context for debugging
}

func (e PlayerError) Error() string {
    return fmt.Sprintf("[%s] %s", e.Code, e.UserMessage)
}

// Example: Transform technical errors into user-friendly messages
func (pm *PlayerManager) AuthenticatePlayer(username, token string) (*PlayerSession, error) {
    if username == "" {
        return nil, PlayerError{
            Code:        "AUTH_MISSING_USERNAME", 
            UserMessage: "Please enter your character name to connect to the game.",
        }
    }
    
    if err := pm.db.ValidateCredentials(username, token); err != nil {
        return nil, PlayerError{
            Code:        "AUTH_INVALID_CREDENTIALS",
            UserMessage: "The character name or password you entered is incorrect. Please check your spelling and try again.",
            Context:     map[string]interface{}{"username": username, "error": err.Error()},
        }
    }
    
    // Success path...
}

// Graceful degradation for system failures
func (e *Engine) ProcessCommand(cmd Command) (*CommandResult, error) {
    defer func() {
        if r := recover(); r != nil {
            e.logger.Error("Command processing panic recovered", 
                "command", cmd.Type, 
                "panic", r)
            // Don't crash the server - return graceful error to player
        }
    }()
    
    // Command processing with fallback behavior...
}
```

## Project-Specific Patterns

### Command Processing Pattern
```go
// All commands follow this interface for consistency and teachability
type Command interface {
    // Type returns the command identifier (e.g., "move", "look", "say")
    Type() string
    
    // Validate ensures command parameters are correct before execution
    Validate() error
    
    // Execute performs the command and returns results for the player
    Execute(ctx context.Context, player *PlayerSession) (*CommandResult, error)
}
```

### Module Integration Pattern  
```go
// Modules use this interface for hot-swappable gameplay systems
type GameModule interface {
    // Name returns the module identifier for loading/unloading
    Name() string
    
    // OnLoad initializes the module with configuration
    OnLoad(config map[string]interface{}) error
    
    // ProcessCommand handles module-specific commands
    ProcessCommand(cmd Command) (*CommandResult, error)
    
    // OnUnload cleans up resources before module removal
    OnUnload() error
}
```

## Lore-Driven Development

### Game World Lore Organization
Following the BlackCitadel faction system model, maintain comprehensive lore that influences engine development:

```
lore/
├── factions/          # Political entities and organizations
│   ├── governments/   # Planetary and system governments
│   ├── corporations/  # Commercial entities and trade guilds
│   ├── military/      # Armed forces and security organizations
│   └── underground/   # Criminal syndicates and rebel groups
├── locations/         # Physical game world structure
│   ├── sectors/       # Large-scale galactic regions
│   ├── systems/       # Star systems and their contents
│   ├── stations/      # Space stations and installations
│   └── planets/       # Planetary surfaces and settlements
├── history/           # Timeline and historical events
│   ├── wars/          # Conflicts and their outcomes
│   ├── discoveries/   # Technological and scientific breakthroughs
│   └── treaties/      # Diplomatic agreements and accords
├── technology/        # Tech trees and capabilities
│   ├── ships/         # Vessel designs and specifications
│   ├── weapons/       # Combat systems and armaments
│   └── infrastructure/ # Communications, transportation, industry
├── economy/           # Trade and resource systems
│   ├── resources/     # Raw materials and commodities
│   ├── routes/        # Trade lanes and commercial networks
│   └── markets/       # Economic centers and exchanges
└── cultures/          # Species, languages, and customs
    ├── species/       # Alien races and human variants
    ├── languages/     # Communication systems and protocols
    └── customs/       # Social structures and traditions
```

### Lore Integration Principles
1. **Lore Drives Features**: Game mechanics should reflect world lore
2. **Consistent World Building**: All systems must align with established lore
3. **Emergent Gameplay**: Lore creates natural conflict and cooperation opportunities
4. **Technical Implementation**: Lore requirements influence database schema and game logic
5. **Player Agency**: Lore provides context for meaningful player choices

### Lore Documentation Standards
```markdown
# Example: Faction Integration
## Corporate Security Forces

### Lore Context
Mega-corporations maintain private security fleets to protect trade routes
and enforce corporate policy in lawless frontier systems.

### Technical Implementation
- **Database Schema**: faction_relationships table with trust/hostility ratings
- **Game Mechanics**: Corporate security NPCs with faction-based behavior
- **Player Interaction**: Reputation system affecting access to corporate services
- **Command Processing**: Special corporate communication protocols

### Engine Requirements
- Faction reputation tracking system
- Dynamic NPC behavior based on faction standings
- Corporate territory control mechanics
- Economic sanctions and trade restrictions
```

## HTML Reporting Standards

### Default Report Format
All automated reports, documentation, and metrics should default to HTML format:

1. **Performance Reports**: Interactive HTML dashboards with charts and graphs
2. **Test Coverage**: HTML reports with file-by-file coverage analysis
3. **KPI Dashboards**: Real-time HTML status pages with refresh capabilities
4. **Documentation**: Generate HTML versions of all markdown documentation
5. **Error Reports**: HTML-formatted error summaries with stack traces and context

### HTML Report Features
- **Professional Styling**: Clean, readable layouts suitable for stakeholder review
- **Interactive Elements**: Collapsible sections, sortable tables, filterable data
- **Visual Charts**: Performance graphs, trend analysis, metric visualizations
- **Executive Summaries**: High-level overviews with key findings and recommendations
- **Technical Details**: Comprehensive data for developers and administrators

## Idgarad Conceptual Model (ICM) - Feature Design Framework

### Three-Tier Content Philosophy
Every gameplay feature must be analyzed across three interaction tiers:

**Tier 1 - Individual/Solo Content**
- Single-player experience and personal progression
- What can one player accomplish alone?
- Personal skill development and mastery
- Individual resource gathering and crafting

**Tier 2 - Group Content**  
- Small group cooperation (2-10 players)
- Shared objectives requiring coordination
- Enhanced capabilities through teamwork
- Group-specific mechanics and rewards

**Tier 3 - Faction/Alliance Content**
- Large-scale organizational activities
- Political and economic influence
- Territory control and resource management
- Inter-faction conflict and cooperation

### ICM Feature Analysis Template
When implementing any gameplay feature, document all applicable tiers:

```markdown
# Feature: [Feature Name]

## Justification
**Why Added**: [Clear explanation of why this feature enhances the virtual reality]

## Tier Analysis

### Tier 1 - Individual Content
- **Core Mechanics**: [How individuals interact with this feature]
- **Progression**: [Personal advancement opportunities]
- **Resources**: [Individual resource requirements and rewards]

### Tier 2 - Group Content  
- **Cooperative Elements**: [How groups enhance the experience]
- **Coordination Requirements**: [What teamwork enables]
- **Shared Benefits**: [Group-specific advantages]

### Tier 3 - Faction/Alliance Content
- **Organizational Impact**: [Large-scale implications]
- **Political Elements**: [How this affects faction relationships]
- **Economic Influence**: [Market and resource control aspects]

## Implementation Notes
- **Database Schema**: [Required data structures]
- **Game Logic**: [Core processing requirements]  
- **User Interface**: [Player interaction methods]
- **Lore Integration**: [How this fits the game world]
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

Remember: This project should serve as the definitive tutorial for building MUD engines in Go. Every decision should prioritize clarity, educational value, and comprehensive documentation over clever optimizations. The ICM ensures that every feature contributes meaningfully to the virtual reality hobby experience across all scales of player interaction.