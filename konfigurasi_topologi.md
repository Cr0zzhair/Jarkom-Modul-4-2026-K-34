# Kumpulan Script Konfigurasi Topologi GNS3

Dokumen ini berisi seluruh *script* konfigurasi IP, Routing Statis, DHCP, dan NAT untuk 13 Router dan 25 End Device/Host.

---

## 1. ROUTER (OS: debinet / bash)

### Cyberia
**Nama File:** `Cyberia.sh`
```bash
#!/bin/bash
sysctl -w net.ipv4.ip_forward=1
echo "nameserver 8.8.8.8" > /etc/resolv.conf

ip addr flush dev eth1
ip addr flush dev eth2

ip addr add 192.228.28.1/25 dev eth1
ip addr add 192.228.28.129/30 dev eth2
ip link set eth1 up
ip link set eth2 up

apt-get update
apt-get install -y isc-dhcp-client
dhclient eth0

ip route del 192.228.0.0/19 via 192.228.28.130 2>/dev/null
ip route add 192.228.0.0/19 via 192.228.28.130
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
```

### Wired
**Nama File:** `Wired.sh`
```bash
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
```

### Navi
**Nama File:** `Navi.sh`
```bash
#!/bin/bash
sysctl -w net.ipv4.ip_forward=1
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr add 192.228.28.134/30 dev eth0
ip addr add 192.228.24.1/24 dev eth1
ip addr add 192.228.25.1/26 dev eth2
ip addr add 192.228.26.1/24 dev eth3
ip link set eth0 up; ip link set eth1 up; ip link set eth2 up; ip link set eth3 up
ip route add default via 192.228.28.133
```

### Tachibana
**Nama File:** `Tachibana.sh`
```bash
#!/bin/bash
sysctl -w net.ipv4.ip_forward=1
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr add 192.228.28.138/30 dev eth0
ip addr add 192.228.20.1/23 dev eth1
ip addr add 192.228.22.1/30 dev eth2
ip link set eth0 up; ip link set eth1 up; ip link set eth2 up
ip route add default via 192.228.28.137
ip route add 192.228.16.0/22 via 192.228.22.2
```

### Deus
**Nama File:** `Deus.sh`
```bash
#!/bin/bash
sysctl -w net.ipv4.ip_forward=1
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr add 192.228.22.2/30 dev eth0
ip addr add 192.228.18.1/25 dev eth1
ip addr add 192.228.18.129/30 dev eth2
ip link set eth0 up; ip link set eth1 up; ip link set eth2 up
ip route add default via 192.228.22.1
ip route add 192.228.16.0/23 via 192.228.18.130
```

### Protocol7
**Nama File:** `Protocol7.sh`
```bash
#!/bin/bash
sysctl -w net.ipv4.ip_forward=1
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr add 192.228.18.130/30 dev eth0
ip addr add 192.228.17.1/26 dev eth1
ip addr add 192.228.17.65/30 dev eth2
ip link set eth0 up; ip link set eth1 up; ip link set eth2 up
ip route add default via 192.228.18.129
ip route add 192.228.16.0/24 via 192.228.17.66
```

### Knights
**Nama File:** `Knights.sh`
```bash
#!/bin/bash
sysctl -w net.ipv4.ip_forward=1
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr add 192.228.17.66/30 dev eth0
ip addr add 192.228.16.129/29 dev eth1
ip addr add 192.228.16.137/30 dev eth2
ip link set eth0 up; ip link set eth1 up; ip link set eth2 up
ip route add default via 192.228.17.65
ip route add 192.228.16.0/25 via 192.228.16.138
```

### Phantoma
**Nama File:** `Phantoma.sh`
```bash
#!/bin/bash
sysctl -w net.ipv4.ip_forward=1
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr add 192.228.16.138/30 dev eth0
ip addr add 192.228.16.65/27 dev eth1
ip addr add 192.228.16.97/30 dev eth2
ip link set eth0 up; ip link set eth1 up; ip link set eth2 up
ip route add default via 192.228.16.137
ip route add 192.228.16.0/26 via 192.228.16.98
```

