#!/bin/sh
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr add 192.228.14.2/26 dev eth0   # A12: Copland > Juri
ip link set eth0 up
ip route add default via 192.228.14.1
