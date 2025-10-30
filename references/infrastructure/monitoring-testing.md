# Monitoring & Testing Guide (Prometheus, Grafana, k6)

> **Update Notice:** Accurate as of October 2025. For latest info, see official documentation.
> 
> **For additional information, please see:**
> - Prometheus Docs: https://prometheus.io/docs/
> - Grafana Docs: https://grafana.com/docs/
> - k6 Docs: https://k6.io/docs/
> - [Book] "Site Reliability Engineering" by Betsy Beyer et al.

---

## Phase 1: Prometheus Setup

- Example `prometheus.yml`:
  ```yaml
  global:
    scrape_interval: 15s
  scrape_configs:
    - job_name: 'leviathan-engine'
      static_configs:
        - targets: ['localhost:8080']
      scrape_interval: 5s
      metrics_path: /metrics
    - job_name: 'postgresql'
      static_configs:
        - targets: ['postgres-exporter:9187']
    - job_name: 'system'
      static_configs:
        - targets: ['node-exporter:9100']
  ```

## Phase 2: Grafana Setup

- Access Grafana at http://localhost:3000 (default admin/admin)
- Import dashboards for Leviathan Engine metrics, system health, and database performance.

## Phase 3: Load Testing with k6

- Example test script:
  ```javascript
  // scripts/load-test.js
  import http from 'k6/http';
  import { check, sleep } from 'k6';
  import { WebSocket } from 'k6/ws';
  export let options = {
    stages: [
      { duration: '2m', target: 10 },
      { duration: '5m', target: 100 },
      { duration: '2m', target: 0 },
    ],
  };
  export default function() {
    const ws = new WebSocket('ws://localhost:8080/ws');
    ws.on('open', () => {
      ws.send(JSON.stringify({ type: 'auth', username: `player${__VU}`, token: 'test-token' }));
    });
    ws.on('message', (data) => {
      check(data, { 'auth successful': (msg) => JSON.parse(msg).type === 'auth-ok', });
    });
    sleep(1);
  }
  ```

---

## Troubleshooting & Best Practices
- Monitor Prometheus and Grafana dashboards for real-time metrics.
- Use k6 for automated load and performance testing.
- Document all monitoring and testing configurations.

---

> **Update Notice:** Instructions accurate as of October 2025. For latest info, see official docs.
> 
> **Further Reading:**
> - https://prometheus.io/docs/
> - https://grafana.com/docs/
> - https://k6.io/docs/
> - "Site Reliability Engineering" by Betsy Beyer et al.
