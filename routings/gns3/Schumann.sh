#!/bin/bash
sysctl -w net.ipv4.ip_forward=1
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr add 192.228.4.4/29 dev eth0
ip addr add 192.228.4.17/29 dev eth1
ip addr add 192.228.4.9/30 dev eth2
ip link set eth0 up; ip link set eth1 up; ip link set eth2 up
ip route add default via 192.228.4.1
ip route add 192.228.0.0/22 via 192.228.4.10
