# The Leviathan Engine - Pre-Development Infrastructure Roadmap

> **NOTICE:** All instructions in this roadmap were accurate at the time of publishing (October 2025). Software versions and best practices may change. Always consult the official documentation for the latest updates.
> 
> **For additional information, please see:**
> - Official Proxmox Docs: https://pve.proxmox.com/wiki/Main_Page
> - [Book] "Infrastructure as Code" by Kief Morris

## Overview

This roadmap establishes the foundational infrastructure needed before beginning development, prioritized for an experienced developer transitioning to modern practices with focus on scalability testing and automation.

## Phase 1: Core Development Infrastructure (Week 1-2)

### Prerequisite: Install Essential Development Tools
Before proceeding to Priority 1A and 1B, ensure the following tools are installed on all development and infrastructure hosts:

- **Docker**: https://docs.docker.com/get-docker/
  - Install Docker Engine for your OS (Linux, Windows, Mac)
  - Add your user to the `docker` group (Linux)
- **Docker Compose**: https://docs.docker.com/compose/
  - Included with most Docker installations; verify with `docker compose version`
- **Git**: https://git-scm.com/book/en/v2/Getting-Started-Installing-Git
  - Required for repository management and CI/CD
- **SSH**: https://www.openssh.com/
  - For secure remote access and key management
- **Postfix & mailutils** (for GitLab notifications):
  - Install via your OS package manager

> **For additional information, please see:**
> - Docker Docs: https://docs.docker.com/get-docker/
> - Docker Compose: https://docs.docker.com/compose/
> - Git: https://git-scm.com/book/en/v2/Getting-Started-Installing-Git
> - SSH: https://www.openssh.com/

### Priority 1A: Dual Repository Strategy - GitLab + GitHub
### GitLab Community Edition (CE) Installation Notes

After you have added the GitLab CE package repository and completed the Postfix SMTP relay setup, follow these steps to install GitLab CE and configure SSL:

1. **Install GitLab CE**
   ```bash
   # Replace EXTERNAL_URL with your domain or IP
   sudo EXTERNAL_URL="http://gitlab.yourdomain.com" apt-get install gitlab-ce
   ```
   - The installer will configure GitLab and start its web service.
   - Access GitLab via your browser at `http://gitlab.yourdomain.com` to complete initial setup.

2. **Configure Let's Encrypt SSL (after GitLab install)**
   - Update your `EXTERNAL_URL` to use HTTPS:
     ```bash
     sudo gitlab-ctl reconfigure
     sudo gitlab-ctl stop
     sudo EXTERNAL_URL="https://gitlab.yourdomain.com" gitlab-ctl reconfigure
     ```
   - Enable Let's Encrypt in `/etc/gitlab/gitlab.rb`:
     ```ruby
     letsencrypt['enable'] = true
     letsencrypt['contact_emails'] = ['your-email@example.com']
     ```
   - Run:
     ```bash
     sudo gitlab-ctl reconfigure
     ```
   - For advanced SSL setups, see the official documentation below.

> **For additional information, please see:**
> - Official GitLab CE Docs: https://docs.gitlab.com/ee/install/
> - Let's Encrypt Integration: https://docs.gitlab.com/ee/administration/letsencrypt.html
> - Postfix Setup: https://wiki.debian.org/Postfix
> - [Book] "The DevOps Handbook" by Gene Kim et al. (for CI/CD and infrastructure best practices)
> - [Book] "Site Reliability Engineering" by Betsy Beyer et al. (for monitoring and reliability)

**Repository Architecture:**
- **GitLab (Local)**: Primary development, CI/CD, private operations
- **GitHub (Public)**: Code visibility, community contributions, documentation

**GitLab Self-Hosted Setup on Proxmox**
```bash
# Proxmox VM specifications for GitLab
# - 8GB RAM, 4 CPU cores, 50GB storage (recommended)
# - 16GB RAM, 8 CPU cores, 100GB storage (optimal)

# Deployment options on Proxmox:
1. GitLab VM from template with Omnibus package (recommended)
2. GitLab containerized deployment on Proxmox LXC
3. GitLab VM with Docker Compose setup
```

