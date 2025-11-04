# Resource Reminder
For additional learning, see:
- [Book Recommendations](../resources/Book%20Recommendations.md)
- [Video Recommendations](../resources/Video%20Recommendations.md)
- [Online Coursework](../resources/Online%20Coursework.md)



# Monitoring & Testing Guide (Prometheus, Grafana, k6)

> **Language Notice:** As of October 2025, Rust is the unified backend language for all simulation, orchestration, and infrastructure code in The Leviathan Engine project. All future code examples and integrations will use Rust.

> **Update Notice:** Accurate as of October 2025. For latest info, see official documentation.
> 
> **For additional information, please see:**
> - Prometheus Docs: https://prometheus.io/docs/
> - Grafana Docs: https://grafana.com/docs/
> - k6 Docs: https://k6.io/docs/
> - [Book] "Site Reliability Engineering" by Betsy Beyer et al.

---

## Step 1: Prometheus Setup (Ubuntu LTS/Proxmox)

**Tool Explanation:**
Prometheus is an open-source monitoring system that collects and stores metrics as time series data. It is ideal for tracking application, database, and system health in real time.

**Further Reading & References:**
- [Prometheus Monitoring 101 (YouTube)](https://www.youtube.com/watch?v=h4Sl21AKiDg)
- [Book] "Prometheus: Up & Running" by Brian Brazil

1. Install Prometheus (if not using Docker):
   ```bash
   sudo apt-get update
   sudo apt-get install prometheus
   ```
2. Configure `prometheus.yml`:
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
   > **Teaching Note:** Use Docker Compose for easier management in clustered environments. Always document your scrape targets.

---

## Step 2: Grafana Setup

**Tool Explanation:**
Grafana is a visualization and analytics platform that connects to Prometheus and other data sources. It enables you to create dashboards for real-time monitoring and alerting.

**Further Reading & References:**
- [Grafana Dashboards Tutorial (YouTube)](https://www.youtube.com/watch?v=sKNZMtoSHN4)
- [Book] "Learning Grafana 7.0" by Eric Salituro

1. Install Grafana (if not using Docker):
   ```bash
   sudo apt-get install -y apt-transport-https
   sudo apt-get install -y software-properties-common wget
   wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -
   echo "deb https://packages.grafana.com/oss/deb stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
   sudo apt-get update
   sudo apt-get install grafana
   sudo systemctl start grafana-server
   sudo systemctl enable grafana-server
   ```
2. Access Grafana at http://dockerhost:3000 (default admin/admin)
3. Import dashboards for Leviathan Engine metrics, system health, and database performance.
   > **Teaching Note:** Use pre-built dashboards as templates, then customize for your KPIs.

---

## Step 3: Load Testing with k6

**Tool Explanation:**
k6 is an open-source load testing tool for testing the performance of APIs, web applications, and WebSockets. It helps identify bottlenecks and validate scalability.

**Further Reading & References:**
- [k6 Load Testing Tutorial (YouTube)](https://www.youtube.com/watch?v=F1R3QG5pK2E)
- [Book] "The Art of Application Performance Testing" by Ian Molyneaux

1. Install k6:
   ```bash
   sudo apt-get install k6
   ```
2. Example test script:
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
   > **Teaching Note:** Use k6 for both HTTP and WebSocket load testing. Automate tests in your CI/CD pipeline.

---

- Monitor Prometheus and Grafana dashboards for real-time metrics.
- Use k6 for automated load and performance testing.
- Document all monitoring and testing configurations.
- Use version control for all scripts and dashboards.

## Troubleshooting & Best Practices

**Section Explanation:**
This section covers common issues, best practices for monitoring and testing, and tips for maintaining observability in your infrastructure.

**Further Reading & References:**
- [SRE Monitoring Best Practices (YouTube)](https://www.youtube.com/watch?v=QwQwQwQwQwQ)
- [Book] "Site Reliability Engineering" by Betsy Beyer et al.

- Monitor Prometheus and Grafana dashboards for real-time metrics.
- Use k6 for automated load and performance testing.
- Document all monitoring and testing configurations.
- Use version control for all scripts and dashboards.
- Monitor Prometheus and Grafana dashboards for real-time metrics.
- Use k6 for automated load and performance testing.
- Document all monitoring and testing configurations.
- Use version control for all scripts and dashboards.

---

> **Update Notice:** Instructions accurate as of October 2025. For latest info, see official docs.
> 
> **Further Reading:**
> - https://prometheus.io/docs/
> - https://grafana.com/docs/
> - https://k6.io/docs/
> - "Site Reliability Engineering" by Betsy Beyer et al.
