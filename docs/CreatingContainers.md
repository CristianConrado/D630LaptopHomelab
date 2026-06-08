# 🚀 Creating Containers: Cristian's Homelab Stack Guide

Welcome to the central documentation for my homelab setup. This guide covers the reasoning, configurations, and tweaks for every service running in my environment. 

To keep things clean, modular, and easy to back up, **all Docker Compose files are organized inside a central `/stacks` directory**.

---
##  Service-by-Service Deep Dive

### 1.  Dockge
**Purpose:** The command center. I use Dockge to write, deploy, and manage all the other containers in this guide. 

* **The Setup:** While configurations sit in `/stacks/Dockge`, my persistent application data is safely stored in `/home/cristian/docker/dockge/data`.
* **Why it matters:** It is the most important container in the lab because it orchestrates everything else. 

```bash
# Create directories and set permissions
sudo mkdir -p /opt/stacks /opt/dockge
sudo chown -R $USER:$USER /opt/stacks /opt/dockge
cd /opt/dockge

# Download the compose file tailored for our stacks path
curl "https://dockge.kuma.pet/compose.yaml?port=5001&stacksPath=%2Fopt%2Fstacks" --output compose.yaml

# Edit and tweak paths if necessary
vi compose.yaml

# Boot up the stack engine
docker compose up -d
```
> **Important:** Once active, immediately navigate to the web UI on port `5001` to provision your admin account.

---

### 2. Tailscale & Caddy
**Purpose:** The single most crucial setup for remote access. This stack allows me to securely connect to my homelab from anywhere in the world without exposing open ports to the public internet.

* **The Breakthrough:** I realized I could leverage Tailscale's **MagicDNS** to effortlessly generate valid SSL certificates for my services. 
* **The Tweak:** To make this seamless, I grouped both the **Caddy** reverse proxy and the **Tailscale** network container into a single, unified Docker Compose stack.

---

### 3. Homepage
**Purpose:** A clean, modern landing page displaying all running services. 

* **The Tweak:** I deployed the default template but restricted allowed hosts to `localhost`, ensuring all external traffic is forced through Caddy's secure tunnel.
* **Port Conflict Resolution:** >  **CRITICAL PORT CHANGE:** The default configuration for Homepage uses port `3000`. This directly conflicts with **AdGuard Home**. **Ensure you change Homepage's host port mapping to `3333`!**

---

### 4. AdGuard Home
**Purpose:** Network-wide privacy protection and ad-blocking.

* **The Ingress Strategy:** I paired AdGuard Home with Caddy's SSL layer and my Tailscale tailnet. This ensures that accessing my custom domains via Tailscale redirects directly and safely to a certified Homepage dashboard.

---

### 5. Beszel
**Purpose:** A lightweight, performance-focused host and container resource monitor.

* **The Architecture:** I deployed the main Beszel Hub instance first, grabbed the automatically generated Agent script from the UI, and added the monitoring agent directly into my compose files.
* **Observation:** While it works perfectly for tracking my single server's vitals, this tool is highly scalable and truly shines when monitoring multiple nodes across a network.

---

### 6. Uptime Kuma
**Purpose:** Service status monitoring and instant down-time alerting.

* **Why I added it:** Beszel is excellent for hardware metrics, but for individual service containers, it frequently displayed `State = None`. I brought back Uptime Kuma from my previous lab builds to get explicit HTTP/TCP status checks.
* **The Tweak:** Extremely easy to deploy using their standard docker compose layout. I immediately tied it into my notification channels so I am instantly pinged if a container drops.

---

### 7. Vikunja
**Purpose:** A comprehensive, open-source to-do and project organizer.

* **The Inspiration:** Discovered via TikTok (which turned out to be an incredibly reliable recommendation this time!). 
* **Why it fits:** It supports **SQLite**, which keeps its memory and CPU footprint exceptionally low—ideal for my specific hardware constraints.

---

### 8. n8n
**Purpose:** Advanced, node-based workflow automation.

* **The Master Workflow:** I use n8n to build an automated, AI-driven expense pipeline. 
* **How it works:** I simply snap and upload a picture of a physical receipt. An AI model integrated into my n8n workflow parses the image, extracts the total, date, and vendor, and automatically sorts the data into my expense logs.

---

### 9.  Vaultwarden
**Purpose:** A lightweight, self-hosted implementation of the Bitwarden password manager API written in Rust.

* **Security Mandate:** Modern browsers require an active HTTPS connection to enable the WebCrypto APIs that password managers rely on. I configured this stack to route directly behind the **Tailscale + Caddy** proxy to secure my vaults with proper SSL certificates.
