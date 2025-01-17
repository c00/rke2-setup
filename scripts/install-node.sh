#!/bin/sh

# This script expects 2 environment variables:
# SERVER_ADDRESS: The IP or dns name of the rke2 server node
# SERVER_TOKEN: The server token, found on the rke2 server node at /var/lib/rancher/rke2/server/node-token
# Alternatively, uncomment them below

#SERVER_ADDRESS=10.0.0.1
#SERVER_TOKEN=K109a2...dbda28db2

# run as root
if [ "$(id -u)" -ne 0 ]; then echo "Please run as root"; exit 1; fi

# Check if server address and token are set
if [ -z "${SERVER_ADDRESS+x}" ]; then echo "SERVER_ADDRESS is not set. Exiting."; exit 1; fi
if [ -z "${SERVER_TOKEN+x}" ]; then echo "SERVER_TOKEN is not set. Exiting. "; exit 1; fi

# install curl
echo Installing curl...
apt update && apt install curl -y

# install rke2 
echo Installing RKE2 agent...
curl -sfL https://get.rke2.io | INSTALL_RKE2_TYPE="agent" sh -

# enable rke2 on startup
systemctl enable rke2-agent.service

mkdir -p /etc/rancher/rke2/
touch /etc/rancher/rke2/config.yaml

echo "server: https://$SERVER_ADDRESS:9345" >> /etc/rancher/rke2/config.yaml
echo "token: $SERVER_TOKEN" >> /etc/rancher/rke2/config.yaml

# start rke2
# Note: Starting the service for the first time will download the container images, this may take some time. If this fails, a restart of the server may be helpful.
#       Also, we may want to find some settings to load the images from alternative sources due to network restrictions.
echo Starting RKE2 for the first time. This may take a few minutes...
systemctl start rke2-agent.service
echo Service started!
echo
echo "Installation complete. Using \`kubectl get nodes\` you should see this node. It may take a few minutes to become ready."