# Testing repo for setting up an rke2 cluster

This repo contains install scripts and some test resources.

## Create a new cluster and initialize the node with the control plane

```sh
sudo ./scripts/install-server.sh
```

After installation, test your connection on the server itself. Then copy the `~/.kube/config` file to your workstation, adjust the IP address inside, and confirm you can connect to your cluster from your workstation as well.

## Join a worker node

Make sure you have the server ip and node token from the first node. See the install node scripts for more details.

```sh
sudo ./scripts/install-node.sh
```

## Create test resources

echoserver just responds to http requests with some info about the pod / node / cluster it's running on. It's useful for testing.

Deploy it with:

```sh
kube apply -f resources/
```

The ingress has a hostname `foo.local` configured, you can remove the hostname if you just want to test it ip-based.

To get the ip addresses of your nodes, you can do:

```sh
kube get nodes -o wide
```

Test your echo service:

```sh
# replace ip for your node ips.
curl --header "Host: foo.local" http://192.168.100.146 | jq
curl --header "Host: foo.local" http://192.168.100.189 | jq
```

## The .bashrc

In this repo there is a `.bashrc` file, and vscode will attempt to run that when opening a bash shell. I have multiple k8s configs, so this just sets the context correctly when opening a new terminal in vscode. Your mileage may vary.
