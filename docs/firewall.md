This is my ufw firewall, its basic but I think it works.

I want to have all traffic incoming denied unless is from tailscale0, or just port 22 through wifi, but it will be through saved keys and i want the docker containers to talk between them.
I want all the traffic outgoing allowed.

```bash
sudo ufw default deny incoming
sudo ufw default allow outgoing

sudo ufw allow in on tailscale0

sudo ufw allow from 172.16.0.0/12

sudo ufw allow in on wlan0 to any port 22 proto tcp

sudo ufw enable
