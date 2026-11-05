#!/bin/bash
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr flush dev eth0
ip addr add 192.228.16.130/29 dev eth0   # A16: Knights > Eiri
ip link set eth0 up
ip route add default via 192.228.16.129
