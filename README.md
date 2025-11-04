# The Leviathan Engine

> **Language Notice:** As of October 2025, Rust is the unified backend language for all simulation, orchestration, and infrastructure code in The Leviathan Engine project. All future code examples and integrations will use Rust.

[![GitLab CI](https://gitlab.local/idgarad/leviathan-engine/badges/main/pipeline.svg)](https://gitlab.local/idgarad/leviathan-engine/-/pipelines)
[![Rust Version](https://img.shields.io/badge/rust-1.70%2B-orange.svg)](https://www.rust-lang.org)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

A scalable, text-based MUD/MMO engine written in Rust, designed as both a functional game engine and comprehensive educational reference for game development.

## 🏗️ Development Infrastructure

**Primary Development**: GitLab (Self-hosted)
- Full CI/CD pipeline and automation
- Private development workflows
- Infrastructure as Code management

**Public Repository**: GitHub (This repository)  
- Community access and code review
- Issue tracking and discussions
- Documentation and tutorials

## 🎯 Project Philosophy

The Leviathan Engine builds upon lessons learned from the BlackCitadel project, focusing on:

- **Educational Value**: Every implementation serves as a learning example
- **Terminal Excellence**: Inspired by BTOP, BPYTOP, and tmux for clean interfaces
- **Comprehensive Testing**: Extensive performance monitoring and regression testing
- **ICM Framework**: Three-tier content design (Individual/Group/Faction gameplay)

## 🚀 Quick Start

```bash
# Clone the repository
git clone https://github.com/idgarad/The-Leviathan-Engine.git
cd The-Leviathan-Engine

# Start local development environment
docker-compose up -d

# Build and run the engine
cargo build --release
./target/release/leviathan-engine
```

## Documentation

## 📖 Lore & Codex Reference

The Leviathan Engine features a comprehensive set of codex documents in the `lore/` directory, each serving as a canonical reference for a major gameplay, lore, or technical system. These codices are designed to:

- Provide authoritative lore and narrative context for all game systems
- Document technical models, mechanics, and progression frameworks
- Serve as educational resources for engine design and MMO development

### Codex Index (see `lore/README.md` for details)

- **Bridge Operations Codex**: Officer roles, department definitions, crew scaling, XO autonomy, technical models, and lore justification for distributed command
- **Certification Codex**: Skill suites, mastery, certifications, enhancement bonuses, meta-certification trees, XP curves, and fleet-wide performance mechanics
- **Combat Codex**: Tank layers, targeting, EW, officer buffs, skills/certs, rules of engagement, critical strikes, and performance engineering
- **Crafting & Manufacturing Codex**: Automated industry, ATEC system, player-driven manufacturing, tax layers, bootstrapping, and campaign persistence
- **FTL Codex**: Intrinsic Field mechanics, instant jumps, mathematical models, ship examples, coding references, and frame-of-reference clarification
- **Operator Codex**: Historical origins, campaign framework, power dynamics, seasonal gameplay, and narrative hooks
- **Psychology of Play & Safeguarding Codex**: MMO philosophy, NPC sovereignty, rules of engagement, ICM, and player well-being
- **Player Skills Codex**: Skill progression, post-mastery bonuses, suite certifications, and coding examples
- **Sovereignty & Territory Codex**: Imperial ownership, campaign structure, sector/territory mechanics, shares/dividends, persistence, and legacy metadata
- **NPC Interaction Codex**: (Placeholder for future NPC interaction systems and lore)

Refer to `lore/README.md` for a full index and navigation guide. Each codex is cross-referenced in documentation and gameplay systems, and is updated as new systems are added or refined.

All technical documentation, lore, tutorials, tips/tricks, and the changelog are maintained in the project wiki. Please refer to the wiki for up-to-date information, infrastructure diagrams, and cross-referenced resources.

## Key Features
- Scalable architecture for large-scale multiplayer
- Modular plugin system
- JSON-lines protocol for client communication
- SQLite/PostgreSQL persistence
- Real-time metrics and monitoring
- Comprehensive testing and KPI tracking
- Wiki-based documentation and visual diagrams

## Getting Started
See the wiki for setup instructions, infrastructure reference, onboarding guides, and example test lab/home lab architectures.

## Philosophy
- "There are no windows in space ships" — all player views are sensor/tactical driven
- Engine design prioritizes clarity, scalability, and educational value
- Documentation is maintained in the wiki for consistency and ease of navigation

## License
See LICENSE for details.
Content automatically adapts to participant numbers, maintaining challenge and providing appropriate rewards regardless of group size.

## 🔧 Development Workflow

1. **GitLab**: Primary development with full CI/CD pipeline
2. **GitHub**: Public mirror for community access (this repository)
3. **Proxmox**: Infrastructure testing and deployment automation
4. **Monitoring**: Real-time performance tracking and alerting

## 📈 Performance & Quality

- **Target**: <50ms response time for local commands
- **Scalability**: 1000+ concurrent players per server
- **Testing**: 90%+ code coverage with automated regression detection
- **Monitoring**: BTOP-inspired real-time metrics and dashboards

## 🤝 Contributing

While primary development occurs on our GitLab instance, we welcome community contributions:

1. **Issues**: Report bugs and suggest features here on GitHub
2. **Discussions**: Join conversations about game design and architecture
3. **Documentation**: Help improve tutorials and examples
4. **Code Review**: All code changes are visible here for community review

For development contributions, please see our [Contributing Guide](CONTRIBUTING.md).

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🏆 Project Status

**Current Phase**: Infrastructure Setup
- ✅ Project documentation and AI guidelines
- ✅ Infrastructure roadmap and automation planning  
- 🚧 GitLab deployment and CI/CD configuration
- ⏳ Core engine development (upcoming)

---

**Built with ❤️ for the MUD development community**