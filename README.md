# The Leviathan Engine

[![GitLab CI](https://gitlab.local/idgarad/leviathan-engine/badges/main/pipeline.svg)](https://gitlab.local/idgarad/leviathan-engine/-/pipelines)
[![Go Version](https://img.shields.io/badge/go-1.25.3%2B-blue.svg)](https://golang.org)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

A scalable, text-based MUD/MMO engine written in Go, designed as both a functional game engine and comprehensive educational reference for game development.

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
go mod tidy
go build -o leviathan-engine cmd/server/main.go
./leviathan-engine
```

## 📚 Documentation

- **[Architecture Overview](docs/ARCHITECTURE.md)** - System design and data flow
- **[API Reference](docs/API.md)** - Protocol specification and examples
- **[Development Setup](docs/DEVELOPMENT.md)** - Local environment configuration
- **[Tutorial Series](docs/TUTORIALS.md)** - Step-by-step implementation guides
- **[Performance Guide](docs/PERFORMANCE.md)** - Optimization and benchmarking

## 🛠️ Technology Stack

- **Language**: Go 1.25.3+
- **Database**: SQLite (dev) / PostgreSQL (production)
- **Protocol**: JSON-lines over TCP
- **Monitoring**: Prometheus + Grafana
- **Infrastructure**: Proxmox cluster with Terraform/Ansible

## 🎮 Game Design Principles

### Idgarad Conceptual Model (ICM)
The engine implements a three-tier interaction framework:

1. **Tier 1 - Individual**: Personal progression and skill development
2. **Tier 2 - Group**: Small team cooperation and shared objectives  
3. **Tier 3 - Faction**: Large-scale political and economic systems

### Dynamic Content Scaling
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