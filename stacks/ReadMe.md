# Stacks

This folder contains the Docker Compose stacks used to organize the homelab infrastructure by purpose.

## Structure

### Automation
Containerized workflow automation and integrations.

- `n8n` — workflow automation platform

---

### Dockge
Core deployment and initialization utilities.

- `Dockge` — Docker environment management

---

### Dashboard
Self-hosted dashboard and homepage services.

- `homepage`
- `services`
- `widgets`
- `bookmarks`

---

### DNS
DNS filtering, local resolution, and access control.

- `adguardhome`
- `acls`

---

### Monitoring
Infrastructure monitoring and uptime tracking.

- `beszel`
- `uptime-kuma`

---

### Productivity
Personal productivity and learning.

- `vikunja` — task management
- `floci` — AWS deployment to learn

---

### Proxy
Reverse proxy and web routing configuration.

- `caddy`
- `Caddyfile`

---

### VPN
Private networking and secure remote access.

- `tailscale`

---

## Notes

- Each stack is isolated in its own directory.
- Services are grouped by functionality for easier maintenance.

