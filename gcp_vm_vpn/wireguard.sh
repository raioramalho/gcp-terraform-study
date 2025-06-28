#!/bin/bash
set -e

# Instala o WireGuard
apt-get update && apt-get install -y wireguard

# Habilita o encaminhamento de IP (requisito para funcionar como gateway VPN)
sysctl -w net.ipv4.ip_forward=1
sed -i '/^#net.ipv4.ip_forward=1/c\net.ipv4.ip_forward=1' /etc/sysctl.conf

# Gera chaves privadas/públicas do servidor
umask 077
wg genkey | tee /etc/wireguard/server_private.key | wg pubkey > /etc/wireguard/server_public.key

SERVER_PRIVATE_KEY=$(cat /etc/wireguard/server_private.key)

# Cria o arquivo de configuração da interface wg0
cat > /etc/wireguard/wg0.conf <<EOF
[Interface]
Address = 10.8.0.1/24
ListenPort = 51820
PrivateKey = $SERVER_PRIVATE_KEY

# Adicione peers aqui manualmente
# [Peer]
# PublicKey = <peer_public_key>
# AllowedIPs = 10.8.0.2/32
EOF

# Ajusta permissões e inicia o serviço
chmod 600 /etc/wireguard/wg0.conf
systemctl enable wg-quick@wg0
systemctl start wg-quick@wg0

# Mostra IP público da VM e chave pública do servidor
echo "===================="
echo "WIREGUARD SERVER"
echo "Public IP: $(curl -s ifconfig.me)"
echo "Public Key: $(cat /etc/wireguard/server_public.key)"
echo "===================="
