# 🏠 Homelab Network Architecture

# 🌐 Network Layout

```text
                           ┌─────────────────┐
                           │     Internet    │
                           │  VPN Clients    │
                           └────────┬────────┘
                                    │
                           ┌────────▼────────┐
                           │     NetBird     │
                           │  VPN Gateway    │
                           └────────┬────────┘
                                    │
                           ┌────────▼────────┐
                           │      Caddy      │
                           │ Reverse Proxy   │
                           └────────┬────────┘
                                    │
        ┌───────────────────────────┼───────────────────────────┐
        │                           │                           │
        │                           │                           │

┌───────▼────────┐       ┌──────────▼─────────┐      ┌──────────▼─────────┐
│    dns_net     │       │   monitoring_net   │      │    services_net    │
├────────────────┤       ├────────────────────┤      ├────────────────────┤
│ AdGuard Home   │       │ Homepage           │      │ n8n                │
│ Homepage       │       │ Beszel             │      │ Vikunja            │
│ Caddy          │       │ Uptime Kuma        │      │ Vaultwarden        │
└────────────────┘       │ Caddy              │      │ Syncthing          │
                         └────────────────────┘      │ Caddy              │
                                                     └────────────────────┘


                    ┌─────────────────────────────┐
                    │         network_net         │
                    ├─────────────────────────────┤
                    │ NetBird                     │
                    │ Caddy                       │
                    └─────────────────────────────┘
```

---

# 🔁 Traffic Flow

```text
Client
  ↓
NetBird VPN
  ↓
Caddy Reverse Proxy
  ↓
Internal Docker Networks
  ↓
Services
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
