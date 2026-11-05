#!/bin/bash
sysctl -w net.ipv4.ip_forward=1
echo "nameserver 8.8.8.8" > /etc/resolv.conf

ip addr flush dev eth0
ip addr flush dev eth1
ip addr flush dev eth2

ip addr add 192.228.17.66/30 dev eth0   # A23: Protocol7 > Knights
ip addr add 192.228.16.129/29 dev eth1   # A16: Knights > Eiri
ip addr add 192.228.16.137/30 dev eth2   # A24: Knights > Phantoma
ip link set eth0 up; ip link set eth1 up; ip link set eth2 up

ip route add default via 192.228.17.65
ip route add 192.228.16.0/25 via 192.228.16.138   # blok C3
