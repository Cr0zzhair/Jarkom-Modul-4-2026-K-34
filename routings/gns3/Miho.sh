#!/bin/sh
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr add 192.228.26.3/24 dev eth0
ip link set eth0 up
ip route add default via 192.228.26.1
