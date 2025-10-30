# Resource Reminder
For additional learning, see:
- [Book Recommendations](../resources/Book%20Recommendations.md)
- [Video Recommendations](../resources/Video%20Recommendations.md)
- [Online Coursework](../resources/Online%20Coursework.md)

# Ansible Setup Guide

> **Update Notice:** Accurate as of October 2025. For latest info, see official Ansible documentation.
> 
> **For additional information, please see:**
> - Ansible Docs: https://docs.ansible.com/
> - [Book] "Ansible for DevOps" by Jeff Geerling

---

## Phase 1: Install Ansible

- Linux:
  ```bash
  sudo apt-get update
  sudo apt-get install ansible
  ```
- Mac:
  ```bash
  brew install ansible
  ```
- Windows: Use WSL or install via pip.

---

## Phase 2: Directory Structure

```
infrastructure/ansible/
├── inventories/
│   ├── development/
│   ├── staging/
│   └── production/
├── roles/
│   ├── common/
│   ├── golang/
│   ├── postgresql/
│   ├── monitoring/
│   ├── leviathan-engine/
│   └── load-testing/
├── playbooks/
│   ├── site.yml
│   ├── deploy-engine.yml
│   └── load-test.yml
└── group_vars/
    ├── all.yml
    └── [environment].yml
```

---

## Phase 3: Example Role for Leviathan Engine

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

---

## Troubleshooting & Best Practices
- Use `ansible-playbook --check` for dry runs.
- Document all playbooks and roles.
- Use version control for configuration files.

---

> **Update Notice:** Instructions accurate as of October 2025. For latest info, see official docs.
> 
> **Further Reading:**
> - https://docs.ansible.com/
> - "Ansible for DevOps" by Jeff Geerling
