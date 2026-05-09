# 🏠 Homelab Network Architecture

## 📌 Overview

This homelab is organized using multiple isolated Docker networks to improve:

* Security
* Maintainability
* Scalability
* Service separation
* Easier troubleshooting

The infrastructure is divided by purpose.

---

# 🌐 Network Layout

```text
                              ┌─────────────────┐
                              │    Internet     │
                              └────────┬────────┘
                                       │
                              ┌────────▼────────┐
                              │      Caddy      │
                              │ Reverse Proxy   │
                              └────────┬────────┘
                                       │
        ┌──────────────────────────────┼──────────────────────────────┐
        │                              │                              │
        │                              │                              │

┌───────▼────────┐          ┌──────────▼─────────┐         ┌──────────▼─────────┐
│    dns_net     │          │   monitoring_net   │         │    network_net     │
├────────────────┤          ├────────────────────┤         ├────────────────────┤
│ AdGuard Home   │          │ Homepage           │         │ NetBird            │
│ Homepage       │          │ Beszel             │         │ Caddy              │
│ Caddy          │          │ Uptime Kuma        │         └────────────────────┘
└────────────────┘          │ Caddy              │
                            └──────────┬─────────┘
                                       │
                             ┌─────────▼─────────┐
                             │    services_net   │
                             ├───────────────────┤
                             │ n8n               │
                             │ Vikunja           │
                             │ Vaultwarden       │
                             │ Syncthing         │
                             │ Caddy             │
                             └───────────────────┘
```

---

# 🧩 Networks

## `dns_net`

Infrastructure-related DNS services.

### Containers

* AdGuard Home
* Homepage
* Caddy

### Purpose

* DNS filtering
* Local DNS resolution
* Homepage widgets access

---

## `monitoring_net`

Monitoring and observability stack.

### Containers

* Homepage
* Beszel
* Uptime Kuma
* Caddy

### Purpose

* Service monitoring
* Status pages
* Metrics and uptime checks
* Dashboard widgets

---

## `network_net`

Core networking layer.

### Containers

* Caddy
* NetBird

### Purpose

* Reverse proxy
* External access
* VPN networking
* Entry point for all services

---

## `services_net`

Main application services.

### Containers

* n8n
* Vikunja
* Vaultwarden
* Syncthing
* Caddy

### Purpose

* Automation
* Productivity
* Password management
* File synchronization

---

# 🔥 Important Architecture Notes

## Caddy Connectivity

Caddy MUST be connected to every Docker network.

This allows it to:

* Reach internal containers
* Reverse proxy services
* Centralize HTTPS handling
* Manage TLS certificates

Example:

```yaml
services:
  caddy:
    networks:
      - dns_net
      - monitoring_net
      - network_net
      - services_net
```

---

# 📊 Design Philosophy

## Why multiple Docker networks?

Using isolated Docker bridge networks provides:

| Benefit      | Description                        |
| ------------ | ---------------------------------- |
| Security     | Services cannot freely communicate |
| Isolation    | Easier troubleshooting             |
| Scalability  | Easy future expansion              |
| Organization | Cleaner infrastructure             |
| Performance  | Reduced unnecessary traffic        |

---

# 🚀 Future Expansion Ideas

## Possible `media_net`

```text
Jellyfin
Sonarr
Radarr
Prowlarr
Bazarr
```

## Possible `db_net`

```text
PostgreSQL
MariaDB
Redis
```

Keeping databases isolated is highly recommended for larger setups.

---

# ✅ Final Notes

Current architecture goals:

* Clean separation of concerns
* Centralized reverse proxy
* Internal network isolation
* Widget/API accessibility where required
* Scalable long-term homelab design

This structure is suitable for:

* Docker Compose
* Docker Swarm
* Future Kubernetes migration
* VLAN separation
* Multi-host expansion

```
```
