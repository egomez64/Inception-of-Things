#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(dirname "$0")"

k3d cluster create iot-cluster -p 8888:8888@loadbalancer
kubectl create namespace argocd
kubectl create namespace dev
kubectl apply -n argocd --server-side --force-conflicts -f https://raw.githubusercontent.com/argoproj/argo-cd/v3.5.6/manifests/install.yaml
kubectl wait --for=condition=Available deployment --all -n argocd --timeout=300s
kubectl apply -f "$SCRIPT_DIR/../confs/application.yaml"
echo "admin password :"
echo ""
kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath='{.data.password}' | base64 -d
