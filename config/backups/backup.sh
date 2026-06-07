#I want to back up the data of docker images, that is why i saved them all under ~/docker/ so backing them up is easier. I am also backing up the stacks as it makes it easier to rebuild the homelab I belive.
#In this version i dont have this automated to be sent, I will do it later
#!/bin/bash

set -euo pipefail

BACKUP_DIR="/tmp/homelab_backups"
DATE=$(date +%F-%H%M)
HOST=$(hostname)
ARCHIVE="${BACKUP_DIR}/${HOST}-${DATE}.tar.zst"

mkdir -p "$BACKUP_DIR"

echo "[$(date)] Creating archive..."

sudo tar \
  --exclude='*/cache' \
  --exclude='*/Cache' \
  --exclude='*/tmp' \
  --exclude='*/temp' \
  --exclude='*/transcode' \
  --exclude='*/transcodes' \
  --exclude='*/logs' \
  --zstd \
  -cf "$ARCHIVE" \
  /home/cristian/docker/ \
  /opt/stacks/

echo "[$(date)] Backup complete."



