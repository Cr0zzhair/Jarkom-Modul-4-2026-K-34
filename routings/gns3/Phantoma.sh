#!/bin/bash
sysctl -w net.ipv4.ip_forward=1
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr add 192.228.16.138/30 dev eth0
ip addr add 192.228.16.65/27 dev eth1
ip addr add 192.228.16.97/30 dev eth2
ip link set eth0 up; ip link set eth1 up; ip link set eth2 up
ip route add default via 192.228.16.137
ip route add 192.228.16.0/26 via 192.228.16.98
