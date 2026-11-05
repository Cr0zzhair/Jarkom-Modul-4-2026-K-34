#!/bin/bash
sysctl -w net.ipv4.ip_forward=1
echo "nameserver 8.8.8.8" > /etc/resolv.conf

ip addr flush dev eth0
ip addr flush dev eth1
ip addr flush dev eth2

ip addr add 192.228.22.2/30 dev eth0   # A21: Tachibana > Deus
ip addr add 192.228.18.1/25 dev eth1   # A8: Deus > Switch10 > Lilith, Specter
ip addr add 192.228.18.129/30 dev eth2   # A22: Deus > Protocol7
ip link set eth0 up; ip link set eth1 up; ip link set eth2 up

ip route add default via 192.228.22.1
ip route add 192.228.16.0/23 via 192.228.18.130   # blok E2
