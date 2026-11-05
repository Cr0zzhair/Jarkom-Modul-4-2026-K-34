#!/bin/bash
sysctl -w net.ipv4.ip_forward=1
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr flush dev eth0; ip addr flush dev eth1; ip addr flush dev eth2; ip addr flush dev eth3
ip addr add 192.228.28.130/30 dev eth0
ip addr add 192.228.4.1/29 dev eth1
ip addr add 192.228.28.137/30 dev eth2
ip addr add 192.228.28.133/30 dev eth3
ip link set eth0 up; ip link set eth1 up; ip link set eth2 up; ip link set eth3 up
ip route add default via 192.228.28.129
ip route add 192.228.24.0/22 via 192.228.28.134
ip route add 192.228.16.0/21 via 192.228.28.138
ip route add 192.228.8.0/22 via 192.228.4.2
ip route add 192.228.12.0/22 via 192.228.4.3
ip route add 192.228.0.0/21 via 192.228.4.4
