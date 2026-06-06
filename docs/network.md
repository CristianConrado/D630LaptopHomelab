# Network Architecture

## Overview

All external access goes through **Tailscale mesh VPN**. There is no port forwarding, no exposed services, no public-facing infrastructure. Your device joins the mesh and talks directly to the D630's Tailscale IP. Caddy listens on that IP and routes traffic to the appropriate container.

```
Your device (Tailscale client)
        │
        └──► D630 Tailscale ──► Caddy ──► container
```

---

## Docker Networks

Each functional group lives in its own isolated Docker network. Caddy is the only container that bridges across all of them.

| Network | Containers |
|---|---|
| `proxy_net` | Caddy |
| `network_net` | Tailscale |
| `dns_net` | AdGuard Home |
| `monitoring_net` | Beszel, Uptime Kuma, Homepage |
| `services_net` | n8n, Vikunja |

Caddy connects to all networks so it can reach every backend:

```yaml
caddy:
  networks:
    - proxy_net
    - network_net
    - dns_net
    - monitoring_net
    - services_net
```

No other container needs cross-network access. Isolation is intentional.

---

## TLS / HTTPS

No public domain required. Caddy runs as an internal CA (`tls internal`), issues certificates for internal hostnames, and signs them with its own root cert.

**One-time setup per client device:**
1. Export Caddy's root CA certificate
2. Install it as a trusted CA on your device
3. All internal services show a valid padlock — no browser warnings

AdGuard Home handles DNS rewrites so hostnames resolve to the D630's Tailscale IP:

| Hostname | Resolves to |
|---|---|
| `adguard.home` | D630 Tailscale IP |
| `homepage.home` | D630 Tailscale IP |
| `beszel.home` | D630 Tailscale IP |
| `uptime.home` | D630 Tailscale IP |
| `n8n.home` | D630 Tailscale IP |
| `vikunja.home` | D630 Tailscale IP |
| `vaultwarden.home` | D630 Tailscale IP |

Caddy then routes by hostname to the correct container on the correct internal network.

---

## Traffic Flow

```
Your device
  │  (Tailscale mesh)
  ▼
D630 :443
  │  (Caddy — reverse proxy + TLS termination)
  ├──► dns_net       ──► AdGuard Home
  ├──► monitoring_net ──► Beszel / Uptime Kuma / Homepage
  └──► services_net  ──► n8n / Vikunja / VaultWarden
```

Tailscale itself (`network_net`) is not proxied through Caddy — it operates at the network layer, below HTTP.

---

## Notes

- **No ports exposed to the internet.** Ever.
- **Tailscale is the only entry point.** No SSH without being on the mesh first.
- AdGuard Home also serves as the upstream DNS resolver for all containers (optional but recommended — consistent DNS behavior inside and outside Docker).
- Rclone backups go out through Tailscale or directly — not proxied through Caddy.
