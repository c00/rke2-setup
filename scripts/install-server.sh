#!/bin/sh

# run as root
if [ "$(id -u)" -ne 0 ]; then echo "Please run as root"; exit 1; fi

# install curl
echo Installing curl...
apt update && apt install curl -y

# install rke2 
echo Installing RKE2 server...
curl -sfL https://get.rke2.io | sh -

# enable rke2 on startup
systemctl enable rke2-server.service

# start rke2
# Note: Starting the service for the first time will download the container images, this may take some time. If this fails, a restart of the server may be helpful.
#       Also, we may want to find some settings to load the images from alternative sources due to network restrictions.
echo Starting RKE2 for the first time. This may take a few minutes...
systemctl start rke2-server.service
echo Service started!
echo
echo "Installation complete. To make life easy for yourself:"
echo
echo "1. Add the rke2 bin folder to your path (this has the kubectl command) with the following command:"
echo
echo "echo 'export PATH=\"\$PATH:/var/lib/rancher/rke2/bin\"' >> ~/.bashrc"
echo
echo "2. Set the kube config"
echo "mkdir ~/.kube && sudo cp /etc/rancher/rke2/rke2.yaml ~/.kube/config && sudo chown -R \$(whoami):\$(whoami) ~/.kube/config"
echo
echo "3. optionally create a kube alias to kubectl:"
echo "echo 'alias kube=kubectl' >> ~/.bashrc"
echo
echo "To check your configuration use: kubectl version"
echo
echo "The server token to add nodes to the cluster can be found at /var/lib/rancher/rke2/server/node-token"
echo