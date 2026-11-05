#!/bin/sh
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr add 192.228.28.3/25 dev eth0   # A7: Cyberia > Switch1 > JJ, MyuMyu
ip link set eth0 up
ip route add default via 192.228.28.1
