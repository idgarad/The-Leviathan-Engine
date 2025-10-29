# Docker Tips & Best Practices

> **Update Notice:** Accurate as of October 29, 2025. This page collects practical advice for running Docker in development and test lab environments.

## General Tips
- Use official images when possible for reliability and security.
- Pin image versions to avoid unexpected updates.
- Use Docker Compose for multi-container orchestration and easy service management.
- Name containers and networks clearly for easier troubleshooting.
- Map persistent volumes for data you want to keep between container restarts.
- Set resource limits (CPU, memory) to prevent runaway containers.
- Use `.env` files for environment variables and secrets management.
- Regularly prune unused images, containers, and volumes to save disk space (`docker system prune`).
- Document your setup in the wiki for team onboarding and reproducibility.

## Networking
- Use custom bridge networks for container isolation and service discovery.
- For multi-node setups, consider Docker Swarm or Kubernetes for orchestration.
- Expose only necessary ports to the host; use internal networks for backend services.

## Security
- Avoid running containers as root unless absolutely necessary.
- Keep Docker and host OS up to date.
- Use secrets management for sensitive data (e.g., Docker secrets, Vault).
- Scan images for vulnerabilities (e.g., `docker scan`).

## Troubleshooting
- Use `docker logs <container>` for container output and error messages.
- Use `docker exec -it <container> /bin/bash` to get a shell inside running containers.
- Check network connectivity with `docker network inspect` and `docker container inspect`.

## Monitoring
- Deploy monitoring tools (Prometheus, Grafana, cAdvisor) for resource usage and health checks.
- Set up alerting for container failures or resource exhaustion.

---
Add new tips as you discover them and keep this page up to date for the team!