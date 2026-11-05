#!/bin/bash
sysctl -w net.ipv4.ip_forward=1
echo "nameserver 8.8.8.8" > /etc/resolv.conf

ip addr flush dev eth0
ip addr flush dev eth1

ip addr add 192.228.16.98/30 dev eth0   # A25: Phantoma > Shibuya
ip addr add 192.228.16.1/26 dev eth1   # A9: Shibuya > Switch13 > Lain, Mika
ip link set eth0 up; ip link set eth1 up

ip route add default via 192.228.16.97
