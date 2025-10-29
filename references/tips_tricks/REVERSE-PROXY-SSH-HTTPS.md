# Using a Reverse Proxy/ELZ Server for HTTPS and SSH Forwarding to Local DNS Destinations

> **Update Notice:** Instructions accurate as of October 28, 2025. For latest best practices, consult Nginx, HAProxy, and OpenSSH documentation.

## Overview
You can deploy a dedicated proxy/reverse proxy server (sometimes called a jump host, ELZ, or bastion) to forward HTTPS and SSH traffic to internal machines using DNS hostnames. This is especially useful in dynamic lab environments where backend IPs may change.

## Solution Architecture
- **Reverse Proxy (Nginx/HAProxy):** Handles HTTPS traffic, routes requests to backend servers by DNS name.
- **SSH Proxy (Jump Host or HAProxy TCP):** Listens on a range of ports, forwards SSH connections to the correct internal host by DNS name.
- **Firewall/NAT:** Forwards external traffic on chosen port range to the proxy server.

## Step-by-Step Guide

### 1. Set Up the Proxy/ELZ Server
- Deploy a VM or physical server on your LAN with a static IP.
- Ensure it can resolve local DNS names (use DD-WRT or your DNS server).

### 2. Configure Firewall/NAT
- Forward a block of external ports (e.g., 40000–45000) to the proxy server’s IP.
- Example: External port 40001 → Proxy server port 40001

### 3. HTTPS Reverse Proxy (Nginx Example)
- Install Nginx:
  ```bash
  sudo apt update && sudo apt install nginx
  ```
- Configure server blocks for each internal service:
  ```nginx
  server {
      listen 443;
      server_name app1.lab;
      location / {
          proxy_pass https://app1.lab;
          proxy_set_header Host $host;
      }
  }
  server {
      listen 443;
      server_name app2.lab;
      location / {
          proxy_pass https://app2.lab;
          proxy_set_header Host $host;
      }
  }
  ```
- Nginx will resolve `app1.lab` and `app2.lab` via DNS.

### 4. SSH Proxy (HAProxy TCP Example)
- Install HAProxy:
  ```bash
  sudo apt update && sudo apt install haproxy
  ```
- Example config to forward ports to internal hosts:
  ```haproxy
  frontend ssh-in
      bind *:40001
      mode tcp
      default_backend ssh-app1

  backend ssh-app1
      mode tcp
      server app1 app1.lab:22

  frontend ssh-in2
      bind *:40002
      mode tcp
      default_backend ssh-app2

  backend ssh-app2
      mode tcp
      server app2 app2.lab:22
  ```
- Each external port maps to a backend host by DNS name.

### 5. Usage
- To SSH to `app1.lab`, connect to proxy server on port 40001:
  ```bash
  ssh user@proxy-server -p 40001
  ```
- For HTTPS, access via proxy server’s public IP or domain; Nginx routes to the correct backend.

## Best Practices
- Document port mappings and backend hostnames.
- Use strong authentication for SSH and HTTPS.
- Regularly update DNS records and proxy configs as lab changes.
- Monitor proxy server for performance and security.

## Further Reading
- [Nginx Reverse Proxy Guide](https://docs.nginx.com/nginx/admin-guide/web-server/reverse-proxy/)
- [HAProxy TCP Forwarding](https://www.haproxy.com/documentation/hapee/latest/configuration/tcp/)
- [OpenSSH Jump Host](https://www.ssh.com/academy/ssh/jump-host)

## Recommended Books
- "Linux Networking Cookbook" by Carla Schroder
- "SSH Mastery" by Michael W Lucas
- "The Nginx Cookbook" by Tim Butler

---
For additional infrastructure tips, add new markdown files to this folder. Keep this resource up to date for your team!
