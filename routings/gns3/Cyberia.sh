#!/bin/bash
sysctl -w net.ipv4.ip_forward=1
echo "nameserver 8.8.8.8" > /etc/resolv.conf

ip addr flush dev eth1
ip addr flush dev eth2

ip addr add 192.228.28.1/25 dev eth1   # A7: Cyberia > Switch1 > JJ, MyuMyu
ip addr add 192.228.28.129/30 dev eth2   # A17: Cyberia > Wired
ip link set eth1 up; ip link set eth2 up

# internet lewat NAT1 (eth0): DHCP dulu, baru apt
ip link set eth0 up
if command -v dhclient >/dev/null 2>&1; then dhclient eth0; elif command -v udhcpc >/dev/null 2>&1; then udhcpc -i eth0 -q; else ip addr add 192.168.122.250/24 dev eth0; ip route add default via 192.168.122.1; fi
sleep 3
if timeout 4 bash -c '>/dev/tcp/8.8.8.8/53' 2>/dev/null; then command -v iptables >/dev/null 2>&1 || { apt-get update; apt-get install -y iptables; }; else echo '[!] eth0 (NAT1) belum punya internet - cek kabel NAT1 / DHCP'; fi

ip route add 192.228.0.0/19 via 192.228.28.130   # blok I1
iptables -t nat -C POSTROUTING -o eth0 -j MASQUERADE 2>/dev/null || iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
