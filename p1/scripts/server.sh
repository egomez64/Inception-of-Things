#!/bin/bash

set -euo pipefail

SERVER_IP="$1"

curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --node-ip=$SERVER_IP --flannel-iface=??? --write-kubeconfig-mode=644" sh -

mkdir -p /vagrant/confs

until [ -f "/var/lib/rancher/k3s/server/node-token" ]; do
	sleep 2
done

cp /var/lib/rancher/k3s/server/node-token /vagrant/confs
