#!/bin/bash
sysctl -w net.ipv4.ip_forward=1
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr add 192.228.28.134/30 dev eth0
ip addr add 192.228.24.1/24 dev eth1
ip addr add 192.228.25.1/26 dev eth2
ip addr add 192.228.26.1/24 dev eth3
ip link set eth0 up; ip link set eth1 up; ip link set eth2 up; ip link set eth3 up
ip route add default via 192.228.28.133
