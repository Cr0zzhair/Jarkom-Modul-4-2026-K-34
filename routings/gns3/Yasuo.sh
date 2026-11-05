#!/bin/sh
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr add 192.228.26.2/24 dev eth0   # A6: Navi > Switch8 > Yasuo, Miho, Kuma
ip link set eth0 up
ip route add default via 192.228.26.1