### Shibuya
**Nama File:** `Shibuya.sh`
```bash
#!/bin/bash
sysctl -w net.ipv4.ip_forward=1
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr add 192.228.16.98/30 dev eth0
ip addr add 192.228.16.1/26 dev eth1
ip link set eth0 up; ip link set eth1 up
ip route add default via 192.228.16.97
```

### Psyche
**Nama File:** `Psyche.sh`
```bash
#!/bin/bash
sysctl -w net.ipv4.ip_forward=1
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr add 192.228.4.2/29 dev eth0
ip addr add 192.228.8.1/22 dev eth1
ip link set eth0 up; ip link set eth1 up
ip route add default via 192.228.4.1
```

### Copland
**Nama File:** `Copland.sh`
```bash
#!/bin/bash
sysctl -w net.ipv4.ip_forward=1
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr flush dev eth0
ip addr flush dev eth1
ip addr flush dev eth2
ip addr add 192.228.4.3/29 dev eth0
ip addr add 192.228.12.1/23 dev eth1
ip addr add 192.228.14.1/26 dev eth2
ip link set eth0 up; ip link set eth1 up; ip link set eth2 up
ip route add default via 192.228.4.1
```

### Schumann
**Nama File:** `Schumann.sh`
```bash
#!/bin/bash
sysctl -w net.ipv4.ip_forward=1
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr add 192.228.4.4/29 dev eth0
ip addr add 192.228.4.17/29 dev eth1
ip addr add 192.228.4.9/30 dev eth2
ip link set eth0 up; ip link set eth1 up; ip link set eth2 up
ip route add default via 192.228.4.1
ip route add 192.228.0.0/22 via 192.228.4.10
```

### Accela
**Nama File:** `Accela.sh`
```bash
#!/bin/bash
sysctl -w net.ipv4.ip_forward=1
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr add 192.228.4.10/30 dev eth0
ip addr add 192.228.0.1/22 dev eth1
ip link set eth0 up; ip link set eth1 up
ip route add default via 192.228.4.9
```

---

## 2. HOST / END DEVICE (OS: debinet / bash)

### Karl
**Nama File:** `Karl.sh`
```bash
#!/bin/bash
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr flush dev eth0
ip addr add 192.228.8.2/22 dev eth0
ip link set eth0 up
ip route add default via 192.228.8.1
```

### Lin
**Nama File:** `Lin.sh`
```bash
#!/bin/bash
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr flush dev eth0
ip addr add 192.228.8.3/22 dev eth0
ip link set eth0 up
ip route add default via 192.228.8.1
```

### Akashic
**Nama File:** `Akashic.sh`
```bash
#!/bin/bash
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr flush dev eth0
ip addr add 192.228.4.18/29 dev eth0
ip link set eth0 up
ip route add default via 192.228.4.17
```

### Eiri
**Nama File:** `Eiri.sh`
```bash
#!/bin/bash
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr flush dev eth0
ip addr add 192.228.16.130/29 dev eth0
ip link set eth0 up
ip route add default via 192.228.16.129
```

### Collective
**Nama File:** `Collective.sh`
```bash
#!/bin/bash
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr flush dev eth0
ip addr add 192.228.20.2/23 dev eth0
ip link set eth0 up
ip route add default via 192.228.20.1
```

### Kuma
**Nama File:** `Kuma.sh`
```bash
#!/bin/bash
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr flush dev eth0
ip addr add 192.228.26.4/24 dev eth0
ip link set eth0 up
ip route add default via 192.228.26.1
```

---

## 3. HOST / END DEVICE (OS: alpinet / sh)

