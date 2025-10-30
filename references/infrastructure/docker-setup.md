# Docker & Docker Compose Setup Guide

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
   docker compose version
   ```

---

## Phase 2: Configure Docker Compose Stack

- Example `docker-compose.yml` for Leviathan Engine:
  ```yaml
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

---

## Phase 3: Start Development Stack

```bash
docker compose up -d
```

- Access services:
  - Grafana: http://localhost:3000
  - Prometheus: http://localhost:9090
  - PostgreSQL: localhost:5432
  - Redis: localhost:6379

---

## Troubleshooting & Best Practices
- Use `docker compose logs` to view service logs.
- Use `docker compose down` to stop and clean up.
- Document all changes to your stack.

---

> **Update Notice:** Instructions accurate as of October 2025. For latest info, see official docs.
> 
> **Further Reading:**
> - https://docs.docker.com/get-docker/
> - https://docs.docker.com/compose/
> - "Docker Deep Dive" by Nigel Poulton
