#!/bin/bash
sysctl -w net.ipv4.ip_forward=1
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr add 192.228.4.2/29 dev eth0
ip addr add 192.228.8.1/22 dev eth1
ip link set eth0 up; ip link set eth1 up
ip route add default via 192.228.4.1
