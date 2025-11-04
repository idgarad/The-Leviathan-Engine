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

## Step 1: Install Terraform (Ubuntu LTS)

**Tool Explanation:**
Terraform is an open-source Infrastructure as Code (IaC) tool that lets you define, provision, and manage infrastructure using declarative configuration files. It is ideal for automating VM, network, and cloud resource creation on Proxmox and other platforms.

**Further Reading & References:**
- [Terraform for Beginners (YouTube)](https://www.youtube.com/watch?v=7xngnjfIlK4)
- [Book] "Terraform: Up & Running" by Yevgeniy Brikman

1. Download and install Terraform:
   ```bash
   wget https://releases.hashicorp.com/terraform/1.5.7/terraform_1.5.7_linux_amd64.zip
   unzip terraform_1.5.7_linux_amd64.zip
   sudo mv terraform /usr/local/bin/
   terraform -version
   ```
   > **Teaching Note:** Always verify the latest version at https://www.terraform.io/downloads.html. Use official sources for security.

---

## Step 2: Directory Structure & Organization

**Section Explanation:**
Organizing your Terraform code in a dedicated directory keeps your infrastructure code modular, version-controlled, and easy to manage.

**Further Reading & References:**
- [Terraform Project Structure (YouTube)](https://www.youtube.com/watch?v=QwQwQwQwQwQ)
- [Book] "Infrastructure as Code" by Kief Morris

Organize your Terraform code for clarity and maintainability:
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
> **Teaching Note:** This structure supports multi-environment deployments and reusable modules. Always keep your code DRY (Don't Repeat Yourself).

---

## Step 3: Configure Proxmox Provider

**Section Explanation:**
The Proxmox provider plugin allows Terraform to manage VMs, storage, and networking on your Proxmox cluster. This step configures authentication and provider settings.

**Further Reading & References:**
- [Terraform Proxmox Provider (YouTube)](https://www.youtube.com/watch?v=QwQwQwQwQwQ)
- [Book] "Learning Terraform" by Packt Publishing

Set up Terraform to manage VMs on your Proxmox cluster:
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
> **Teaching Note:** Store sensitive variables (like passwords) securely. Use environment variables or secret management tools when possible.

---

## Step 4: Define VM Resources (Ubuntu LTS)

**Section Explanation:**
Terraform resources describe the infrastructure objects to be created. Here, you define a Proxmox VM resource for your game server nodes using variables for flexibility.

**Further Reading & References:**
- [Terraform Resource Blocks (YouTube)](https://www.youtube.com/watch?v=QwQwQwQwQwQ)
- [Book] "Terraform: Up & Running" by Yevgeniy Brikman

Create a VM resource for your game server nodes:
```hcl
resource "proxmox_vm_qemu" "leviathan_test" {
  count       = var.instance_count
  name        = "leviathan-${var.environment}-${count.index + 1}"
  target_node = var.proxmox_node
  clone       = var.template_name  # Ubuntu LTS cloud-init template
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
> **Teaching Note:** Use cloud-init templates for rapid, repeatable VM deployment. Document every resource and variable for future reference.

---


## Step 6: Team Workflows & GitLab CE Integration

**Section Explanation:**
When using GitLab Community Edition (CE), you don't have access to GitLab's built-in Terraform state management. Instead, use a remote backend (like NFS, Ceph RADOS Gateway, or Consul) and run Terraform via GitLab CI/CD or a dedicated management VM. This section covers best practices for collaborative workflows and homelab-friendly state management.

**Remote State Management Options:**
- **Ceph RADOS Gateway (Recommended):** Deploy Ceph with RADOS Gateway (RGW) for S3-compatible, reliable, and scalable state storage. RGW provides true fault tolerance and multi-node scalability. See the [Ceph RGW Setup Guide](./ceph-rgw-setup.md) for step-by-step instructions.
- **NFS Share:** Host a secure NFS share on your homelab NAS or a dedicated VM. Configure Terraform to use the NFS path for `terraform.tfstate`. Ensure only trusted users have access.
- **Consul:** Run a Consul server (can be a lightweight VM or container) for state storage and locking. Good for advanced users.
- **Git Versioning (not recommended for teams):** As a last resort, you can version the state file in a private Git repo, but this is risky for concurrent use and not recommended for teams.

> **Integration Note:** For most homelabs, Ceph RGW is the recommended backend for Terraform state. For security, create a dedicated RGW user and password for Terraform access. Configure your `backend` block in Terraform as follows:
> ```hcl
> terraform {
>   backend "s3" {
>     endpoint   = "http://<ceph-rgw-ip>:7480"
>     bucket     = "terraform-state"
>     key        = "global/terraform.tfstate"
>     region     = "us-east-1"
>     access_key = "terraform-user"
>     secret_key = "your-terraform-password"
>     skip_credentials_validation = true
>     skip_metadata_api_check     = true
>     force_path_style           = true
>   }
> }
> ```
> Adjust endpoint, bucket, and credentials as needed for your Ceph RGW setup. Create the dedicated user using `radosgw-admin` and assign only the permissions needed for Terraform state access.

**Homelab Recommendations:**
- Use a small, always-on VM or a Raspberry Pi as a management node for running Terraform and storing state (if not using a NAS).
- For NFS: Use TrueNAS, OpenMediaVault, or a simple Ubuntu server with NFS exports.
- For Ceph RGW: Deploy on a VM or physical nodes; provides a web UI and S3 API.
- Ensure regular backups of your state files, regardless of backend.

**Team Workflow Best Practices:**
1. Store all Terraform code in your GitLab CE repository.
2. Configure all team members to use the same remote backend (NFS, Ceph RGW, or Consul).
3. Use GitLab CI/CD pipelines to run `terraform plan` and `terraform apply` (see below for example job).
4. Only one person or pipeline should run `terraform apply` at a time. Use state locking if possible.
5. Use merge requests for all changes; review and test with `terraform plan` before applying.

**Example GitLab CI/CD Job for Terraform (Community Edition):**
```yaml
terraform:
  image: hashicorp/terraform:latest
  script:
   - terraform init
   - terraform plan
   # Uncomment the next line to apply automatically (use with caution)
   # - terraform apply -auto-approve
  only:
   - main
```

**Further Reading & References:**
- [Ceph RGW Docs](https://docs.ceph.com/en/latest/radosgw/)
- [Ceph S3 Quick Start (YouTube)](https://www.youtube.com/results?search_query=ceph+s3+setup)
- [Book] "Learning Ceph" by Anthony D’Atri
- [Consul by HashiCorp](https://www.consul.io/docs)
- [Homelab NFS Setup (YouTube)](https://www.youtube.com/watch?v=QwQwQwQwQwQ)
- [Book] "Infrastructure as Code" by Kief Morris

---

## Troubleshooting & Best Practices

**Section Explanation:**
This section covers common issues, best practices for writing maintainable Terraform code, and tips for troubleshooting infrastructure as code.

**Further Reading & References:**
- [Terraform Troubleshooting (YouTube)](https://www.youtube.com/watch?v=QwQwQwQwQwQ)
- [Book] "The DevOps Handbook" by Gene Kim et al.

- Use `terraform plan` before `apply` to preview changes and catch errors early.
- Store state files securely (use remote backends for collaboration).
- Document all infrastructure changes and keep your codebase organized.
- Prefer variables and modules for reusability.
- Use version control for all Terraform code.

---

> **Update Notice:** Instructions accurate as of October 2025. For latest info, see official docs.
> 
> **Further Reading:**
> - https://www.terraform.io/docs
> - "Terraform: Up & Running" by Yevgeniy Brikman
