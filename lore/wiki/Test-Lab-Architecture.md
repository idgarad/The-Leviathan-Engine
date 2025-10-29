# Example Test Lab / Home Lab Architecture

> **Update Notice:** Accurate as of October 29, 2025. This page documents a reference test lab/home lab setup for Leviathan Engine development and prototyping.

## Overview

## Topology

## VMs
- **elz01:** Handles HAProxy and Nginx forwarding (reverse proxy, SSH/HTTPS routing)
- **gitlab01:** Hosts the GitLab instance for code and CI/CD

## Proxmox Cluster
- 2 nodes (PVE1, PVE2)
- ZFS pool for VM storage; NFS, iSCSI, and SMB shares hosted on PVE1

## Networks
- **Green Network (192.168.1.0/24):** Standard home lab, internet access
- **Blue Network (192.168.2.0/24):** Dedicated inter-VM communication
- **Red Network (10.0.0.0/24):** 10GbE dedicated storage network (currently idle, pending switch)
- Each network corresponds to a physical NIC on the Proxmox nodes and can be assigned to VMs as needed


## Components
- Proxmox cluster (VM host)
- VMs for:
  - Docker nodes (multi-node setup)
  - ELZ reverse proxy server
  - GitLab CE / GitHub integration
  - DNS/DHCP (DD-WRT, DNSMasq, SmartDNS)
  - Monitoring (Prometheus, Grafana)
  - Database (PostgreSQL, SQLite)
- Networking:
  - VLANs or segmented networks for isolation
  - Static and DHCP IP assignment
  - Port forwarding and reverse proxy rules
- Security:
  - Firewall rules
  - SSH key management
  - Ransomware/backup strategies

## Example Diagram
_(Insert infrastructure diagram here: VMs, network layout, proxy, monitoring, etc.)_

## Usage
- Prototype engine deployments
- Automated testing and CI/CD
- Performance benchmarking
- Documentation and onboarding reference

---
Should I prepare a diagram for this test lab architecture? If so, specify any additional components to include.