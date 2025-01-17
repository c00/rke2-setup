# Testing repo for setting up an rke2 cluster

The echo server exists just for testing. Apply it with:

```sh
kube apply -f resources
```

The ingress has a hostname `foo.local`, you can remove the hostname if you just want to test it ip-based.

But with the hostname, you can test it with curl:

```sh
# replace ip for your node ips.
curl --header "Host: foo.local" http://192.168.100.146 | jq
curl --header "Host: foo.local" http://192.168.100.189 | jq
```

To get the ip addresses of your nodes, you can do:

```sh
kube get nodes -o wide
```

# The .bashrc

In this repo there is a `.bashrc` file, and vscode will attempt to run that when opening a bash shell. I have multiple k8s configs, so this just sets the context correctly when opening a new terminal in vscode. Your mileage may vary.
