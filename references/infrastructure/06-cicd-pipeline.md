# Resource Reminder
For additional learning, see:
- [Book Recommendations](../resources/Book%20Recommendations.md)
- [Video Recommendations](../resources/Video%20Recommendations.md)
- [Online Coursework](../resources/Online%20Coursework.md)


# GitLab CI/CD Pipeline Guide

> **Language Notice:** As of October 2025, Rust is the unified backend language for all simulation, orchestration, and infrastructure code in The Leviathan Engine project. All future code examples and integrations will use Rust.

> **Update Notice:** Accurate as of October 2025. For latest info, see official GitLab documentation.
> 
> **For additional information, please see:**
> - GitLab CI/CD Docs: https://docs.gitlab.com/ee/ci/
> - [Book] "Continuous Delivery" by Jez Humble & David Farley

---


## Step 1: Define Pipeline Stages

**Tool Explanation:**
CI/CD (Continuous Integration/Continuous Deployment) pipelines automate the process of building, testing, and deploying code. Defining clear stages helps organize and visualize the workflow from code commit to production.

**Further Reading & References:**
- [CI/CD Pipeline Concepts (YouTube)](https://www.youtube.com/watch?v=1aXZQcG2Y6I)
- [Book] "Continuous Delivery" by Jez Humble & David Farley

- Example stages:
  ```yaml
  stages:
    - test
    - build
    - security
    - deploy-dev
    - load-test
    - deploy-staging
  ```

---

test:
build:
deploy_dev:

## Step 2: Example .gitlab-ci.yml

**Section Explanation:**
The `.gitlab-ci.yml` file defines your pipeline jobs, stages, and environment variables. Each job runs in a clean environment, ensuring reproducibility and isolation.

**Further Reading & References:**
- [GitLab CI/CD YAML Tutorial (YouTube)](https://www.youtube.com/watch?v=QwQwQwQwQwQ)
- [Book] "CI/CD with Docker and Kubernetes" by Rafal Leszko

```yaml
variables:
  GO_VERSION: "1.25"
  POSTGRES_DB: leviathan_test
  POSTGRES_USER: test
  POSTGRES_PASSWORD: test


  stage: test
  image: golang:${GO_VERSION}
  services:
    - postgres:15
  script:
    - go mod download
    - go test -v -coverprofile=coverage.out ./...
    - go tool cover -html=coverage.out -o coverage.html
  artifacts:
    reports:
      coverage_report:
        coverage_format: cobertura
        path: coverage.xml
    paths:
      - coverage.html
  coverage: '/coverage: \d+\.\d+% of statements/'

---
  stage: build
  image: golang:${GO_VERSION}
  script:
    - CGO_ENABLED=0 GOOS=linux go build -o leviathan-engine ./cmd/server
  artifacts:
    paths:
      - leviathan-engine

security_scan:
  stage: security
  image: securecodewarrior/docker-gosec
  script:
    - gosec ./...
  allow_failure: true


  stage: deploy-dev
  image: alpine:latest
  before_script:
    - apk add --no-cache ansible
  script:
    - cd infrastructure/ansible
    - ansible-playbook -i inventories/development playbooks/deploy-engine.yml
  environment:
    name: development
    url: http://dev.leviathan.local

load_test:
  stage: load-test
  image: loadimpact/k6:latest
  script:
    - k6 run --out json=load-test-results.json scripts/load-test.js
  artifacts:
    reports:
      performance: load-test-results.json
```

## Troubleshooting & Best Practices

**Section Explanation:**
This section covers common issues, best practices for writing maintainable CI/CD pipelines, and tips for troubleshooting automated workflows.

**Further Reading & References:**
- [CI/CD Troubleshooting (YouTube)](https://www.youtube.com/watch?v=QwQwQwQwQwQ)
- [Book] "Accelerate: The Science of Lean Software and DevOps" by Nicole Forsgren et al.

- Use `gitlab-ctl restart` after pipeline config changes.
- Monitor pipeline status in GitLab UI.
- Document all pipeline stages and jobs.

---

> **Update Notice:** Instructions accurate as of October 2025. For latest info, see official docs.
> 
> **Further Reading:**
> - https://docs.gitlab.com/ee/ci/
> - "Continuous Delivery" by Jez Humble & David Farley
