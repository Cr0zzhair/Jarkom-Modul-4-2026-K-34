#!/bin/bash
sysctl -w net.ipv4.ip_forward=1
echo "nameserver 8.8.8.8" > /etc/resolv.conf

ip addr flush dev eth1
ip addr flush dev eth2

ip addr add 192.228.28.1/25 dev eth1
ip addr add 192.228.28.129/30 dev eth2
ip link set eth1 up
ip link set eth2 up

apt-get update
apt-get install -y isc-dhcp-client
dhclient eth0

ip route del 192.228.0.0/19 via 192.228.28.130 2>/dev/null
ip route add 192.228.0.0/19 via 192.228.28.130
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
