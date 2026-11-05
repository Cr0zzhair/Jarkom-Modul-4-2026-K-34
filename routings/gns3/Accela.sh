#!/bin/bash
sysctl -w net.ipv4.ip_forward=1
echo "nameserver 8.8.8.8" > /etc/resolv.conf

ip addr flush dev eth0
ip addr flush dev eth1

ip addr add 192.228.4.10/30 dev eth0   # A20: Schumann > Accela
ip addr add 192.228.0.1/22 dev eth1   # A2: Accela > Switch5 > Omnipresence, Denpa
ip link set eth0 up; ip link set eth1 up

ip route add default via 192.228.4.9
