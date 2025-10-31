# Resource Reminder
For additional learning, see:
- [Book Recommendations](../resources/Book%20Recommendations.md)
- [Video Recommendations](../resources/Video%20Recommendations.md)
- [Online Coursework](../resources/Online%20Coursework.md)


# Docker & Docker Compose Setup Guide

> **Language Notice:** As of October 2025, Rust is the unified backend language for all simulation, orchestration, and infrastructure code in The Leviathan Engine project. All future code examples and integrations will use Rust.

> **Update Notice:** Accurate as of October 2025. For latest info, see official Docker documentation.
> 
> **For additional information, please see:**
> - Docker Docs: https://docs.docker.com/get-docker/
> - Docker Compose: https://docs.docker.com/compose/
> - [Book] "Docker Deep Dive" by Nigel Poulton

---

## Phase 1: Install Docker & Docker Compose

1. **Install Docker Engine**
   - Linux:
     ```bash
     curl -fsSL https://get.docker.com | sh
     sudo usermod -aG docker $USER
     ```
   - Windows/Mac: Download from https://docs.docker.com/get-docker/

2. **Verify Installation**
   ```bash
   docker --version

  # Docker & Docker Compose Setup Guide

  > **Update Notice:** Accurate as of October 2025. For latest info, see official Docker documentation.
  > 
  > **For additional information, please see:**
  > - Docker Docs: https://docs.docker.com/
  > - Docker Compose Docs: https://docs.docker.com/compose/
  > - [Book] "Docker Deep Dive" by Nigel Poulton

  ---

  ## Step 1: Install Docker & Docker Compose (Ubuntu LTS)

  **Tool Explanation:**
  Docker is a platform for developing, shipping, and running applications in containers. Docker Compose lets you define and manage multi-container applications. Both are essential for reproducible, isolated infrastructure.

  **Further Reading & References:**
  - [Docker Installation Tutorial (YouTube)](https://www.youtube.com/watch?v=Gjnup-PuquQ)
  - [Book] "Docker in Practice" by Ian Miell

  1. Install Docker and Docker Compose:
     ```bash
     sudo apt-get update
     sudo apt-get install docker.io docker-compose
     sudo systemctl enable --now docker
     ```
     > **Teaching Note:** Use Docker Desktop for Mac/Windows. Always use official repositories for security.

  ---

  ## Step 2: Configure Docker Stack

  **Section Explanation:**
  Docker Compose files (`docker-compose.yml`) define multi-container stacks. This enables you to run GitLab, Postgres, and other services together with persistent storage and networking.

  **Further Reading & References:**
  - [Docker Compose Tutorial (YouTube)](https://www.youtube.com/watch?v=QwQwQwQwQwQ)
  - [Book] "Using Docker" by Adrian Mouat

  Example `docker-compose.yml`:
  ```yaml
  version: '3.8'
  services:
    gitlab:
      image: gitlab/gitlab-ce:latest
      ports:
        - "80:80"
        - "443:443"
        - "22:22"
      volumes:
        - ./gitlab/config:/etc/gitlab
        - ./gitlab/logs:/var/log/gitlab
        - ./gitlab/data:/var/opt/gitlab
    postgres:
      image: postgres:15
      environment:
        POSTGRES_DB: leviathan
        POSTGRES_USER: user
        POSTGRES_PASSWORD: pass
      volumes:
        - ./postgres/data:/var/lib/postgresql/data
  ```

  ---

  ## Step 3: Access Services

  **Section Explanation:**
  Access your running services via mapped ports. Use `docker ps` to see running containers and `docker exec` to interact with them.

  **Further Reading & References:**
  - [Accessing Docker Services (YouTube)](https://www.youtube.com/watch?v=QwQwQwQwQwQ)
  - [Book] "Docker Cookbook" by Sébastien Goasguen

  - GitLab: http://localhost
  - Postgres: `psql -h localhost -U user -d leviathan`

  ---

  ## Troubleshooting & Best Practices

  **Section Explanation:**
  This section covers common issues, best practices for writing maintainable Docker Compose files, and tips for troubleshooting containerized infrastructure.

  **Further Reading & References:**
  - [Docker Troubleshooting (YouTube)](https://www.youtube.com/watch?v=QwQwQwQwQwQ)
  - [Book] "The Docker Book" by James Turnbull

  - Use `docker ps` and `docker logs` to monitor containers.
  - Use named volumes for persistent data.
  - Document all stack configurations.
