# Black Citadel - Development Roadmap

*Extracted from BlackCitadel project documentation - October 2025*

## Current Development Status

Based on the BlackCitadel project status as of October 2025:

| Component    | Status      | Completion | Next Milestone                          |
|--------------|-------------|------------|----------------------------------------|
| GalaxyForge  | Stable      | 95%        | Integration into monorepo              |
| WorldEngine  | POC         | 25%        | Journaling, per-grid queues, dispatcher |
| BasicClient  | Planned     | 0%         | Initial implementation                 |
| AdminTools   | POC         | 30%        | Grid management, journal tools         |
| Modules      | Planned     | 10%        | Combat, physics, economy modules       |
| Shared       | Partial     | 60%        | Protocol complete, models TBD          |

## Short-Term Roadmap (Next 3-6 Months)

### Priority 1: Core Engine Foundation

**WorldEngine Completion**
- [ ] Implement journal persistence (BoltDB or flat-file segments)
- [ ] Add dispatcher logic for warp transitions  
- [ ] Per-grid command queues and snapshot coordination
- [ ] Agent registration and external client support
- [ ] Migrate from goWorldState POC to production implementation

**Shared Libraries Migration**
- [ ] Move `pkg/protocol` package from goWorldState to `shared/go/protocol/`
- [ ] Split protocol into separate packages for better organization
- [ ] Create language-specific bindings (Go, Rust, Python)
- [ ] Establish semantic versioning for shared components

### Priority 2: Basic Functionality

**AdminTools Enhancement**
- [ ] Migrate diagnostic client from goWorldState
- [ ] Implement grid management CLI (`gridmgr`)
- [ ] Build journal inspection tool
- [ ] Create metrics monitoring dashboard
- [ ] Add user management utilities

**BasicClient Implementation**
- [ ] Choose implementation language (Python recommended)
- [ ] Implement JSON-lines protocol client
- [ ] Build handshake and authentication
- [ ] Add subscription and command handling
- [ ] Create simple text-based UI

## Medium-Term Roadmap (6-12 Months)

### Priority 1: Module System

**Module Infrastructure**
- [ ] Implement Go plugin loading system
- [ ] Create module manifest validation
- [ ] Build module registry and dependency resolution
- [ ] Implement hot-swap functionality
- [ ] Add module sandboxing (WASM or gRPC isolation)

**Initial Modules**
- [ ] Basic combat engine (`combatEngine1`)
- [ ] Newtonian physics module
- [ ] Simple market economy module  
- [ ] Basic NPC AI behaviors
- [ ] Orbital mechanics simulation

### Priority 2: Scalability Infrastructure

**Performance & Monitoring**
- [ ] XML streaming parser for large galaxies (10k+ systems)
- [ ] Advanced metrics and monitoring (Prometheus, Grafana)
- [ ] Database performance optimization
- [ ] Memory usage optimization for long-running processes

**Grid System Enhancement**
- [ ] Grid instance distribution across machines
- [ ] Load balancing for multiple WorldEngine instances
- [ ] Network I/O optimization with per-session buffering
- [ ] Rate limiting by priority class

## Long-Term Roadmap (1-2 Years)

### Priority 1: Distributed Architecture

**Multi-Territory Support**
- [ ] Separate WorldEngine instances per territory
- [ ] PostgreSQL backend for multi-territory persistence  
- [ ] Cross-territory communication protocols
- [ ] Territory-based load balancing

**External Integration**
- [ ] REST API for external tool integration
- [ ] WebSocket transport option for browser clients
- [ ] Database backend abstraction (SQLite, PostgreSQL, others)
- [ ] Cloud deployment configurations (Docker, Kubernetes)

### Priority 2: Advanced Features

**Gameplay Systems**
- [ ] Multi-crew ship control with role-based permissions
- [ ] Advanced faction AI with strategic decision-making
- [ ] Complex trade routes and economic simulation
- [ ] Realistic orbital mechanics and time acceleration