**Proxmox Template Preparation:**
```bash
# Create Ubuntu 24.04 LTS template for Proxmox
# 1. Download Ubuntu cloud image
wget https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img

# 2. Create VM template in Proxmox
qm create 9000 --memory 2048 --cores 2 --net0 virtio,bridge=vmbr0
qm importdisk 9000 noble-server-cloudimg-amd64.img local-lvm
qm set 9000 --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-9000-disk-0
qm set 9000 --ide2 local-lvm:cloudinit
qm set 9000 --boot c --bootdisk scsi0
qm set 9000 --vga std
qm template 9000
```

**SSH Key Setup for Cloud-Init Access:**
```bash
# 1. Generate SSH key pair (if you don't have one)
# On Windows (PowerShell):
ssh-keygen -t ed25519 -C "your-email@example.com"
# On Linux/macOS:
ssh-keygen -t ed25519 -C "your-email@example.com"

# 2. Display public key for copying
# Windows:
Get-Content ~\.ssh\id_ed25519.pub
# Linux/macOS:
cat ~/.ssh/id_ed25519.pub

# Example output (copy this entire line):
# ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGq... your-email@example.com
```

**Cloud-Init Configuration Setup:**
```bash
# 3. Clone template for GitLab with cloud-init configuration
qm clone 9000 500 --name vmgitlab01
qm set 500 --memory 8192 --cores 4
qm resize 500 scsi0 +48G

# 4. Configure cloud-init settings
# Set SSH public key (replace with your actual public key)
qm set 500 --sshkey ~/.ssh/id_ed25519.pub

# Set default user (Ubuntu cloud images use 'ubuntu' user by default)
qm set 500 --ciuser ubuntu

# Set password for emergency console access (optional but recommended)
qm set 500 --cipassword $(openssl passwd -6 'YourSecurePassword123!')

# Configure network (DHCP)
qm set 500 --ipconfig0 ip=dhcp

# Or configure static IP (example):
# qm set 500 --ipconfig0 ip=192.168.1.100/24,gw=192.168.1.1

# Set name servers (optional)
qm set 500 --nameserver 8.8.8.8

# Add custom cloud-init configuration (optional)
# This installs essential packages on first boot
qm set 500 --cicustom "user=local:snippets/gitlab-cloud-init.yml"

# 5. Start the VM
qm start 500

# 6. Find the VM's IP address (if using DHCP)
# Check Proxmox web interface or:
qm guest cmd 500 network-get-interfaces
```

**Custom Cloud-Init Script for GitLab (Optional):**
```yaml
# Create this file: /var/lib/vz/snippets/gitlab-cloud-init.yml on Proxmox host
#cloud-config
package_update: true
package_upgrade: true

packages:
  - curl
  - wget
  - ca-certificates
  - apt-transport-https
  - gnupg
  - lsb-release

# Prepare system for GitLab Community Edition installation
runcmd:
  # Add GitLab Community Edition (CE) package repository
  - curl -fsSL https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash
  # Update package list
  - apt-get update
  # Install dependencies for GitLab
  - apt-get install -y postfix mailutils
  # Configure Postfix for Gmail SMTP relay (manual step after install)
  # Edit /etc/postfix/main.cf and add:
  # relayhost = [smtp.gmail.com]:587
  # smtp_use_tls = yes
  # smtp_sasl_auth_enable = yes
  # smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd
  # smtp_sasl_security_options = noanonymous
  # smtp_sasl_tls_security_options = noanonymous
  # smtp_tls_CAfile = /etc/ssl/certs/ca-certificates.crt

  # Create /etc/postfix/sasl_passwd with:
  # [smtp.gmail.com]:587 USERNAME@gmail.com:PASSWORD

  # Then run:
  # postmap /etc/postfix/sasl_passwd
  # systemctl restart postfix
  # Send a test email to verify Postfix Gmail SMTP relay
  echo "Test email from Postfix setup on $(hostname)" | mail -s "Postfix SMTP Test" your-email@gmail.com
  # Check /var/log/mail.log for delivery status
  # If you see 'status=sent', your relay is working!

  # Note: For Gmail, you may need to create an App Password if 2FA is enabled.
  
# Configure automatic security updates
write_files:
  - path: /etc/apt/apt.conf.d/20auto-upgrades
    content: |
      APT::Periodic::Update-Package-Lists "1";
      APT::Periodic::Unattended-Upgrade "1";

# Set timezone
timezone: UTC

# Configure SSH for security
ssh_pwauth: false
disable_root: true

# Final message
final_message: "GitLab VM is ready for GitLab Community Edition installation. SSH access available for user 'ubuntu'."
```

