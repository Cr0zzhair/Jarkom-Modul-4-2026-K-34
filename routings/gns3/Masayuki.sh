#!/bin/sh
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr add 192.228.12.2/23 dev eth0   # A3: Copland > Switch4 > Masayuki
ip link set eth0 up
ip route add default via 192.228.12.1
