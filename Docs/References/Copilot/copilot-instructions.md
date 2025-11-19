# Developer Journal Standard
Every project must include a `Developer Journal.md` for recording developer notes and journal entries.
- Journal entries should be dated (YYYY-MM-DD, no timestamp), and numbered sequentially for each day.
- All entries must be signed as "Idgarad Lyracant via VsCode and GitHub Copilot".
- When the user requests a journal entry, add it to the journal file following these rules.
### Special Query Prefix
If the user prefixes a question with '??', or if the query comes through voice chat, do not document the response in the wiki or project files—provide a direct answer only. Only generate documentation if the user explicitly requests it.
- Create a main index (Home) page for navigation.
- Organize content into dedicated pages (e.g., Design Philosophy, Territory Generation, Ships and FTL, Tips & Tricks).
- Use internal wiki links for cross-referencing.
- Update the changelog in the wiki (e.g., Changelog.md or a dedicated Changelog page).
- Archive or remove legacy markdown files from the repo once migrated.
+- Integrate visual diagrams (SVG or PNG) into documentation when appropriate. Always confirm with the user ("Should I prepare a diagram for ...?") before generating diagrams to avoid clutter.
# The Leviathan Engine - AI Coding Agent Instructions
# Writing Style Guidance (Idgarad)

## Personal Writing Style Notes
The developer (Idgarad) prefers a writing style that is:
- Conversational and reflective, often sharing personal experiences and context
- Detailed, with clear explanations and rationale for decisions
- Structured, using numbered lists, bullet points, and section headers for clarity
- Educational, aiming to teach and provide learning opportunities for readers
- Honest and direct, including both successes and challenges
- Signed journal entries and documentation for accountability
- Uses analogies and metaphors to clarify concepts (e.g., "MMOs are like a peach")
- Integrates practical advice and real-world context
- Favors clarity and readability over brevity or excessive technical jargon

## Copilot Documentation and Journal Entry Standards
- When generating documentation, journal entries, or comments, match the above style: be clear, conversational, and educational.
- Annotate entries with relevant files/changes when appropriate.
- Use numbered and bulleted lists to organize information.
- Include personal reflections and context when summarizing progress or decisions.
- Always sign journal entries as "Idgarad Lyracant via VsCode and GitHub Copilot" and date them (YYYY-MM-DD).
- Maintain a tone that is approachable and informative, suitable for both technical and non-technical readers.

## Example Journal Entry Style
2025-10-30 Entry 1
Today is going well as we make progress on infrastructure development. GitLab and Docker are already up and running, and we will be moving on to Terraform soon. I am continuing to develop documentation with the AI to ensure a sensible structure and flow for building out this project.

I have experimented with using Copilot's voice chat to reduce typing. It is mildly effective.

...existing content...

## Project Overview

The Leviathan Engine is a scalable, text-based MUD/MMO engine. This project builds upon lessons learned from the BlackCitadel project, focusing on incremental delivery of working software with comprehensive documentation for educational use.

**Key Philosophy**: This project serves as both a functional MUD engine and a comprehensive tutorial/teaching reference for game engine development. This is a series used to learn a new programming languages. Iterations of it have spanned from PASCAL to modern languages like Rust.

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

**Idgarad Conceptual Model (ICM)**: 
 - Treat MMOs as a hobby, not a game. Think of MMOs like a hobby like gardening.
 - MMOs are a tool to allow a player to interact with a virtual world

## Technology Stack & Architecture

### Proven Patterns from previous BlackCitadel project
- JSON-lines protocol for loose coupling between components
- Grid-based spatial partitioning for active game regions  
- SQLite with WAL mode for reliable persistence
- Modular plugin architecture for gameplay systems
- Comprehensive performance monitoring and regression testing

## Code Quality & Documentation Standards

### Comprehensive Self-Documentation
Regardless of language code should be not only self documenting for use with documentation tools but should include tutorial-like explanations and reasoning on why something is done a certain way.


