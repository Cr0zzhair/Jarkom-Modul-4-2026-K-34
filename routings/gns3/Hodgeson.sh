#!/bin/sh
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr add 192.228.17.3/26 dev eth0   # A11: Protocol7 > Switch11 > Chisa, Hodgson
ip link set eth0 up
ip route add default via 192.228.17.1
