#!/bin/bash
apt-get update
apt-get install -y openvpn easy-rsa

make-cadir /etc/openvpn/easy-rsa
cd /etc/openvpn/easy-rsa

./easyrsa init-pki
echo | ./easyrsa build-ca nopass
./easyrsa gen-req server nopass
./easyrsa sign-req server server

./easyrsa gen-dh
openvpn --genkey --secret ta.key

cp pki/ca.crt pki/private/server.key pki/issued/server.crt /etc/openvpn
cp ta.key /etc/openvpn
cp pki/dh.pem /etc/openvpn/dh.pem

# Cria conf do servidor
cat > /etc/openvpn/server.conf <<EOF
port 1194
proto udp
dev tun
ca ca.crt
cert server.crt
key server.key
dh dh.pem
keepalive 10 120
persist-key
persist-tun
status openvpn-status.log
verb 3
EOF

systemctl enable openvpn@server
systemctl start openvpn@server
