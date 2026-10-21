#!/bin/bash

set -euo pipefail

k3d cluster create iot-cluster -p 8888:8888@loadbalancer
kubectl create namespace argocd
kubectl create namespace dev
kubectl apply -n argocd --server-side --force-conflicts -f https://raw.githubusercontent.com/argoproj/argo-cd/v3.5.6/manifests/install.yaml

