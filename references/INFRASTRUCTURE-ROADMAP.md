# The Leviathan Engine - Pre-Development Infrastructure Roadmap

## Overview

This roadmap establishes the foundational infrastructure needed before beginning development, prioritized for an experienced developer transitioning to modern practices with focus on scalability testing and automation.

## Phase 1: Core Development Infrastructure (Week 1-2)

### Priority 1A: Version Control & CI/CD Foundation
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
# Create Ubuntu 22.04 LTS template for Proxmox
# 1. Download Ubuntu cloud image
wget https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img

# 2. Create VM template in Proxmox
qm create 9000 --memory 2048 --cores 2 --net0 virtio,bridge=vmbr0
qm importdisk 9000 jammy-server-cloudimg-amd64.img local-lvm
qm set 9000 --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-9000-disk-0
qm set 9000 --ide2 local-lvm:cloudinit
qm set 9000 --boot c --bootdisk scsi0
qm set 9000 --serial0 socket --vga serial0
qm template 9000

# 3. Clone template for GitLab
qm clone 9000 100 --name gitlab-server
qm set 100 --memory 8192 --cores 4
qm resize 100 scsi0 +48G
```

**Essential GitLab Configuration:**
- [ ] SSL certificates (Let's Encrypt or self-signed)
- [ ] Automated backups configured
- [ ] Runner registration for CI/CD
- [ ] Container registry enabled
- [ ] Package registry enabled (for Go modules)

**Initial Repository Structure:**
```
leviathan-engine/
├── .gitlab-ci.yml              # CI/CD pipeline
├── docker-compose.yml          # Local development stack
├── infrastructure/             # Infrastructure as Code
│   ├── terraform/             # Infrastructure provisioning
│   ├── ansible/               # Configuration management
│   └── kubernetes/            # Container orchestration (future)
├── scripts/                   # Development automation
├── docs/                      # Documentation
└── [Go project structure]     # Actual engine code
```

### Priority 1B: Local Development Environment
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

## Phase 2: Infrastructure as Code (Week 2-3)

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
  clone       = var.template_name  # Ubuntu 22.04 LTS template
  
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
  default     = "ubuntu-2204-cloudinit"
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