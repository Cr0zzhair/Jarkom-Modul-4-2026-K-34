#!/bin/sh
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr add 192.228.16.3/26 dev eth0   # A9: Shibuya > Switch13 > Lain, Mika
ip link set eth0 up
ip route add default via 192.228.16.1