### JJ
**Nama File:** `JJ.sh`
```sh
#!/bin/sh
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr add 192.228.28.2/25 dev eth0
ip link set eth0 up
ip route add default via 192.228.28.1
```

### MyuMyu
**Nama File:** `MyuMyu.sh`
```sh
#!/bin/sh
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr add 192.228.28.3/25 dev eth0
ip link set eth0 up
ip route add default via 192.228.28.1
```

### Juri
**Nama File:** `Juri.sh`
```sh
#!/bin/sh
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr add 192.228.14.2/26 dev eth0
ip link set eth0 up
ip route add default via 192.228.14.1
```

### Masayuki
**Nama File:** `Masayuki.sh`
```sh
#!/bin/sh
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr add 192.228.12.2/23 dev eth0
ip link set eth0 up
ip route add default via 192.228.12.1
```

### Omnipresence
**Nama File:** `Omnipresence.sh`
```sh
#!/bin/sh
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr add 192.228.0.2/22 dev eth0
ip link set eth0 up
ip route add default via 192.228.0.1
```

### Denpa
**Nama File:** `Denpa.sh`
```sh
#!/bin/sh
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr add 192.228.0.3/22 dev eth0
ip link set eth0 up
ip route add default via 192.228.0.1
```

### Alice
**Nama File:** `Alice.sh`
```sh
#!/bin/sh
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr add 192.228.24.2/24 dev eth0
ip link set eth0 up
ip route add default via 192.228.24.1
```

### Reika
**Nama File:** `Reika.sh`
```sh
#!/bin/sh
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr add 192.228.24.3/24 dev eth0
ip link set eth0 up
ip route add default via 192.228.24.1
```

### Taro
**Nama File:** `Taro.sh`
```sh
#!/bin/sh
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr add 192.228.25.2/26 dev eth0
ip link set eth0 up
ip route add default via 192.228.25.1
```

### Yasuo
**Nama File:** `Yasuo.sh`
```sh
#!/bin/sh
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr add 192.228.26.2/24 dev eth0
ip link set eth0 up
ip route add default via 192.228.26.1
```

### Miho
**Nama File:** `Miho.sh`
```sh
#!/bin/sh
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr add 192.228.26.3/24 dev eth0
ip link set eth0 up
ip route add default via 192.228.26.1
```

### Ghost
**Nama File:** `Ghost.sh`
```sh
#!/bin/sh
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr add 192.228.20.3/23 dev eth0
ip link set eth0 up
ip route add default via 192.228.20.1
```

### Lilith
**Nama File:** `Lilith.sh`
```sh
#!/bin/sh
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr add 192.228.18.2/25 dev eth0
ip link set eth0 up
ip route add default via 192.228.18.1
```

### Specter
**Nama File:** `Specter.sh`
```sh
#!/bin/sh
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr add 192.228.18.3/25 dev eth0
ip link set eth0 up
ip route add default via 192.228.18.1
```

### Chisa
**Nama File:** `Chisa.sh`
```sh
#!/bin/sh
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr add 192.228.17.2/26 dev eth0
ip link set eth0 up
ip route add default via 192.228.17.1
```

### Hodgeson
**Nama File:** `Hodgeson.sh`
```sh
#!/bin/sh
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr add 192.228.17.3/26 dev eth0
ip link set eth0 up
ip route add default via 192.228.17.1
```

### Semi
**Nama File:** `Semi.sh`
```sh
#!/bin/sh
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr add 192.228.16.66/27 dev eth0
ip link set eth0 up
ip route add default via 192.228.16.65
```

### Lain
**Nama File:** `Lain.sh`
```sh
#!/bin/sh
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr add 192.228.16.2/26 dev eth0
ip link set eth0 up
ip route add default via 192.228.16.1
```

### Mika
**Nama File:** `Mika.sh`
```sh
#!/bin/sh
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr add 192.228.16.3/26 dev eth0
ip link set eth0 up
ip route add default via 192.228.16.1
```