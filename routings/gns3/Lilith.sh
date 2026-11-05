#!/bin/sh
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr add 192.228.18.2/25 dev eth0   # A8: Deus > Switch10 > Lilith, Specter
ip link set eth0 up
ip route add default via 192.228.18.1
