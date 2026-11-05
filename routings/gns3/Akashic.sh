#!/bin/bash
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr flush dev eth0
ip addr add 192.228.4.18/29 dev eth0   # A15: Schumann > Akashic
ip link set eth0 up
ip route add default via 192.228.4.17
