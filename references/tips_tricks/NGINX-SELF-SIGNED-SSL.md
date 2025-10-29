# Generating Self-Signed SSL Certificates for Nginx Reverse Proxy

> **Update Notice:** Instructions accurate as of October 28, 2025. For latest best practices, consult Nginx and OpenSSL documentation.

## Overview
For lab and internal use, you can generate self-signed SSL certificates for each domain handled by your Nginx reverse proxy. This enables HTTPS encryption without needing a public CA.

## Step-by-Step Guide

### 1. Create a Directory for SSL Certificates
```bash
sudo mkdir -p /etc/nginx/ssl
```

### 2. Generate a Self-Signed Certificate and Key
Replace `app1.lab` with your actual domain name:
```bash
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout /etc/nginx/ssl/app1.lab.key \
  -out /etc/nginx/ssl/app1.lab.crt \
  -subj "/CN=app1.lab"
```
- Repeat for each domain (e.g., `app2.lab`).

### 3. Update Nginx Server Block
Reference the generated cert and key in your config:
```nginx
server {
    listen 443 ssl;
    server_name app1.lab;
    ssl_certificate /etc/nginx/ssl/app1.lab.crt;
    ssl_certificate_key /etc/nginx/ssl/app1.lab.key;
    # ...other proxy settings...
}
```

### 4. Reload Nginx
```bash
sudo systemctl reload nginx
```

### 5. Trust the Certificate (Optional)
- On client machines, import the `.crt` file into the trusted root CA store to avoid browser warnings.
- For SSH tunnels or API clients, you may need to specify `--insecure` or equivalent if not trusting the cert.

## Further Reading
- [Nginx SSL Configuration Guide](https://nginx.org/en/docs/http/configuring_https_servers.html)
- [OpenSSL Documentation](https://www.openssl.org/docs/)

## Recommended Books
- "Linux Networking Cookbook" by Carla Schroder
- "The Nginx Cookbook" by Tim Butler

---
For additional infrastructure tips, add new markdown files to this folder. Keep this resource up to date for your team!
