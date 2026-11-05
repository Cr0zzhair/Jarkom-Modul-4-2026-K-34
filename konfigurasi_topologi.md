# Kumpulan Script Konfigurasi Topologi GNS3 (prefix 192.228.0.0/19)

Penomoran subnet (A1-A25) mengikuti tabel Rute terbaru (urut dari terbesar). Komentar `blok X` pada route merujuk
ke hasil penggabungan CIDR (B-I) di sheet Penggabungan. Alamat host/router tidak berubah dari konfigurasi sebelumnya.

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
```

### Wired
**Nama File:** `Wired.sh`
```bash
#!/bin/bash
sysctl -w net.ipv4.ip_forward=1
echo "nameserver 8.8.8.8" > /etc/resolv.conf

ip addr flush dev eth0
ip addr flush dev eth1
ip addr flush dev eth2
ip addr flush dev eth3

ip addr add 192.228.28.130/30 dev eth0   # A17: Cyberia > Wired
ip addr add 192.228.4.1/29 dev eth1   # A14: Wired > Switch2 > Psyche, Copland, Schumann
ip addr add 192.228.28.137/30 dev eth2   # A19: Wired > Tachibana
ip addr add 192.228.28.133/30 dev eth3   # A18: Wired > Navi
ip link set eth0 up; ip link set eth1 up; ip link set eth2 up; ip link set eth3 up

ip route add default via 192.228.28.129
ip route add 192.228.24.0/22 via 192.228.28.134   # blok C4
ip route add 192.228.16.0/21 via 192.228.28.138   # blok G1
ip route add 192.228.8.0/22 via 192.228.4.2   # blok A1
ip route add 192.228.12.0/22 via 192.228.4.3   # blok B2
ip route add 192.228.0.0/21 via 192.228.4.4   # blok D1
```

### Navi
**Nama File:** `Navi.sh`
```bash
#!/bin/bash
sysctl -w net.ipv4.ip_forward=1
echo "nameserver 8.8.8.8" > /etc/resolv.conf

ip addr flush dev eth0
ip addr flush dev eth1
ip addr flush dev eth2
ip addr flush dev eth3

ip addr add 192.228.28.134/30 dev eth0   # A18: Wired > Navi
ip addr add 192.228.24.1/24 dev eth1   # A5: Navi > Switch6 > Alice, Reika
ip addr add 192.228.25.1/26 dev eth2   # A10: Navi > Switch7 > Taro
ip addr add 192.228.26.1/24 dev eth3   # A6: Navi > Switch8 > Yasuo, Miho, Kuma
ip link set eth0 up; ip link set eth1 up; ip link set eth2 up; ip link set eth3 up

ip route add default via 192.228.28.133
```

### Tachibana
**Nama File:** `Tachibana.sh`
```bash
#!/bin/bash
sysctl -w net.ipv4.ip_forward=1
echo "nameserver 8.8.8.8" > /etc/resolv.conf

ip addr flush dev eth0
ip addr flush dev eth1
ip addr flush dev eth2

ip addr add 192.228.28.138/30 dev eth0   # A19: Wired > Tachibana
ip addr add 192.228.20.1/23 dev eth1   # A4: Tachibana > Switch9 > Collective, Ghost
ip addr add 192.228.22.1/30 dev eth2   # A21: Tachibana > Deus
ip link set eth0 up; ip link set eth1 up; ip link set eth2 up

ip route add default via 192.228.28.137
ip route add 192.228.16.0/22 via 192.228.22.2   # blok F1
```

### Deus
**Nama File:** `Deus.sh`
```bash
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
```

### Protocol7
**Nama File:** `Protocol7.sh`
```bash
#!/bin/bash
sysctl -w net.ipv4.ip_forward=1
echo "nameserver 8.8.8.8" > /etc/resolv.conf

ip addr flush dev eth0
ip addr flush dev eth1
ip addr flush dev eth2

ip addr add 192.228.18.130/30 dev eth0   # A22: Deus > Protocol7
ip addr add 192.228.17.1/26 dev eth1   # A11: Protocol7 > Switch11 > Chisa, Hodgson
ip addr add 192.228.17.65/30 dev eth2   # A23: Protocol7 > Knights
ip link set eth0 up; ip link set eth1 up; ip link set eth2 up

ip route add default via 192.228.18.129
ip route add 192.228.16.0/24 via 192.228.17.66   # blok D2
```

### Knights
**Nama File:** `Knights.sh`
```bash
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
```

### Phantoma
**Nama File:** `Phantoma.sh`
```bash
#!/bin/bash
sysctl -w net.ipv4.ip_forward=1
echo "nameserver 8.8.8.8" > /etc/resolv.conf

ip addr flush dev eth0
ip addr flush dev eth1
ip addr flush dev eth2

