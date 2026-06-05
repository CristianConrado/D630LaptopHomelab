## 1 Dockge
First we want to install Dockge to manage the rest of the containers we are going to have. For that we have the yaml file found in the /stacks/Dockge directory.
Info extracted directly from https://dockge.kuma.pet/
First we create a folder where we want to store our data, in my case it was /home/cristian/docker/dockge/data.

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
