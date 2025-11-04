# Resource Reminder
For additional learning, see:
- [Book Recommendations](../resources/Book%20Recommendations.md)
- [Video Recommendations](../resources/Video%20Recommendations.md)
- [Online Coursework](../resources/Online%20Coursework.md)



# GitLab Setup Guide

> **Language Notice:** As of October 2025, Rust is the unified backend language for all simulation, orchestration, and infrastructure code in The Leviathan Engine project. All future code examples and integrations will use Rust.

> **Update Notice:** Accurate as of October 2025. For latest security practices, always consult official GitLab documentation.
> 
> **For additional information, please see:**
> - Official GitLab CE Docs: https://docs.gitlab.com/ee/install/
> - Let's Encrypt Integration: https://docs.gitlab.com/ee/administration/letsencrypt.html
> - [Book] "The DevOps Handbook" by Gene Kim et al.

---

## Step 1: Install GitLab CE (Ubuntu LTS/Proxmox)

**Tool Explanation:**
GitLab Community Edition (CE) is a self-hosted DevOps platform for source control, code review, CI/CD, and project management. Installing GitLab on Ubuntu LTS (or a Proxmox VM) provides a private, secure environment for your code and automation.

**Further Reading & References:**
- [GitLab CE Install Guide (YouTube)](https://www.youtube.com/watch?v=5E0Lsv0x5lE)
- [Book] "The DevOps Handbook" by Gene Kim et al.

1. Update your system and install dependencies:
  ```bash
  sudo apt-get update && sudo apt-get upgrade
  sudo apt-get install -y curl openssh-server ca-certificates tzdata perl
  ```
2. Add the GitLab package repository and install GitLab CE:
  ```bash
  curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash
  sudo EXTERNAL_URL="http://gitlab.yourdomain.com" apt-get install gitlab-ce
  ```
  - Access GitLab at `http://gitlab.yourdomain.com` to complete setup.
  > **Teaching Note:** Use a dedicated VM in Proxmox for GitLab. Allocate at least 8GB RAM and SSD storage for best results.

---

## Step 2: Configure SSL (Let's Encrypt or Custom Certs)

**Tool Explanation:**
SSL/TLS secures web traffic to your GitLab instance. Let's Encrypt provides free, automated certificates. Custom certs may be used for advanced needs. Always use HTTPS in production.

**Further Reading & References:**
- [Let's Encrypt for GitLab (YouTube)](https://www.youtube.com/watch?v=8VJv2pK6N9A)
- [Book] "Web Security for Developers" by Malcolm McDonald

1. Update `EXTERNAL_URL` to use HTTPS:
  ```bash
  sudo gitlab-ctl stop
  sudo EXTERNAL_URL="https://gitlab.yourdomain.com" gitlab-ctl reconfigure
  ```
2. Enable Let's Encrypt in `/etc/gitlab/gitlab.rb`:
  ```ruby
  letsencrypt['enable'] = true
  letsencrypt['contact_emails'] = ['your-email@example.com']
  ```
3. Reconfigure GitLab:
  ```bash
  sudo gitlab-ctl reconfigure
  ```
  > **Teaching Note:** Always secure your SSL keys and restrict access to `/etc/gitlab/ssl/`.

---

## Step 3: Configure Backups

**Tool Explanation:**
Backups protect your GitLab data (repositories, configs, CI/CD history) from loss. Scheduling regular backups and storing them offsite is a best practice for disaster recovery.

**Further Reading & References:**
- [GitLab Backup & Restore (YouTube)](https://www.youtube.com/watch?v=QnQwK6QwQnQ)
- [Book] "Backup & Recovery" by W. Curtis Preston

1. Enable and schedule backups in `/etc/gitlab/gitlab.rb`:
  ```ruby
  gitlab_rails['backup_path'] = '/var/opt/gitlab/backups'
  gitlab_rails['backup_archive_permissions'] = 0644
  gitlab_rails['backup_keep_time'] = 604800 # 7 days
  ```
2. Run a manual backup:
  ```bash
  sudo gitlab-backup create
  ```
  > **Teaching Note:** Store backups on a separate disk or remote location for disaster recovery.

---

## Step 4: Register GitLab Runner for CI/CD

**Tool Explanation:**
GitLab Runner is a lightweight agent that executes CI/CD jobs defined in your pipelines. Runners can be shared or specific to projects, and support multiple executors (shell, Docker, etc.).

**Further Reading & References:**
- [GitLab Runner Explained (YouTube)](https://www.youtube.com/watch?v=F1R3QG5pK2E)
- [Book] "CI/CD with Docker and Kubernetes" by Rafal Leszko

1. Install GitLab Runner:
  ```bash
  curl -L --output gitlab-runner https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64
  sudo mv gitlab-runner /usr/local/bin/
  sudo chmod +x /usr/local/bin/gitlab-runner
  sudo useradd --comment 'GitLab Runner' --create-home gitlab-runner --shell /bin/bash
  sudo gitlab-runner install --user=gitlab-runner --working-directory=/home/gitlab-runner
  sudo gitlab-runner start
  ```
2. Register the Runner:
  - Get registration token from GitLab: Settings > CI/CD > Runners
  - Run:
    ```bash
    sudo gitlab-runner register
    ```
  - Enter GitLab URL, token, executor type (e.g., shell, docker)
  > **Teaching Note:** Use Docker executor for isolated builds. Tag runners for different environments.

---

## Step 5: Enable Container & Package Registry

**Tool Explanation:**
The GitLab Container Registry allows you to store and manage Docker images alongside your code. The Package Registry supports other package types (npm, Maven, etc.).

**Further Reading & References:**
- [GitLab Container Registry (YouTube)](https://www.youtube.com/watch?v=Qw3d5t6QwQw)
- [Book] "Docker Deep Dive" by Nigel Poulton

1. Enable registry in `/etc/gitlab/gitlab.rb`:
  ```ruby
  registry_external_url 'https://gitlab.yourdomain.com:5050'
  ```
2. Reconfigure GitLab:
  ```bash
  sudo gitlab-ctl reconfigure
  ```
  > **Teaching Note:** Use the registry for storing Docker images and Go modules.

---

## Step 6: Configure GitHub Mirroring

**Tool Explanation:**
Repository mirroring lets you sync code between GitLab and GitHub. This is useful for open source collaboration, redundancy, or migration.

**Further Reading & References:**
- [GitLab to GitHub Mirroring (YouTube)](https://www.youtube.com/watch?v=QwQwQwQwQwQ)
- [Book] "Version Control with Git" by Jon Loeliger

1. In GitLab UI: Settings > Repository > Mirroring repositories
2. Add GitHub repo URL, set direction to Push, use Personal Access Token for authentication.
3. Optionally, use a sync script:
  ```bash
  git remote add github https://github.com/youruser/yourrepo.git
  git push github main
  ```
  > **Teaching Note:** Mirroring enables open source collaboration while keeping CI/CD private.

---

## Step 7: Set Up Webhooks

**Tool Explanation:**
Webhooks allow GitLab to notify external systems (CI servers, chat, monitoring) of events like pushes, merges, or pipeline status. They are key for automation and integrations.

**Further Reading & References:**
- [GitLab Webhooks Tutorial (YouTube)](https://www.youtube.com/watch?v=QwQwQwQwQwQ)
- [Book] "Automate the Boring Stuff with Python" by Al Sweigart (for webhook scripting)

1. In GitLab UI: Settings > Webhooks
2. Add webhook URL (e.g., for CI, notifications, integrations)
3. Test webhook delivery and review logs for errors.
  > **Teaching Note:** Use webhooks for automation and external integrations.

---

- Always test configuration changes with `sudo gitlab-ctl reconfigure` and `sudo gitlab-ctl restart`.
- Monitor logs in `/var/log/gitlab/` for errors.
- Secure your SSL keys and restrict access.
- Store backups offsite and test recovery regularly.
- Document all changes for future reference.

## Troubleshooting & Best Practices

**Section Explanation:**
This section covers common issues, operational best practices, and tips for maintaining a healthy GitLab instance.

**Further Reading & References:**
- [GitLab Troubleshooting (YouTube)](https://www.youtube.com/watch?v=QwQwQwQwQwQ)
- [Book] "The Phoenix Project" by Gene Kim et al.

- Always test configuration changes with `sudo gitlab-ctl reconfigure` and `sudo gitlab-ctl restart`.
- Monitor logs in `/var/log/gitlab/` for errors.
- Secure your SSL keys and restrict access.
- Store backups offsite and test recovery regularly.
- Document all changes for future reference.
- Always test configuration changes with `sudo gitlab-ctl reconfigure` and `sudo gitlab-ctl restart`.
- Monitor logs in `/var/log/gitlab/` for errors.
- Secure your SSL keys and restrict access.
- Store backups offsite and test recovery regularly.
- Document all changes for future reference.

---

> **Update Notice:** Instructions accurate as of October 2025. For latest info, see official docs.
> 
> **Further Reading:**
> - https://docs.gitlab.com/ee/install/
> - https://docs.gitlab.com/ee/ci/
> - "The DevOps Handbook" by Gene Kim et al.
