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
When using GitLab Community Edition (CE), you don't have access to GitLab's built-in Terraform state management. Instead, use a remote backend (like NFS, MinIO, or Consul) and run Terraform via GitLab CI/CD or a dedicated management VM. This section covers best practices for collaborative workflows and homelab-friendly state management.


**Remote State Management Options:**
- **MinIO (Recommended):** Deploy MinIO as described in [Step 02.1 - MinIO Setup Guide](./02.1-minio-setup.md). Use the `s3` backend in Terraform, pointing to your MinIO instance. This provides S3-compatible, reliable, and scalable state storage for homelab and team use.
- **NFS Share:** Host a secure NFS share on your homelab NAS or a dedicated VM. Configure Terraform to use the NFS path for `terraform.tfstate`. Ensure only trusted users have access.
- **Consul:** Run a Consul server (can be a lightweight VM or container) for state storage and locking. Good for advanced users.
- **Git Versioning (not recommended for teams):** As a last resort, you can version the state file in a private Git repo, but this is risky for concurrent use and not recommended for teams.

> **Integration Note:** For most homelabs, MinIO (see [Step 02.1 - MinIO Setup Guide](./02.1-minio-setup.md)) is the recommended backend for Terraform state. Configure your `backend` block in Terraform as follows:
> ```hcl
> terraform {
>   backend "s3" {
>     endpoint   = "http://<minio-ip>:9000"
>     bucket     = "terraform-state"
>     key        = "global/terraform.tfstate"
>     region     = "us-east-1"
>     access_key = "minioadmin"
>     secret_key = "yoursecurepassword"
>     skip_credentials_validation = true
>     skip_metadata_api_check     = true
>     force_path_style           = true
>   }
> }
> ```
> Adjust endpoint, bucket, and credentials as needed for your MinIO setup.

**Homelab Recommendations:**
- Use a small, always-on VM or a Raspberry Pi as a management node for running Terraform and storing state (if not using a NAS).
- For NFS: Use TrueNAS, OpenMediaVault, or a simple Ubuntu server with NFS exports.
- For MinIO: Deploy on a VM or Docker container; provides a web UI and S3 API.
- Ensure regular backups of your state files, regardless of backend.

**Team Workflow Best Practices:**
1. Store all Terraform code in your GitLab CE repository.
2. Configure all team members to use the same remote backend (NFS, MinIO, or Consul).
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
- [MinIO Docs](https://min.io/docs/minio/linux/index.html)
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