ip addr add 192.228.16.138/30 dev eth0   # A24: Knights > Phantoma
ip addr add 192.228.16.65/27 dev eth1   # A13: Phantoma > Switch12 > Semi
ip addr add 192.228.16.97/30 dev eth2   # A25: Phantoma > Shibuya
ip link set eth0 up; ip link set eth1 up; ip link set eth2 up

ip route add default via 192.228.16.137
ip route add 192.228.16.0/26 via 192.228.16.98   # blok A9
```

### Shibuya
**Nama File:** `Shibuya.sh`
```bash
#!/bin/bash
sysctl -w net.ipv4.ip_forward=1
echo "nameserver 8.8.8.8" > /etc/resolv.conf

ip addr flush dev eth0
ip addr flush dev eth1

ip addr add 192.228.16.98/30 dev eth0   # A25: Phantoma > Shibuya
ip addr add 192.228.16.1/26 dev eth1   # A9: Shibuya > Switch13 > Lain, Mika
ip link set eth0 up; ip link set eth1 up

ip route add default via 192.228.16.97
```

### Psyche
**Nama File:** `Psyche.sh`
```bash
#!/bin/bash
sysctl -w net.ipv4.ip_forward=1
echo "nameserver 8.8.8.8" > /etc/resolv.conf

ip addr flush dev eth0
ip addr flush dev eth1

ip addr add 192.228.4.2/29 dev eth0   # A14: Wired > Switch2 > Psyche, Copland, Schumann
ip addr add 192.228.8.1/22 dev eth1   # A1: Psyche > Switch3 > Karl, Lin
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

ip addr add 192.228.4.3/29 dev eth0   # A14: Wired > Switch2 > Psyche, Copland, Schumann
ip addr add 192.228.12.1/23 dev eth1   # A3: Copland > Switch4 > Masayuki
ip addr add 192.228.14.1/26 dev eth2   # A12: Copland > Juri
ip link set eth0 up; ip link set eth1 up; ip link set eth2 up

ip route add default via 192.228.4.1
```

### Schumann
**Nama File:** `Schumann.sh`
```bash
#!/bin/bash
sysctl -w net.ipv4.ip_forward=1
echo "nameserver 8.8.8.8" > /etc/resolv.conf

ip addr flush dev eth0
ip addr flush dev eth1
ip addr flush dev eth2

ip addr add 192.228.4.4/29 dev eth0   # A14: Wired > Switch2 > Psyche, Copland, Schumann
ip addr add 192.228.4.17/29 dev eth1   # A15: Schumann > Akashic
ip addr add 192.228.4.9/30 dev eth2   # A20: Schumann > Accela
ip link set eth0 up; ip link set eth1 up; ip link set eth2 up

ip route add default via 192.228.4.1
ip route add 192.228.0.0/22 via 192.228.4.10   # blok A2
```

### Accela
**Nama File:** `Accela.sh`
```bash
#!/bin/bash
sysctl -w net.ipv4.ip_forward=1
echo "nameserver 8.8.8.8" > /etc/resolv.conf

ip addr flush dev eth0
ip addr flush dev eth1

