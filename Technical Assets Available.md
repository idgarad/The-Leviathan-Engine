
# Technical Assets Available

> **Language Notice:** As of October 2025, Rust is the unified backend language for all simulation, orchestration, and infrastructure code in The Leviathan Engine project. All future code examples and integrations will use Rust.
> **Developer Note** Note this document is primarily a reference for AI assistants to know what tools we have to work with.

> **Update Notice:** Accurate as of October 2025. This document should be updated whenever new infrastructure, tools, or services are added to the project.

---

## Current Infrastructure & Tools


### Core Services
- **Rust**: Unified backend language for simulation, orchestration, and infrastructure code
- **Proxmox VE**: Virtualization platform for all VMs and containers
- **Ubuntu LTS**: Standard OS for all server VMs
- **GitLab CE**: Source control, CI/CD, and project management
- **Docker & Docker Compose**: Containerization and stack orchestration
- **MinIO (S3-compatible)**: Distributed object storage for state files, configs, backups, and more
- **Terraform**: Infrastructure as Code for VM, network, and service provisioning
- **Ansible**: Configuration management and automation
- **Prometheus**: Metrics collection and monitoring
- **Grafana**: Visualization and dashboarding
- **k6**: Load and performance testing

### Storage & State Management
- **MinIO**: S3-compatible object storage for:
  - Terraform state files
  - Configuration files (future use)
  - Backups and logs
- **NFS (optional)**: Network file storage for shared access

### CI/CD & Automation
- **GitLab CI/CD**: Automated pipelines for build, test, deploy, and infrastructure changes
- **Ansible Playbooks**: Automated server and service configuration
- **Terraform Plans/Applies**: Automated infrastructure provisioning

### Monitoring & Testing
- **Prometheus**: Real-time metrics collection
- **Grafana**: Custom dashboards for system health and KPIs
- **k6**: Automated load testing for services

---


## Usage Notes & Design Considerations
- All simulation, orchestration, and infrastructure code will be written in Rust for performance, safety, and maintainability.
- All config files, state files, and backups can be stored in MinIO for centralized, S3-compatible access.
- Infrastructure is modular and can be expanded as new tools/services are added.
- This document should be referenced and updated whenever new technical assets are introduced or existing ones are modified.

---

> **For additional information, see:**
> - [MinIO Setup Guide](references/infrastructure/02.1-minio-setup.md)
> - [Terraform Setup Guide](references/infrastructure/03-terraform-setup.md)
> - [GitLab CI/CD Pipeline Guide](references/infrastructure/06-cicd-pipeline.md)
> - [Ansible Setup Guide](references/infrastructure/04-ansible-setup.md)
> - [Monitoring & Testing Guide](references/infrastructure/05-monitoring-testing.md)