**Development Tools**
- [ ] Module marketplace/registry for community content
- [ ] Replay and spectator modes
- [ ] Advanced debugging and profiling tools
- [ ] Automated testing frameworks

## Future Enhancements (2+ Years)

### Advanced Visualization
- [ ] 3D system representations
- [ ] Real-time galaxy map rendering
- [ ] Advanced SVG generation with interactive elements
- [ ] VR/AR client support exploration

### AI & Automation
- [ ] Advanced procedural content generation
- [ ] Dynamic faction relationship simulation
- [ ] Automated game master events
- [ ] Player behavior analytics and adaptation

### Platform Expansion  
- [ ] Mobile client implementations
- [ ] Web browser integration
- [ ] Multi-platform deployment automation
- [ ] Integration with existing game engines (Unity, Unreal)

## Technology Evolution Path

### Language Consolidation
- **Phase 1**: Maintain Rust + Go hybrid for proven components
- **Phase 2**: Evaluate single-language migration based on AI coding efficiency
- **Phase 3**: Consider Zig integration for performance-critical modules

### Database Strategy
- **Phase 1**: SQLite for single-territory development and testing
- **Phase 2**: PostgreSQL for multi-territory production deployments  
- **Phase 3**: Distributed database exploration (CockroachDB, etc.)

### Protocol Evolution
- **Phase 1**: JSON-lines over TCP (current)
- **Phase 2**: Binary protocol option for high-throughput scenarios
- **Phase 3**: gRPC integration for microservices architecture

## Risk Mitigation Strategies

### Technical Risks
- **Multi-Language Complexity**: Plan single-language migration path
- **Performance Bottlenecks**: Maintain automated performance testing
- **Scalability Limits**: Design with horizontal scaling from start
- **Integration Failures**: Prioritize working incremental implementations

### Resource Risks  
- **Scope Creep**: Maintain focus on core MUD functionality
- **Development Velocity**: Leverage AI coding assistance effectively
- **Technical Debt**: Regular refactoring and code quality reviews
- **Documentation Drift**: Keep docs synchronized with implementation

## Success Metrics & Milestones

### Technical Milestones
- [ ] **Milestone 1**: Complete WorldEngine with journaling (3 months)
- [ ] **Milestone 2**: Working BasicClient and AdminTools (6 months)
- [ ] **Milestone 3**: First functional module system (9 months)
- [ ] **Milestone 4**: Multi-territory support (18 months)

### Performance Targets
- [ ] Support 100+ concurrent players on single WorldEngine
- [ ] <100ms command response time for local commands
- [ ] 24/7 uptime with crash recovery capability
- [ ] Linear scaling to 10,000+ star systems

### Community Goals
- [ ] Open source core components
- [ ] Developer documentation and tutorials
- [ ] Community module development
- [ ] Integration examples and SDKs

## Dependencies & Prerequisites

### External Dependencies
- Go 1.25.3+ for core engine components
- Modern Linux servers for production deployment
- PostgreSQL for multi-territory persistence
- Monitoring infrastructure (Prometheus/Grafana)

### Internal Prerequisites  
- Complete GalaxyForge integration
- Protocol standardization across components
- Automated testing infrastructure
- Performance regression testing

## Lessons Applied from BlackCitadel

### Development Approach Changes
1. **Implement First, Document Later**: Avoid extensive upfront documentation
2. **Single Language Priority**: Focus on Go for initial implementation  
3. **Incremental Delivery**: Working components before integration layers
4. **Performance Integration**: Build performance testing into development workflow

### Architecture Simplifications
1. **Start with SQLite**: Proven adequate for initial development
2. **JSON-Lines Protocol**: Simple and effective for MUD commands
3. **Modular Design**: But implement core functionality first
4. **AI-Friendly Patterns**: Leverage lessons from BlackCitadel AI directives

---

*This roadmap incorporates lessons learned from BlackCitadel to guide The Leviathan Engine development with a focus on incremental delivery and working software over comprehensive architecture.*