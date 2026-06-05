# 🏠 D630 Homelab

Turning an old **Dell Latitude D630** into a modern self-hosted homelab running on **Debian**.

This project started as a way to reuse my first laptop and learn more about:

* Self-hosting
* Docker
* Reverse proxies
* VPN networking
* Infrastructure monitoring
* Secure remote access

The goal is to build a lightweight, modular, and secure homelab capable of running essential self-hosted services on old hardware.

---

# ⚙️ Software Stack

| Service        | Purpose                 |
| -------------- | ----------------------- |
| Debian         | Base operating system   |
| Docker         | Container runtime       |
| Dockhand       | Docker stack management |
| Caddy          | Reverse proxy and HTTPS |
| Tailscale      | Secure VPN access       |
| AdGuard Home   | DNS filtering           |
| Homepage       | Dashboard               |
| Uptime Kuma    | Monitoring services     |
| Beszel         | Monitoring Hardware     |
| Vaultwarden    | Password manager        |
| Vikunja        | Task management         |
| n8n            | Automation              |
| Syncthing      | File synchronization    |

---

# 🔥 Important Notes

* Netbird acts as the secure entrypoint into the homelab
* Caddy handles reverse proxying and HTTPS internally
* Services are isolated using Docker networks
* Homepage is used as the central dashboard
* Everything runs on Debian using Docker Compose

---

# ❤️ Why This Project Exists

This homelab is both a learning project and a way to give new life to old hardware.

The Dell D630 was my first laptop, and instead of letting it collect dust, it now serves as a small self-hosted infrastructure server running services I use every day.

Old hardware still has value.
