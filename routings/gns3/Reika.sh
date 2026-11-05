#!/bin/sh
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr add 192.228.24.3/24 dev eth0   # A5: Navi > Switch6 > Alice, Reika
ip link set eth0 up
ip route add default via 192.228.24.1
