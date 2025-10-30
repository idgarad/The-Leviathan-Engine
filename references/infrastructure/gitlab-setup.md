# GitLab Setup Guide

> **Update Notice:** Accurate as of October 2025. For latest security practices, always consult official GitLab documentation.
> 
> **For additional information, please see:**
> - Official GitLab CE Docs: https://docs.gitlab.com/ee/install/
> - Let's Encrypt Integration: https://docs.gitlab.com/ee/administration/letsencrypt.html
> - [Book] "The DevOps Handbook" by Gene Kim et al.

---

## Phase 1: Install GitLab Community Edition (CE)

1. **Install GitLab CE**
   ```bash
   sudo EXTERNAL_URL="http://gitlab.yourdomain.com" apt-get install gitlab-ce
   ```
   - Access GitLab at `http://gitlab.yourdomain.com` to complete setup.

2. **Configure SSL (Let's Encrypt or custom certs)**
   - Update `EXTERNAL_URL` to use HTTPS:
     ```bash
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

---

## Phase 2: Configure Backups

- Enable and schedule backups in `/etc/gitlab/gitlab.rb`:
  ```ruby
  gitlab_rails['backup_path'] = '/var/opt/gitlab/backups'
  gitlab_rails['backup_archive_permissions'] = 0644
  gitlab_rails['backup_keep_time'] = 604800 # 7 days
  ```
- Run manual backup:
  ```bash
  sudo gitlab-backup create
  ```

---

## Phase 3: Register GitLab Runner for CI/CD

1. **Install GitLab Runner**
   ```bash
   curl -L --output gitlab-runner https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64
   sudo mv gitlab-runner /usr/local/bin/
   sudo chmod +x /usr/local/bin/gitlab-runner
   sudo useradd --comment 'GitLab Runner' --create-home gitlab-runner --shell /bin/bash
   sudo gitlab-runner install --user=gitlab-runner --working-directory=/home/gitlab-runner
   sudo gitlab-runner start
   ```
2. **Register the Runner**
   - Get registration token from GitLab: Settings > CI/CD > Runners
   - Run:
     ```bash
     sudo gitlab-runner register
     ```
   - Enter GitLab URL, token, executor type (e.g., shell, docker)

---

## Phase 4: Enable Container & Package Registry

- Enable registry in `/etc/gitlab/gitlab.rb`:
  ```ruby
  registry_external_url 'https://gitlab.yourdomain.com:5050'
  ```
- Reconfigure GitLab:
  ```bash
  sudo gitlab-ctl reconfigure
  ```

---

## Phase 5: Configure GitHub Mirroring

- In GitLab UI: Settings > Repository > Mirroring repositories
- Add GitHub repo URL, set direction to Push, use Personal Access Token for authentication.
- Optionally, use a sync script:
  ```bash
  git remote add github https://github.com/youruser/yourrepo.git
  git push github main
  ```

---

## Phase 6: Set Up Webhooks

- In GitLab UI: Settings > Webhooks
- Add webhook URL (e.g., for CI, notifications, integrations)
- Test webhook delivery and review logs for errors.

---

## Troubleshooting & Best Practices
- Always test configuration changes with `sudo gitlab-ctl reconfigure` and `sudo gitlab-ctl restart`.
- Monitor logs in `/var/log/gitlab/` for errors.
- Secure your SSL keys and restrict access.
- Document all changes for future reference.

---

> **Update Notice:** Instructions accurate as of October 2025. For latest info, see official docs.
> 
> **Further Reading:**
> - https://docs.gitlab.com/ee/install/
> - https://docs.gitlab.com/ee/ci/
> - "The DevOps Handbook" by Gene Kim et al.
