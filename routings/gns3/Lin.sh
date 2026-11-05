#!/bin/bash
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr flush dev eth0
ip addr add 192.228.8.3/22 dev eth0   # A1: Psyche > Switch3 > Karl, Lin
ip link set eth0 up
ip route add default via 192.228.8.1
