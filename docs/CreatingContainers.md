## 1 Dockge
First we want to install Dockge to manage the rest of the containers we are going to have. For that we have the yaml file found in the /stacks/Dockge directory.
Info extracted directly from https://dockge.kuma.pet/
First we create a folder where we want to store our data, in my case it was /home/cristian/docker/dockge/data.
This is the most important container, that is why I write more info about what i did

```bash
# Create directories (requires sudo for /opt) and set permissions
sudo mkdir -p /opt/stacks /opt/dockge
sudo chown -R $USER:$USER /opt/stacks /opt/dockge
cd /opt/dockge

# Download your compose.yaml
curl "https://dockge.kuma.pet/compose.yaml?port=5001&stacksPath=%2Fopt%2Fstacks" --output compose.yaml

# Edit the file to change the data path (nano or vim)
vi compose.yml

# Start the Server
docker compose up -d

```
When you get in create an admin account
## 2 Tailscale & Caddy
This is the single most important service we need to connecto to the homelab from anywhere in the world. To deploy it we are going to look at the webpage https://tailscale.com/docs/install/linux and this video https://www.youtube.com/watch?v=YTjYXii4WzI&t
At this point I realised I should use the MagicDNS from tailscale to create SSL for my services, that is why I grouped both the caddy and tailscale compose into one.

## 3 Homepage
This is not what I originally had in mind, but I wanted to test the SSL certificates from caddy and this way i can have already set up homepage and I will have to go adding the services later on.
I just added the default yaml file from https://gethomepage.dev/installation/ and changed the allowed hosts to localhost, as the call is going to come from caddy.
and that made every call to my tailnet take me to my homepage service. REMEMBER TO CHANGE THE PORT AS PORT 3000 IS USED BY AdGuardHome.

## 4 AdGuard Home
For the final networking section, I want to pair the SSL from caddy with the tailnet from Tailscale, to have my homepage certified. That way i only need to be redirected from there. I am going to start from here: https://hub.docker.com/r/adguard/adguardhome. 

## 5 Beszel
Following the guide in the Beszel page, I first deployed the Beszel instance, and after that I got the Agent compose given to me and added it to my docker compose. It is a useful service for one Server, but i belive it shines at its brightest with more nodes.

## 6 UptimeKuma
After trying Beszel alone, it didnt give me a lot of info about the services, if they were up or down, it just said State = None. That is why I went back to the first version of this homelab and took the reliable Uptime Kuma and added it into the planning. And it was also really easy to set up, just went to https://uptimekuma.org/ and copied and tweaked the docker compose given. Then I added notifications.

## 7 Vikunja
I never thought about this, but after watching a video about it in TikTok (100% reliable source) I decided to give it a go, after seeing it supported SQLite, crucial for this hardware, and that it was an easy setup following the guide in https://vikunja.io/install/ where you are given, the commands for permissions, the compose and the caddy section, it was a piece of cake. Later I added, with the CalDAV token the calendar in my other devices so I have it all synced up, however it was not working propperly at least for my iPhone so I instead decided to go through the web service and save it as a web app.

## 8 n8n
Like I had in a previous homelab, I would like to have n8n running, in my case because I wanted to have my expenses sorted by just uploading a picture thanks to AI. 

## 9 VaultWarden
Finally I wanted to add a password manager, and with Vaultwarden i can have that locally, without any company having a copy or selling data about what passwords do i have saved.
