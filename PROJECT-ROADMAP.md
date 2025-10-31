

# Project Roadmap

> **Language Notice:** As of October 2025, Rust is the unified backend language for all simulation, orchestration, and infrastructure code in The Leviathan Engine project. All future code examples and integrations will use Rust.

This roadmap outlines the major phases for building and evolving The Leviathan Engine. Each section includes objectives and key deliverables to guide development and infrastructure work.

## Infrastructure
- **Objective:** Establish foundational systems for code management, automation, and deployment.
- **Deliverables:**
	- Version control setup (GitLab/GitHub)
	- Containerization (Docker, Docker Compose)
	- Infrastructure as Code (Terraform)
	- Configuration management (Ansible)
	- Monitoring and observability (Prometheus, Grafana)
	- CI/CD pipeline automation

## Coding
- **Objective:** Develop core engine features and supporting modules in Go.
- **Deliverables:**
	- Engine architecture and main server implementation
	- Modular plugin system
	- Command processing and protocol handling
	- Database integration and persistence
	- Comprehensive documentation and code comments

## Performance Testing
- **Objective:** Validate system scalability, reliability, and responsiveness under load.
- **Deliverables:**
	- Load testing scripts (k6, custom Go tools)
	- Automated regression and KPI tests
	- Metrics collection and reporting
	- Performance dashboards

## Benchmarking
- **Objective:** Establish baseline metrics and compare infrastructure and engine performance across environments.
- **Deliverables:**
	- Benchmark scenarios for world generation, player simulation, and NPC activity
	- Data import/export performance tests
	- Comparative analysis of datastore backends
	- Reporting and recommendations

## Content Pass
- **Objective:** Populate the engine with game world content, lore, and player experiences.
- **Deliverables:**
	- Territory generation and world-building
	- Faction, NPC, and item creation
	- Tutorial and onboarding content
	- Documentation for content creation workflows

---
_This roadmap is a living document. Update as new phases and technologies are added._
