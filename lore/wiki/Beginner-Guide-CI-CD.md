# Beginner's Guide to CI/CD for The Leviathan Engine

> **Update Notice:**
> This guide is accurate as of October 29, 2025. Tooling and best practices may evolve—always consult official documentation for the latest updates.

## Overview
This guide explains how CI/CD (Continuous Integration/Continuous Deployment) works in The Leviathan Engine project, focusing on how GitHub, GitLab, Docker, Kubernetes, and VMs interconnect. It is designed for beginners who want to understand the big picture, not the step-by-step usage of each tool.

---

## CI/CD Pipeline: How the Tools Work Together

### 1. **Source Control: GitHub & GitLab**
- **GitHub**: Hosts the main code repository, issues, and documentation. All code changes are tracked here.
- **GitLab**: Used for self-hosted CI/CD runners and private builds. Integrates with the main GitHub repo for advanced automation and internal builds.

**Relationship:**
- Developers push code to GitHub.
- GitLab CI/CD runners monitor GitHub for changes and trigger automated build/test/deploy pipelines.

### 2. **Build & Test Automation: GitLab CI/CD**
- **GitLab Runners**: VMs or containers that execute build, test, and deployment jobs.
- **Pipeline Stages**: Code is built, tested, and packaged automatically on every commit or merge.

**Relationship:**
- GitLab runners are provisioned on VMs (or Docker containers) in your lab.
- Each runner pulls the latest code from GitHub, builds it, runs tests, and prepares Docker images.

### 3. **Containerization: Docker**
- **Docker**: Packages the application and its dependencies into portable containers.
- **Images**: Built by CI/CD pipelines and stored in a registry (GitLab, GitHub, or local).

**Relationship:**
- CI/CD pipelines build Docker images from the codebase.
- Images are pushed to a registry for deployment.

### 4. **Orchestration: Kubernetes**
- **Kubernetes**: Manages deployment, scaling, and operation of Docker containers across multiple VMs.
- **Clusters**: Group of VMs (nodes) running Kubernetes, hosting the application.

**Relationship:**
- CI/CD pipelines deploy Docker images to Kubernetes clusters.
- Kubernetes ensures the application is running, scales as needed, and self-heals.

### 5. **Infrastructure: VMs & Networking**
- **VMs**: Host Docker, GitLab runners, and Kubernetes nodes. Provisioned via Proxmox or similar hypervisors.
- **Networking**: Segregated networks (green/blue/red) for security, performance, and storage.

**Relationship:**
- VMs provide the compute resources for all CI/CD components.
- Networking ensures secure, reliable communication between services.

---

## Visual Flow
1. **Developer pushes code to GitHub**
2. **GitLab runner (on VM or Docker) detects change**
3. **Runner builds, tests, and packages code into Docker image**
4. **Image is pushed to registry**
5. **Kubernetes cluster pulls image and deploys application**
6. **Application runs on VMs, monitored and scaled by Kubernetes**


## Visual Diagram
![Leviathan Engine CI/CD Flow](Beginner-Guide-CI-CD.svg)

*This diagram shows the relationships and workflow between GitHub, GitLab, Docker, Kubernetes, and VMs in the CI/CD pipeline. Arrows indicate the flow from code to deployment. See the legend for icon meanings.*

## Key Documents & References
- [Test-Lab-Architecture](Test-Lab-Architecture.md): Details on VM roles, networking, and infrastructure layout
- [Docker Tips](Docker-Tips.md): Practical advice for Docker hosts in your lab
- [Design Philosophy](Design-Philosophy.md): Engine design principles and workflow standards

---

## Book Recommendations
- **"The DevOps Handbook" by Gene Kim, Jez Humble, Patrick Debois, John Willis**
- **"Continuous Delivery: Reliable Software Releases through Build, Test, and Deployment Automation" by Jez Humble & David Farley**
- **"Kubernetes Up & Running" by Kelsey Hightower, Brendan Burns, Joe Beda**
- **"Docker Deep Dive" by Nigel Poulton**
- **"Site Reliability Engineering" by Betsy Beyer, Chris Jones, Jennifer Petoff, Niall Richard Murphy**
- **"Learning GitLab CI/CD" by Adam O'Grady**
- **"Infrastructure as Code" by Kief Morris**
- **"Pro Git" by Scott Chacon & Ben Straub**

---

## Popular & Current Video Tutorials
- [GitHub Actions CI/CD Crash Course (freeCodeCamp)](https://www.youtube.com/watch?v=R8_veQiYBjI)
- [GitLab CI/CD Pipeline Tutorial (TechWorld with Nana)](https://www.youtube.com/watch?v=9zUHg7xjIqQ)
- [Docker for Beginners (Academind)](https://www.youtube.com/watch?v=3c-iBn73dDE)
- [Kubernetes Explained (TechWorld with Nana)](https://www.youtube.com/watch?v=X48VuDVv0do)
- [Infrastructure as Code with Terraform (freeCodeCamp)](https://www.youtube.com/watch?v=7xngnjfIlK4)
- [Proxmox VE Full Course (LearnLinuxTV)](https://www.youtube.com/watch?v=Zt2y4aQfQpA)

---

## For Additional Information
- [GitHub Docs](https://docs.github.com/en)
- [GitLab Docs](https://docs.gitlab.com/ee/ci/)
- [Docker Docs](https://docs.docker.com/)
- [Kubernetes Docs](https://kubernetes.io/docs/)
- [Proxmox Docs](https://pve.proxmox.com/wiki/Main_Page)

---

## Summary
This guide provides a high-level map of how CI/CD tools work together in The Leviathan Engine project. For practical setup, see the referenced documents and official guides. The goal is to help you understand the relationships and workflow, so you can confidently build, test, and deploy in a modern, scalable environment.

---

> **Health Reminder:**
> Great progress! Don't forget to take a quick walk break, hydrate, and rest your eyes before continuing your setup.
