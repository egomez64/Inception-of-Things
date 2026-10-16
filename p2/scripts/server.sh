#!/bin/bash

set -euo pipefail

SERVER_IP="$1"
IFACE=$(ip -o -4 addr show | awk -v ip="$SERVER_IP" '$0 ~ ip {print $2}')

curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --node-ip=$SERVER_IP --flannel-iface=$IFACE --write-kubeconfig-mode=644" sh -

until kubectl version > /dev/null 2>&1; do
	sleep 2
done

kubectl apply -f /vagrant/confs