### Documentation Directory Structure
Maintain this structure and update with every significant change (reasoning in parenthesis):
- Docs (Over all documentation Directory)
  CHANGELOG.MD (The running change log for all documents under the Docs folder)
  - Lore (Contains story specific information to guide features needed)
  - Codex (Bridge documents that link code development to lore. The core features that need to be supported)
  - References
	- Coding (Documentation relating to the implemented code)
	- ICM (Documentation about the Idgarad Conceptual Model)
	- Infrastructure (Documentation on the Infrastructure Needed)
	- Tips (General Development Tips)
	Book Recomandations.md (An aggregate list of suggested reading materials)
	Developer Journal.md (The developer's journal)
	Online Coursework.md (Suggestions for free online classes in relation to the project)
	Video Recommendations.md (Grouped by topic, suggested videos to watch)
	Academic.md (When justifying patterns and structures any academic papers should be cited here)


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

### Performance & Monitoring
The Leviathan Engine also doubles as a performance tool to test infrastructure. Detailed reporting and real time reporting should be included.

### Comprehensive Testing & KPI Framework
Build extensive automated testing inspired by test environment best practices. This should be flexable to do unit-test like compartmentalize testing.

### Error Handling Patterns
Use descriptive, actionable error messages

## Educational & Tutorial Focus

### Code as Teaching Material
Every implementation should serve as a learning example and suggested learning resouces. As entries are added inline they should also be in their respective Docs/Resources/ file (books, Video, online class, etc.)

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
Structure the development process in to small manageable chunks so people can follow along and learn the language as they go. Structuring sprint suggestions and coding roadmaps to build the system in a sequence that gives the necessary learning experience and deliver MVP milestones in line with that cadence. 

## Infrastructure Documentation

### SVG Diagram Generation
SVG is our default image format.

### Data Dictionary Maintenance
Keep `docs/DATA_DICTIONARY.md` current with every struct change:

```markdown
## Player Data Structure

## AI Assistant Guidelines


### Code Generation Preferences
1. **Favor simplicity** - Clean variable names and functions\methods.
2. **Include examples** - Every function should have usage examples in comments  
3. **Performance awareness** - Always consider concurrent access and latency. Include performance consideration in the inline comments.
4. **Educational value** - Code should teach programming and MUD\MMO development concepts simultaneously
5. **Comprehensive testing** - Generate tests that serve as additional documentation
6. **Metrics integration** - Every component should expose performance metrics (BTOP-style)
7. **Terminal-friendly interfaces** - Clean, efficient status displays like tmux
8. **KPI-driven development** - Include measurable success criteria for all features
9. **Tips & Tricks Documentation** - Whenever you have practical infrastructure, engine, or workflow advice (e.g., multi-node Docker setup, VM strategies, debugging tips), add a new markdown file to `references/tips_tricks/` with clear, actionable guidance. Keep this folder up to date as a living resource for the team.
10. **Take nothing for granted** - assume everything is brand new to the developer as if it was their first programming class.

### Automated Testing Requirements
Every feature must include:
1. **Unit Tests**: 90%+ code coverage with meaningful assertions
2. **Integration Tests**: End-to-end scenarios with real data flows
3. **Performance Tests**: Baseline measurements and regression detection
4. **Load Tests**: Concurrent user simulation with resource monitoring
5. **KPI Validation**: Automated verification of success metrics
6. **Regression Suites**: Automated baseline comparison and alerting

### Error Handling Standards
always include easy to parse error responses.

## Project-Specific Patterns

Command Processing Patterns
Communication Bus Patterns

## Lore-Driven Development


### Lore Integration Principles
1. **Lore Drives Features**: Game mechanics should reflect world lore
2. **Consistent World Building**: All systems must align with established lore
3. **Emergent Gameplay**: Lore creates natural conflict and cooperation opportunities
4. **Technical Implementation**: Lore requirements influence database schema and game logic
5. **Player Agency**: Lore provides context for meaningful player choices

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



Remember: This project should serve as the definitive tutorial for building MUD engines in Go. Every decision should prioritize clarity, educational value, and comprehensive documentation over clever optimizations. The ICM ensures that every feature contributes meaningfully to the virtual reality hobby experience across all scales of player interaction.