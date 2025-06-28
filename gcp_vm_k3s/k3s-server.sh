#!/bin/bash
set -e

echo "[+] Atualizando sistema..."
apt-get update -y
apt-get install -y curl jq

# Captura o IP público da VM
PUBLIC_IP=$(curl -s http://metadata.google.internal/computeMetadata/v1/instance/network-interfaces/0/access-configs/0/external-ip \
  -H "Metadata-Flavor: Google")

echo "[+] IP público detectado: $PUBLIC_IP"

echo "[+] Instalando K3s com Traefik habilitado..."
curl -sfL https://get.k3s.io | \
  INSTALL_K3S_EXEC="--disable servicelb,metrics-server \
  --node-external-ip $PUBLIC_IP \
  --bind-address 0.0.0.0 \
  --tls-san $PUBLIC_IP" \
  sh -

echo "[+] Aguardando K3s subir..."
sleep 10

echo "[+] Configurando kubeconfig com IP público..."
mkdir -p /root/.kube
cp /etc/rancher/k3s/k3s.yaml /root/.kube/config
chmod 600 /root/.kube/config
sed -i "s/127.0.0.1/$PUBLIC_IP/" /root/.kube/config

echo "[+] Salvando token para workers..."
cat /var/lib/rancher/k3s/server/node-token > /root/node-token

echo "[✓] K3s control-plane pronto em https://$PUBLIC_IP:6443 com Traefik"