ip addr add 192.228.4.10/30 dev eth0   # A20: Schumann > Accela
ip addr add 192.228.0.1/22 dev eth1   # A2: Accela > Switch5 > Omnipresence, Denpa
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
ip addr add 192.228.8.2/22 dev eth0   # A1: Psyche > Switch3 > Karl, Lin
ip link set eth0 up
ip route add default via 192.228.8.1
```

### Lin
**Nama File:** `Lin.sh`
```bash
#!/bin/bash
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr flush dev eth0
ip addr add 192.228.8.3/22 dev eth0   # A1: Psyche > Switch3 > Karl, Lin
ip link set eth0 up
ip route add default via 192.228.8.1
```

### Akashic
**Nama File:** `Akashic.sh`
```bash
#!/bin/bash
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr flush dev eth0
ip addr add 192.228.4.18/29 dev eth0   # A15: Schumann > Akashic
ip link set eth0 up
ip route add default via 192.228.4.17
```

### Eiri
**Nama File:** `Eiri.sh`
```bash
#!/bin/bash
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr flush dev eth0
ip addr add 192.228.16.130/29 dev eth0   # A16: Knights > Eiri
ip link set eth0 up
ip route add default via 192.228.16.129
```

### Collective
**Nama File:** `Collective.sh`
```bash
#!/bin/bash
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr flush dev eth0
ip addr add 192.228.20.2/23 dev eth0   # A4: Tachibana > Switch9 > Collective, Ghost
ip link set eth0 up
ip route add default via 192.228.20.1
```

### Kuma
**Nama File:** `Kuma.sh`
```bash
#!/bin/bash
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr flush dev eth0
ip addr add 192.228.26.4/24 dev eth0   # A6: Navi > Switch8 > Yasuo, Miho, Kuma
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
ip addr add 192.228.28.2/25 dev eth0   # A7: Cyberia > Switch1 > JJ, MyuMyu
ip link set eth0 up
ip route add default via 192.228.28.1
```

### MyuMyu
**Nama File:** `MyuMyu.sh`
```sh
#!/bin/sh
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr add 192.228.28.3/25 dev eth0   # A7: Cyberia > Switch1 > JJ, MyuMyu
ip link set eth0 up
ip route add default via 192.228.28.1
```

### Juri
**Nama File:** `Juri.sh`
```sh
#!/bin/sh
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr add 192.228.14.2/26 dev eth0   # A12: Copland > Juri
ip link set eth0 up
ip route add default via 192.228.14.1
```

### Masayuki
**Nama File:** `Masayuki.sh`
```sh
#!/bin/sh
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr add 192.228.12.2/23 dev eth0   # A3: Copland > Switch4 > Masayuki
ip link set eth0 up
ip route add default via 192.228.12.1
```

### Omnipresence
**Nama File:** `Omnipresence.sh`
```sh
#!/bin/sh
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr add 192.228.0.2/22 dev eth0   # A2: Accela > Switch5 > Omnipresence, Denpa
ip link set eth0 up
ip route add default via 192.228.0.1
```

### Denpa
**Nama File:** `Denpa.sh`
```sh
#!/bin/sh
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr add 192.228.0.3/22 dev eth0   # A2: Accela > Switch5 > Omnipresence, Denpa
ip link set eth0 up
ip route add default via 192.228.0.1
```

### Alice
**Nama File:** `Alice.sh`
```sh
#!/bin/sh
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr add 192.228.24.2/24 dev eth0   # A5: Navi > Switch6 > Alice, Reika
ip link set eth0 up
ip route add default via 192.228.24.1
```

### Reika
**Nama File:** `Reika.sh`
```sh
#!/bin/sh
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr add 192.228.24.3/24 dev eth0   # A5: Navi > Switch6 > Alice, Reika
ip link set eth0 up
ip route add default via 192.228.24.1
```

### Taro
**Nama File:** `Taro.sh`
```sh
#!/bin/sh
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr add 192.228.25.2/26 dev eth0   # A10: Navi > Switch7 > Taro
ip link set eth0 up
ip route add default via 192.228.25.1
```

### Yasuo
**Nama File:** `Yasuo.sh`
```sh
#!/bin/sh
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr add 192.228.26.2/24 dev eth0   # A6: Navi > Switch8 > Yasuo, Miho, Kuma
ip link set eth0 up
ip route add default via 192.228.26.1
```

### Miho
**Nama File:** `Miho.sh`
```sh
#!/bin/sh
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr add 192.228.26.3/24 dev eth0   # A6: Navi > Switch8 > Yasuo, Miho, Kuma
ip link set eth0 up
ip route add default via 192.228.26.1
```

### Ghost
**Nama File:** `Ghost.sh`
```sh
#!/bin/sh
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr add 192.228.20.3/23 dev eth0   # A4: Tachibana > Switch9 > Collective, Ghost
ip link set eth0 up
ip route add default via 192.228.20.1
```

### Lilith
**Nama File:** `Lilith.sh`
```sh
#!/bin/sh
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr add 192.228.18.2/25 dev eth0   # A8: Deus > Switch10 > Lilith, Specter
ip link set eth0 up
ip route add default via 192.228.18.1
```

### Specter
**Nama File:** `Specter.sh`
```sh
#!/bin/sh
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr add 192.228.18.3/25 dev eth0   # A8: Deus > Switch10 > Lilith, Specter
ip link set eth0 up
ip route add default via 192.228.18.1
```

### Chisa
**Nama File:** `Chisa.sh`
```sh
#!/bin/sh
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr add 192.228.17.2/26 dev eth0   # A11: Protocol7 > Switch11 > Chisa, Hodgson
ip link set eth0 up
ip route add default via 192.228.17.1
```

### Hodgeson
**Nama File:** `Hodgeson.sh`
```sh
#!/bin/sh
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr add 192.228.17.3/26 dev eth0   # A11: Protocol7 > Switch11 > Chisa, Hodgson
ip link set eth0 up
ip route add default via 192.228.17.1
```

### Semi
**Nama File:** `Semi.sh`
```sh
#!/bin/sh
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr add 192.228.16.66/27 dev eth0   # A13: Phantoma > Switch12 > Semi
ip link set eth0 up
ip route add default via 192.228.16.65
```

### Lain
**Nama File:** `Lain.sh`
```sh
#!/bin/sh
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr add 192.228.16.2/26 dev eth0   # A9: Shibuya > Switch13 > Lain, Mika
ip link set eth0 up
ip route add default via 192.228.16.1
```

### Mika
**Nama File:** `Mika.sh`
```sh
#!/bin/sh
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip addr add 192.228.16.3/26 dev eth0   # A9: Shibuya > Switch13 > Lain, Mika
ip link set eth0 up
ip route add default via 192.228.16.1
```
