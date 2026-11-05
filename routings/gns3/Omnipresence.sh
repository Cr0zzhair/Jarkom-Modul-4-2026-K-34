#!/bin/sh
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr add 192.228.0.2/22 dev eth0   # A2: Accela > Switch5 > Omnipresence, Denpa
ip link set eth0 up
ip route add default via 192.228.0.1
