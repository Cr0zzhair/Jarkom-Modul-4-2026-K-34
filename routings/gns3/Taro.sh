#!/bin/sh
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr add 192.228.25.2/26 dev eth0   # A10: Navi > Switch7 > Taro
ip link set eth0 up
ip route add default via 192.228.25.1
