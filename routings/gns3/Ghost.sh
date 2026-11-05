#!/bin/sh
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr add 192.228.20.3/23 dev eth0   # A4: Tachibana > Switch9 > Collective, Ghost
ip link set eth0 up
ip route add default via 192.228.20.1
