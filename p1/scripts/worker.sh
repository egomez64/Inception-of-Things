#!/bin/bash

set -euo pipefail

SERVER_IP="$1"
WORKER_IP="$2"
IFACE=$(ip -o -4 addr show | awk -v ip="$WORKER_IP" '$0 ~ ip {print $2}')

until [ -f "/vagrant/confs/node-token" ]; do
	sleep 2
done

curl -sfL https://get.k3s.io | \
	INSTALL_K3S_EXEC="agent --node-ip=$WORKER_IP --flannel-iface=$IFACE" \
	K3S_TOKEN="$(cat /vagrant/confs/node-token)" \
	K3S_URL="https://$SERVER_IP:6443" sh -
