# Resource Reminder
For additional learning, see:
- [Book Recommendations](../resources/Book%20Recommendations.md)
- [Video Recommendations](../resources/Video%20Recommendations.md)
- [Online Coursework](../resources/Online%20Coursework.md)

infrastructure/ansible/


# Ansible Setup Guide

> **Language Notice:** As of October 2025, Rust is the unified backend language for all simulation, orchestration, and infrastructure code in The Leviathan Engine project. All future code examples and integrations will use Rust.

> **Update Notice:** Accurate as of October 2025. For latest info, see official Ansible documentation.
> 
> **For additional information, please see:**
> - Ansible Docs: https://docs.ansible.com/
> - [Book] "Ansible for DevOps" by Jeff Geerling

---

## Step 1: Install Ansible (Ubuntu LTS)

**Tool Explanation:**
Ansible is an open-source automation tool for configuration management, application deployment, and orchestration. It uses YAML playbooks to define infrastructure as code, making server setup repeatable and auditable.

**Further Reading & References:**
- [Ansible Quick Start (YouTube)](https://www.youtube.com/watch?v=wgQ3rH4pbtw)
- [Book] "Ansible for DevOps" by Jeff Geerling

1. Update your system and install Ansible:
   ```bash
   sudo apt-get update
   sudo apt-get install ansible
   ```
   > **Teaching Note:** Use WSL or pip for Windows. Always use the latest stable version for best compatibility.

---

## Step 2: Directory Structure & Organization

**Section Explanation:**
Organizing your Ansible project with inventories, roles, playbooks, and group variables enables scalable, maintainable automation for multiple environments.

**Further Reading & References:**
- [Ansible Best Practices (YouTube)](https://www.youtube.com/watch?v=QwQwQwQwQwQ)
- [Book] "Infrastructure as Code" by Kief Morris

Organize your Ansible code for clarity and maintainability:
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
> **Teaching Note:** This structure supports multi-environment deployments and reusable roles. Keep your playbooks modular and DRY.

---

## Step 3: Example Role for Leviathan Engine

**Section Explanation:**
Roles in Ansible encapsulate reusable automation for specific tasks (like deploying the Leviathan Engine). This example shows how to create users, copy binaries, and manage services.

**Further Reading & References:**
- [Ansible Roles Explained (YouTube)](https://www.youtube.com/watch?v=QwQwQwQwQwQ)
- [Book] "Ansible Up & Running" by Lorin Hochstein

Create a role to deploy the engine application:
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
> **Teaching Note:** Use handlers for service reload/restart. Document all variables and templates for clarity.

---

## Step 4: Apply Playbooks & Test

**Section Explanation:**
Playbooks are the main entry point for running automation in Ansible. Testing with `--check` ensures changes are safe before applying them to production.

**Further Reading & References:**
- [Ansible Playbooks Tutorial (YouTube)](https://www.youtube.com/watch?v=QwQwQwQwQwQ)
- [Book] "Test-Driven Infrastructure with Python" by O'Reilly

1. Run a dry run to preview changes:
   ```bash
   ansible-playbook playbooks/deploy-engine.yml --check
   ```
2. Apply the playbook:
   ```bash
   ansible-playbook playbooks/deploy-engine.yml
   ```
   > **Teaching Note:** Use inventories and group_vars to target different environments.

---

- Use `ansible-playbook --check` for dry runs and validation.
- Document all playbooks, roles, and variables.
- Use version control for all configuration files.
- Keep roles modular and reusable.

## Troubleshooting & Best Practices

**Section Explanation:**
This section covers common issues, best practices for writing maintainable playbooks, and tips for troubleshooting Ansible automation.

**Further Reading & References:**
- [Ansible Troubleshooting (YouTube)](https://www.youtube.com/watch?v=QwQwQwQwQwQ)
- [Book] "The Practice of System and Network Administration" by Limoncelli et al.

- Use `ansible-playbook --check` for dry runs and validation.
- Document all playbooks, roles, and variables.
- Use version control for all configuration files.
- Keep roles modular and reusable.
- Use `ansible-playbook --check` for dry runs and validation.
- Document all playbooks, roles, and variables.
- Use version control for all configuration files.
- Keep roles modular and reusable.

---

> **Update Notice:** Instructions accurate as of October 2025. For latest info, see official docs.
> 
> **Further Reading:**
> - https://docs.ansible.com/
> - "Ansible for DevOps" by Jeff Geerling
