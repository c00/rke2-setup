#!/bin/bash
source ~/.bashrc

kubectl config use-context rke2-local
kubectl version --client