**SSH Access Instructions:**
```bash
# Connect to your new GitLab VM
# Replace IP_ADDRESS with actual IP from Proxmox interface
ssh ubuntu@IP_ADDRESS

# If you set a static IP (example):
ssh ubuntu@192.168.1.100

# First login will show cloud-init completion status
# You should see: "Cloud-init finished successfully"
```

**Essential GitLab Configuration:**
- [ ] SSL certificates (Let's Encrypt or self-signed)
- [ ] Automated backups configured
- [ ] Runner registration for CI/CD
- [ ] Container registry enabled
- [ ] Package registry enabled (for Go modules)
- [ ] GitHub mirror synchronization configured
- [ ] Webhook setup for GitHub integration

**GitHub Repository Setup:**
- [ ] Public repository: `idgarad/The-Leviathan-Engine`
- [ ] Mirror push from GitLab (automated sync)
- [ ] GitHub Actions disabled (CI/CD handled by GitLab)
- [ ] Issue templates and community guidelines
- [ ] README with GitLab CI status badges

**Repository Structure (GitLab Primary, GitHub Mirror):**
```
leviathan-engine/
├── .gitlab-ci.yml              # GitLab CI/CD pipeline (not mirrored to GitHub)
├── .github/                    # GitHub-specific configurations
│   ├── ISSUE_TEMPLATE/         # Issue templates for community
│   ├── PULL_REQUEST_TEMPLATE.md # PR template
│   └── copilot-instructions.md # AI coding guidelines (public)
├── docker-compose.yml          # Local development stack
├── infrastructure/             # Infrastructure as Code
│   ├── terraform/             # Infrastructure provisioning
│   ├── ansible/               # Configuration management
│   └── kubernetes/            # Container orchestration (future)
├── scripts/                   # Development automation
│   └── sync-to-github.sh      # GitHub mirror sync script
├── docs/                      # Documentation (public on GitHub)
├── references/                # Development references (public)
│   ├── TERRITORY-GENERATION.md
│   ├── THE-NEW-PLAYER-EXPERIENCE.md
│   ├── PLAYER-TUTORIAL-EXPECTATIONS.md
│   ├── CODING-ROADMAP.md
│   ├── INFRASTRUCTURE-ROADMAP.md
│   └── [other reference docs]
└── [Go project structure]     # Actual engine code
```

### Priority 1B: Local Development Environment

> **NOTICE:** Container images and stack configuration may change. Always check the latest Docker and service documentation.
>
> **For additional information, please see:**
> - Docker Docs: https://docs.docker.com/
> - Compose Reference: https://docs.docker.com/compose/
> - [Book] "Docker Deep Dive" by Nigel Poulton

**Docker Development Stack**
```yaml
# docker-compose.yml for local development
version: '3.8'
services:
  postgres:
    image: postgres:15
    environment:
      POSTGRES_DB: leviathan_dev
      POSTGRES_USER: dev
      POSTGRES_PASSWORD: dev
    volumes:
      - postgres_data:/var/lib/postgresql/data
    ports:
      - "5432:5432"
  
  redis:
    image: redis:7-alpine
    ports:
      - "6379:6379"
  
  prometheus:
    image: prom/prometheus
    ports:
      - "9090:9090"
    volumes:
      - ./monitoring/prometheus.yml:/etc/prometheus/prometheus.yml
  
  grafana:
    image: grafana/grafana
    ports:
      - "3000:3000"
    environment:
      - GF_SECURITY_ADMIN_PASSWORD=admin

volumes:
  postgres_data:
```

### Priority 1C: GitLab-GitHub Synchronization Setup

> **NOTICE:** GitHub and GitLab integration features may evolve. Confirm with current platform documentation.
>
> **For additional information, please see:**
> - GitLab Mirroring: https://docs.gitlab.com/ee/user/project/repository/mirror/
> - GitHub Docs: https://docs.github.com/en
> - [Book] "Version Control with Git" by Jon Loeliger

**Automated Mirror Configuration:**
```bash
# GitLab mirror setup script
#!/bin/bash
# File: scripts/setup-github-mirror.sh

# 1. Create GitHub repository (manual step via web interface)
# Repository: https://github.com/idgarad/The-Leviathan-Engine

# 2. Configure GitLab push mirror
# GitLab UI: Settings > Repository > Mirroring repositories
# Git repository URL: https://github.com/idgarad/The-Leviathan-Engine.git
# Mirror direction: Push
# Authentication method: Password (use GitHub Personal Access Token)

# 3. Automated sync script for selective mirroring
git remote add github https://github.com/idgarad/The-Leviathan-Engine.git
git push github main

# Exclude sensitive files from GitHub mirror
echo ".gitlab-ci.yml" >> .github-ignore
echo "infrastructure/terraform/secrets/" >> .github-ignore
```

**GitLab CI for GitHub Sync:**
```yaml
# Add to .gitlab-ci.yml
sync_to_github:
  stage: deploy
  script:
    - git remote add github https://$GITHUB_TOKEN@github.com/idgarad/The-Leviathan-Engine.git
    - git push github main --force
  only:
    - main
  when: manual
```

## Phase 2: Infrastructure as Code (Week 2-3)

> **NOTICE:** Terraform and Ansible modules may update frequently. Always review official provider and module docs.
>
> **For additional information, please see:**
> - Terraform Docs: https://www.terraform.io/docs
> - Ansible Docs: https://docs.ansible.com/
> - [Book] "Terraform: Up & Running" by Yevgeniy Brikman
> - [Book] "Ansible for DevOps" by Jeff Geerling

### Priority 2A: Terraform Setup
**Why Terraform First:**
- Declarative infrastructure provisioning
- State management for infrastructure changes
- Multi-provider support (VMware, VirtualBox, cloud providers)
- Version control for infrastructure

**Terraform Directory Structure:**
```
infrastructure/terraform/
├── environments/
│   ├── development/
│   ├── staging/
│   └── production/
├── modules/
│   ├── virtual-machine/
│   ├── database/
│   ├── load-balancer/
│   └── monitoring/
├── variables.tf
├── outputs.tf
└── versions.tf
```

**Proxmox VM Configuration for Testing:**
```hcl
# infrastructure/terraform/modules/proxmox-vm/main.tf
terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "2.9.14"
    }
  }
}

resource "proxmox_vm_qemu" "leviathan_test" {
  count       = var.instance_count
  name        = "leviathan-${var.environment}-${count.index + 1}"
  target_node = var.proxmox_node
  clone       = var.template_name  # Ubuntu 24.04 LTS template
  
  # VM Configuration
  cores   = var.cpu_count
  memory  = var.memory_mb
  sockets = 1
  
  # Disk configuration
  disk {
    size     = "${var.disk_size_gb}G"
    type     = "scsi"
    storage  = var.storage_pool
    iothread = 1
  }
  
  # Network configuration
  network {
    model  = "virtio"
    bridge = var.network_bridge
  }
  
  # Cloud-init configuration
  os_type   = "cloud-init"
  ipconfig0 = "ip=${var.base_ip_address}${count.index + 10}/24,gw=${var.gateway_ip}"
  
  # SSH configuration
  sshkeys = var.ssh_public_key
  
  # Tags for organization
  tags = "environment-${var.environment};project-leviathan;type-gameserver"
  
  # Lifecycle management
  lifecycle {
    ignore_changes = [
      network,
    ]
  }
}
```

**Proxmox Provider Configuration:**
```hcl
# infrastructure/terraform/providers.tf
terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "2.9.14"
    }
  }
}

provider "proxmox" {
  pm_api_url      = var.proxmox_api_url
  pm_user         = var.proxmox_user
  pm_password     = var.proxmox_password
  pm_tls_insecure = var.proxmox_tls_insecure
}
```

**Proxmox Variables:**
```hcl
# infrastructure/terraform/variables.tf
variable "proxmox_api_url" {
  description = "Proxmox API URL (e.g., https://proxmox.local:8006/api2/json)"
  type        = string
}

variable "proxmox_user" {
  description = "Proxmox username (e.g., terraform@pve)"
  type        = string
}

variable "proxmox_password" {
  description = "Proxmox password or API token"
  type        = string
  sensitive   = true
}

variable "proxmox_node" {
  description = "Proxmox node name"
  type        = string
  default     = "pve"
}

variable "template_name" {
  description = "VM template name for cloning"
  type        = string
  default     = "ubuntu-2404-cloudinit"
}

variable "storage_pool" {
  description = "Proxmox storage pool name"
  type        = string
  default     = "local-lvm"
}

variable "network_bridge" {
  description = "Proxmox network bridge"
  type        = string
  default     = "vmbr0"
}
```

### Priority 2B: Ansible Configuration Management
**Why Ansible After Terraform:**
- Terraform creates infrastructure, Ansible configures it
- Idempotent configuration management
- Excellent for Go application deployment
- Role-based organization

**Ansible Directory Structure:**
```
infrastructure/ansible/
├── inventories/
│   ├── development/
│   ├── staging/
│   └── production/
├── roles/
│   ├── common/                 # Basic system setup
│   ├── golang/                 # Go runtime installation
│   ├── postgresql/             # Database setup
│   ├── monitoring/             # Prometheus/Grafana
│   ├── leviathan-engine/       # Application deployment
│   └── load-testing/           # Artillery.js or k6 setup
├── playbooks/
│   ├── site.yml
│   ├── deploy-engine.yml
│   └── load-test.yml
└── group_vars/
    ├── all.yml
    └── [environment].yml
```

**Sample Ansible Role for Go Application:**
```yaml
# roles/leviathan-engine/tasks/main.yml
---
- name: Create application user
  user:
    name: leviathan
    system: yes
    home: /opt/leviathan
    shell: /bin/bash

- name: Install Go binary
  copy:
    src: "{{ leviathan_binary_path }}"
    dest: /opt/leviathan/leviathan-engine
    owner: leviathan
    group: leviathan
    mode: '0755'
  notify: restart leviathan-engine

- name: Create systemd service
  template:
    src: leviathan-engine.service.j2
    dest: /etc/systemd/system/leviathan-engine.service
  notify: 
    - reload systemd
    - restart leviathan-engine

- name: Start and enable service
  systemd:
    name: leviathan-engine
    enabled: yes
    state: started
```

## Phase 3: Monitoring & Testing Infrastructure (Week 3-4)

> **NOTICE:** Monitoring tools and load testing frameworks are updated regularly. Refer to official documentation for latest features.
>
> **For additional information, please see:**
> - Prometheus Docs: https://prometheus.io/docs/
> - Grafana Docs: https://grafana.com/docs/
> - k6 Docs: https://k6.io/docs/
> - [Book] "Site Reliability Engineering" by Betsy Beyer et al.

### Priority 3A: Monitoring Stack Setup
**Prometheus + Grafana Configuration**
```yaml
# monitoring/prometheus.yml
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: 'leviathan-engine'
    static_configs:
      - targets: ['localhost:8080']  # Your Go app metrics endpoint
    scrape_interval: 5s
    metrics_path: /metrics

  - job_name: 'postgresql'
    static_configs:
      - targets: ['postgres-exporter:9187']

  - job_name: 'system'
    static_configs:
      - targets: ['node-exporter:9100']
```

**Grafana Dashboard for MUD Engine:**
- Connection count over time
- Command processing latency (inspired by your BTOP philosophy)
- Memory usage per concurrent player
- Database query performance
- Grid instance health

### Priority 3B: Automated Testing Environment
**Load Testing with k6 (JavaScript, good Go integration)**
```javascript
// scripts/load-test.js
import http from 'k6/http';
import { check, sleep } from 'k6';
import { WebSocket } from 'k6/ws';

export let options = {
  stages: [
    { duration: '2m', target: 10 },   // Ramp up
    { duration: '5m', target: 100 },  // Stay at 100 users
    { duration: '2m', target: 0 },    // Ramp down
  ],
};

export default function() {
  // Test JSON-lines protocol
  const ws = new WebSocket('ws://localhost:8080/ws');
  
  ws.on('open', () => {
    ws.send(JSON.stringify({
      type: 'auth',
      username: `player${__VU}`,
      token: 'test-token'
    }));
  });

  ws.on('message', (data) => {
    check(data, {
      'auth successful': (msg) => JSON.parse(msg).type === 'auth-ok',
    });
  });

  sleep(1);
}
```

## Phase 4: CI/CD Pipeline (Week 4)

> **NOTICE:** CI/CD pipeline syntax and best practices may change. Always check the latest documentation for your CI platform.
>
> **For additional information, please see:**
> - GitLab CI/CD Docs: https://docs.gitlab.com/ee/ci/
> - [Book] "Continuous Delivery" by Jez Humble & David Farley

### GitLab CI/CD Pipeline
```yaml
# .gitlab-ci.yml
stages:
  - test
  - build
  - security
  - deploy-dev
  - load-test
  - deploy-staging

variables:
  GO_VERSION: "1.25"
  POSTGRES_DB: leviathan_test
  POSTGRES_USER: test
  POSTGRES_PASSWORD: test

# Go testing with coverage
test:
  stage: test
  image: golang:${GO_VERSION}
  services:
    - postgres:15
  script:
    - go mod download
    - go test -v -coverprofile=coverage.out ./...
    - go tool cover -html=coverage.out -o coverage.html
  artifacts:
    reports:
      coverage_report:
        coverage_format: cobertura
        path: coverage.xml
    paths:
      - coverage.html
  coverage: '/coverage: \d+.\d+% of statements/'

# Build binary
build:
  stage: build
  image: golang:${GO_VERSION}
  script:
    - CGO_ENABLED=0 GOOS=linux go build -o leviathan-engine ./cmd/server
  artifacts:
    paths:
      - leviathan-engine

# Security scanning
security_scan:
  stage: security
  image: securecodewarrior/docker-gosec
  script:
    - gosec ./...
  allow_failure: true

# Deploy to development
deploy_dev:
  stage: deploy-dev
  image: alpine:latest
  before_script:
    - apk add --no-cache ansible
  script:
    - cd infrastructure/ansible
    - ansible-playbook -i inventories/development playbooks/deploy-engine.yml
  environment:
    name: development
    url: http://dev.leviathan.local

# Automated load testing
load_test:
  stage: load-test
  image: loadimpact/k6:latest
  script:
    - k6 run --out json=load-test-results.json scripts/load-test.js
  artifacts:
    reports:
      performance: load-test-results.json
```

## Phase 5: Development Workflow Tools (Week 4-5)

> **NOTICE:** Development scripts and Makefile conventions may evolve. Review language and tool documentation for updates.
>
> **For additional information, please see:**
> - Bash Reference: https://www.gnu.org/software/bash/manual/
> - Makefile Docs: https://www.gnu.org/software/make/manual/
> - [Book] "The Pragmatic Programmer" by Andrew Hunt & David Thomas

### Development Scripts
```bash
#!/bin/bash
# scripts/dev-setup.sh - Development environment setup

set -e

echo "Setting up Leviathan Engine development environment..."

# Start local infrastructure
docker-compose up -d postgres redis prometheus grafana

# Wait for services
echo "Waiting for services to be ready..."
sleep 10

# Run database migrations
go run ./cmd/migrate up

# Install development tools
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
go install golang.org/x/tools/cmd/goimports@latest

# Generate documentation
go generate ./docs/...

echo "Development environment ready!"
echo "Grafana: http://localhost:3000 (admin/admin)"
echo "Prometheus: http://localhost:9090"
```

### Makefile for Common Tasks
```makefile
# Makefile
.PHONY: dev test build deploy clean

# Development
dev:
	./scripts/dev-setup.sh
	go run ./cmd/server

# Testing
test:
	go test -v -race -coverprofile=coverage.out ./...
	go tool cover -html=coverage.out -o coverage.html

# Performance testing
perf-test:
	k6 run scripts/load-test.js

# Infrastructure
infra-plan:
	cd infrastructure/terraform && terraform plan

infra-apply:
	cd infrastructure/terraform && terraform apply

# Deployment
deploy-dev:
	cd infrastructure/ansible && \
	ansible-playbook -i inventories/development playbooks/deploy-engine.yml

# Cleanup
clean:
	docker-compose down
	go clean -cache
```

## Implementation Timeline & Order

> **NOTICE:** Timelines are estimates and may vary based on project needs. Adjust as required for your environment.
>
> **For additional information, please see:**
> - Project Management Institute: https://www.pmi.org/
> - [Book] "Scrum: The Art of Doing Twice the Work in Half the Time" by Jeff Sutherland

### Week 1: Proxmox Foundation
1. **Day 1**: Create Ubuntu cloud-init template on Proxmox
2. **Day 2**: Deploy and configure GitLab VM from template  
3. **Day 3-4**: Set up Terraform with Proxmox provider
4. **Day 5**: Deploy monitoring stack VMs (Prometheus/Grafana)
5. **Day 6-7**: Initial project structure and basic CI pipeline

### Week 2: Proxmox Infrastructure as Code
1. **Day 1-2**: Terraform Proxmox provider configuration and testing
2. **Day 3-4**: Create reusable Terraform modules for game server VMs
3. **Day 5-7**: Ansible playbooks for Proxmox VM configuration and Go deployment

### Week 3: Monitoring & Testing Stack
1. **Day 1-2**: Deploy Prometheus on dedicated monitoring VM in cluster
2. **Day 3-4**: Grafana setup with terminal-inspired dashboards (BTOP-style)
3. **Day 5-6**: Proxmox cluster monitoring integration and node health tracking
4. **Day 7**: Load testing framework setup with k6 deployment

### Week 4: Integration & Automation
1. **Day 1-4**: Complete CI/CD pipeline implementation
2. **Day 5-7**: End-to-end testing and documentation

## Leveraging Your Proxmox Cluster

> **NOTICE:** Cluster features and optimizations may change with new Proxmox releases. Always consult the latest documentation.
>
> **For additional information, please see:**
> - Proxmox Cluster Docs: https://pve.proxmox.com/wiki/Cluster_Manager
> - [Book] "Designing Data-Intensive Applications" by Martin Kleppmann

**Proxmox Cluster Advantages:**
- **High Availability**: VM migration between nodes during maintenance
- **Resource Pooling**: Efficient CPU/RAM allocation across cluster
- **Snapshot Management**: Quick VM state saves for testing rollbacks
- **Template System**: Rapid VM deployment from golden images
- **Live Migration**: Zero-downtime VM moves between nodes
- **Backup Integration**: Automated VM backups with Proxmox Backup Server

**Recommended Proxmox VM Allocation:**

**Core Infrastructure VMs:**
- **GitLab Server**: 8GB RAM, 4 cores, 100GB storage (SSD preferred)
- **Monitoring Stack**: 4GB RAM, 2 cores, 50GB storage (Prometheus/Grafana)
- **Ansible Controller**: 2GB RAM, 2 cores, 20GB storage

**Game Server Test VMs (Scalable):**
- **Development**: 2GB RAM, 2 cores, 20GB storage
- **Load Test Targets**: 4GB RAM, 2 cores, 30GB storage (3-5 instances)
- **Production Simulation**: 8GB RAM, 4 cores, 50GB storage

**Proxmox-Specific Optimizations:**
```bash
# High-performance VM settings for game servers
# Add to Proxmox VM configuration
cpu: host
numa: 1
balloon: 0  # Disable memory ballooning for consistent performance
```

**Storage Recommendations:**
- **SSD/NVMe**: GitLab, databases, and development VMs
- **HDD**: Backup storage and archive data
- **ZFS**: For snapshots and data integrity
- **Ceph**: If multi-node storage clustering is available

## Tools & Software Versions

> **NOTICE:** Software versions listed are current as of October 2025. Always verify with official sources for updates.
>
> **For additional information, please see:**
> - Official Docs for each tool (see above)
> - [Book] "Infrastructure as Code" by Kief Morris

```bash
# Core tools
GitLab CE: Latest stable
Docker: 24+
Docker Compose: v2+
Terraform: 1.5+
Ansible: 6.0+
Go: 1.25+

# Monitoring
Prometheus: 2.40+
Grafana: 9.0+
k6: 0.45+

# Optional but recommended
Vault: For secrets management
Consul: For service discovery
Traefik: For reverse proxy/load balancing
```

This infrastructure will give you:
- **Scalable testing** via Terraform-provisioned VMs
- **Consistent deployments** via Ansible automation
- **Performance monitoring** aligned with your BTOP philosophy
- **Load testing** capabilities for concurrent player simulation
- **Modern CI/CD** practices with comprehensive testing

The order prioritizes getting a working development environment quickly, then building out the infrastructure automation that will support your scaling tests and production deployments.

---

## Setting Up Nginx SSL Proxy for GitLab (arcadis.hopto.org)

> **Update Notice:** Accurate as of October 2025. For latest security practices, always consult official Nginx and GitLab documentation.

### Step-by-Step Instructions

1. **Copy SSL Certificate and Key to elz01**
   - On your GitLab server, locate your SSL certificate and private key (commonly in `/etc/gitlab/ssl/`).
   - Securely copy both files to your Nginx server (`elz01`), e.g.:
     ```bash
     scp /etc/gitlab/ssl/arcadis.hopto.org.crt elz01:/etc/nginx/ssl/arcadis.hopto.org.crt
     scp /etc/gitlab/ssl/arcadis.hopto.org.key elz01:/etc/nginx/ssl/arcadis.hopto.org.key
     ```
   - Ensure permissions are secure (readable by Nginx, not world-readable).

2. **Configure Nginx for SSL Termination and Proxy**
   - On `elz01`, edit or create your Nginx site config (e.g., `/etc/nginx/sites-available/gitlab`):
     ```nginx
     server {
         listen 443 ssl;
         server_name arcadis.hopto.org;

         ssl_certificate     /etc/nginx/ssl/arcadis.hopto.org.crt;
         ssl_certificate_key /etc/nginx/ssl/arcadis.hopto.org.key;

         location / {
             proxy_pass         http://gitlab01:80;
             proxy_set_header   Host $host;
             proxy_set_header   X-Real-IP $remote_addr;
             proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
             proxy_set_header   X-Forwarded-Proto $scheme;
         }
     }
     ```
   - If your internal GitLab is running HTTPS, change `proxy_pass` to `https://gitlab01:443;` and add `proxy_ssl_verify off;` if using self-signed certs.

3. **Enable the Site and Reload Nginx**
   - Link your config:
     ```bash
     ln -s /etc/nginx/sites-available/gitlab /etc/nginx/sites-enabled/
     nginx -t  # Test config
     systemctl reload nginx
     ```

4. **Update DNS**
   - Ensure `arcadis.hopto.org` points to your `elz01` public IP.

5. **Test Access**
   - Visit `https://arcadis.hopto.org` in your browser. You should see your GitLab login page.
   - Check SSL certificate details to confirm correct domain.

> For additional information, see:
> - Nginx SSL Docs: https://nginx.org/en/docs/http/configuring_https_servers.html
> - GitLab Reverse Proxy: https://docs.gitlab.com/ee/administration/reverse_proxy.html
> - [Book] "NGINX Cookbook" by Tim Butler