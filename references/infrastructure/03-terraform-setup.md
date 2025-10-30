# Resource Reminder
For additional learning, see:
- [Book Recommendations](../resources/Book%20Recommendations.md)
- [Video Recommendations](../resources/Video%20Recommendations.md)
- [Online Coursework](../resources/Online%20Coursework.md)

# Terraform Setup Guide

> **Update Notice:** Accurate as of October 2025. For latest info, see official Terraform documentation.
> 
> **For additional information, please see:**
> - Terraform Docs: https://www.terraform.io/docs
> - [Book] "Terraform: Up & Running" by Yevgeniy Brikman

---

## Phase 1: Install Terraform

- Download from https://www.terraform.io/downloads.html
- Verify installation:
  ```bash
  terraform -version
  ```

---

## Phase 2: Directory Structure

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

---

## Phase 3: Provider Configuration

- Example for Proxmox:
  ```hcl
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

---

## Phase 4: VM Resource Example

```hcl
resource "proxmox_vm_qemu" "leviathan_test" {
  count       = var.instance_count
  name        = "leviathan-${var.environment}-${count.index + 1}"
  target_node = var.proxmox_node
  clone       = var.template_name
  cores   = var.cpu_count
  memory  = var.memory_mb
  sockets = 1
  disk {
    size     = "${var.disk_size_gb}G"
    type     = "scsi"
    storage  = var.storage_pool
    iothread = 1
  }
  network {
    model  = "virtio"
    bridge = var.network_bridge
  }
  os_type   = "cloud-init"
  ipconfig0 = "ip=${var.base_ip_address}${count.index + 10}/24,gw=${var.gateway_ip}"
  sshkeys = var.ssh_public_key
  tags = "environment-${var.environment};project-leviathan;type-gameserver"
  lifecycle {
    ignore_changes = [ network, ]
  }
}
```

---

## Troubleshooting & Best Practices
- Use `terraform plan` before `apply` to preview changes.
- Store state files securely.
- Document all infrastructure changes.

---

> **Update Notice:** Instructions accurate as of October 2025. For latest info, see official docs.
> 
> **Further Reading:**
> - https://www.terraform.io/docs
> - "Terraform: Up & Running" by Yevgeniy Brikman
