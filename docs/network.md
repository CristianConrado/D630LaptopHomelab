# Network Architecture

## Overview

All external access goes through **Tailscale mesh VPN**. There is no port forwarding, no exposed services, no public-facing infrastructure. Your device joins the mesh and talks directly to the D630's Tailscale IP. Caddy listens on that IP and routes traffic to the appropriate container.

```
Your device (Tailscale client)
        │
        └──► D630 Tailscale ──► Caddy ──► container
```

---


## Traffic Flow

```
Your device
  │  (Tailscale mesh)
  ▼
D630 :443
  │  (Caddy — reverse proxy)
  ├──► dns_net       ──► AdGuard Home
  ├──► monitoring_net ──► Beszel / Uptime Kuma / Homepage
  └──► services_net  ──► n8n / Vikunja
```

---

## Notes

- **No ports exposed to the internet.** Ever.
- **Tailscale is the only entry point.** No SSH without being on the mesh first.
- AdGuard Home also serves as the upstream DNS resolver for all containers.
- Rclone backups go out through Tailscale or directly — not proxied through Caddy.
