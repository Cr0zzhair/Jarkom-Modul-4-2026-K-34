#!/bin/bash
sysctl -w net.ipv4.ip_forward=1
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr flush dev eth0
ip addr flush dev eth1
ip addr flush dev eth2
ip addr add 192.228.4.3/29 dev eth0
ip addr add 192.228.12.1/23 dev eth1
ip addr add 192.228.14.1/26 dev eth2
ip link set eth0 up; ip link set eth1 up; ip link set eth2 up
ip route add default via 192.228.4.1
