# PRAKTIKUM JARKOM MODUL 4 KELOMPOK K-34 - 2026

## Anggota Kelompok

| No | Nama | NRP |
| :---: | :--- | :--- |
| 1 | Muhammad Syadzili Abdul Muhyi | 5027251030 |
| 2 | Bambang Nasarillah Kurniawan | 5027251110 |

## Dokumen & File Praktikum

- **File CPT**: [`K-34-CPT-VLSM-.pkt`](./K-34-CPT-VLSM-.pkt)
- **Spreadsheet Perhitungan CIDR & VLSM**: [`Spreadsheet Modul 4 Komdat Jarkom 2026 K34.xlsx`](./Spreadsheet%20Modul%204%20Komdat%20Jarkom%202026%20K34.xlsx)
- **Script Modular Node**: [`routings/gns3/`](./routings/gns3/)

---

### Bagian I: Cisco Packet Tracer (CPT) - VLSM

Pada bagian simulasi Cisco Packet Tracer diterapkan metode **VLSM (Variable Length Subnet Mask)**. Seluruh skema pengalamatan, konfigurasi interface router Cisco, switch, serta host PC telah diimplementasikan pada file project [`K-34-CPT-VLSM-.pkt`](./K-34-CPT-VLSM-.pkt).

Perhitungan rinci kebutuhan IP, netmask VLSM per subnet, range usable IP, serta pengujian konektivitas antarnode tercantum dalam spreadsheet pada sheet **"Pembagian IP - VLSM"**.

---

### Bagian II: GNS3 - CIDR ("The Wired Expansion")

Pada topologi GNS3 diterapkan metode **CIDR (Classless Inter-Domain Routing)** dengan prefix kelompok **`192.228.x.x`** dan Root Supernet **`192.228.0.0/19`**. Fokus utama implementasi CIDR adalah alokasi alamat efisien, perataan boundary subnet, dan hierarki agregasi rute (*route summarization*) tanpa adanya overlap antarsubnet.

---

### 1. Topologi Jaringan GNS3

Topologi "The Wired Expansion" terdiri dari **13 Router, 13 Switch, dan 25 Host / End Device** (total 38 perangkat aktif). Jaringan berpusat pada Router Gateway **`Cyberia`** dan Router Backbone **`Wired`**, yang kemudian bercabang ke tiga sayap utama:

![Topologi Jaringan GNS3](assets/Topologi_GNS3.png)

- **Gateway Internet & LAN Atas**:
  - **`Cyberia`**: Terhubung ke `NAT1` (akses WAN internet) melalui `eth0`, ke LAN client (`JJ`, `MyuMyu` via `Switch1`), dan ke backbone **`Wired`**.
- **Backbone Router**:
  - **`Wired`**: Berperan sebagai pusat transit trafik antarsayap dan default gateway internal ke arah Cyberia.
- **Sayap Kiri (Multi-access Switch2)**:
  - Hub `Switch2` menghubungkan **`Wired`**, **`Psyche`**, **`Copland`**, dan **`Schumann`**.
  - **`Psyche`** membawahi `Switch3` (`Karl` dan `Lin` — blok terbesar 881 IP, Subnet A1).
  - **`Copland`** membawahi `Switch4` (`Masayuki` — 301 IP, Subnet A3) serta direct link ke host **`Juri`** (32 IP, Subnet A12).
  - **`Schumann`** membawahi direct host **`Akashic`** (4 IP, Subnet A15) dan Router **`Accela`** (`Switch5` -> `Omnipresence` dan `Denpa` — 514 IP, Subnet A2).
- **Sayap Kanan (Router Navi)**:
  - **`Navi`** membawahi 3 subnet LAN: `Switch6` (`Alice`, `Reika` — Subnet A5), `Switch7` (`Taro` — Subnet A10), dan `Switch8` (`Yasuo`, `Miho`, `Kuma` — Subnet A6).
- **Sayap Bawah (Rantai Router Tachibana s/d Shibuya)**:
  - Rantai serial 6 router: **`Tachibana`** $	o$ **`Deus`** $	o$ **`Protocol7`** $	o$ **`Knights`** $	o$ **`Phantoma`** $	o$ **`Shibuya`**.
  - Setiap router memiliki segmen LAN masing-masing (`Switch9` s/d `Switch13` serta server direct `Eiri` pada Knights).

---

### 2. Tabel Pembagian IP (CIDR Subnetting Table)

Berdasarkan sheet **"Rute"** dan **"Pembagian IP - CIDR"** terbaru, total kebutuhan pengalamatan The Wired adalah **2814 IP**. Subnet diurutkan dari kebutuhan IP terbesar ke terkecil (**A1 - A25**) dengan alokasi prefix dasar **`192.228.x.x`**:

| Subnet | Jalur / Rute | Kebutuhan IP | Netmask | Network ID | Range Usable IP | Broadcast |
| :---: | :--- | :---: | :---: | :---: | :---: | :---: |
| **A1** | Psyche > Switch3 > Karl, Lin | 881 | `/22` (`255.255.252.0`) | `192.228.8.0` | `192.228.8.1 - 192.228.11.254` | `192.228.11.255` |
| **A2** | Accela > Switch5 > Omnipresence, Denpa | 514 | `/22` (`255.255.252.0`) | `192.228.0.0` | `192.228.0.1 - 192.228.3.254` | `192.228.3.255` |
| **A3** | Copland > Switch4 > Masayuki | 301 | `/23` (`255.255.254.0`) | `192.228.12.0` | `192.228.12.1 - 192.228.13.254` | `192.228.13.255` |
| **A4** | Tachibana > Switch9 > Collective, Ghost | 267 | `/23` (`255.255.254.0`) | `192.228.20.0` | `192.228.20.1 - 192.228.21.254` | `192.228.21.255` |
| **A5** | Navi > Switch6 > Alice, Reika | 254 | `/24` (`255.255.255.0`) | `192.228.24.0` | `192.228.24.1 - 192.228.24.254` | `192.228.24.255` |
| **A6** | Navi > Switch8 > Yasuo, Miho, Kuma | 143 | `/24` (`255.255.255.0`) | `192.228.26.0` | `192.228.26.1 - 192.228.26.254` | `192.228.26.255` |
| **A7** | Cyberia > Switch1 > JJ, MyuMyu | 126 | `/25` (`255.255.255.128`) | `192.228.28.0` | `192.228.28.1 - 192.228.28.126` | `192.228.28.127` |
| **A8** | Deus > Switch10 > Lilith, Specter | 99 | `/25` (`255.255.255.128`) | `192.228.18.0` | `192.228.18.1 - 192.228.18.126` | `192.228.18.127` |
| **A9** | Shibuya > Switch13 > Lain, Mika | 62 | `/26` (`255.255.255.192`) | `192.228.16.0` | `192.228.16.1 - 192.228.16.62` | `192.228.16.63` |
| **A10** | Navi > Switch7 > Taro | 58 | `/26` (`255.255.255.192`) | `192.228.25.0` | `192.228.25.1 - 192.228.25.62` | `192.228.25.63` |
| **A11** | Protocol7 > Switch11 > Chisa, Hodgson | 33 | `/26` (`255.255.255.192`) | `192.228.17.0` | `192.228.17.1 - 192.228.17.62` | `192.228.17.63` |
| **A12** | Copland > Juri (Direct) | 32 | `/26` (`255.255.255.192`) | `192.228.14.0` | `192.228.14.1 - 192.228.14.62` | `192.228.14.63` |
| **A13** | Phantoma > Switch12 > Semi | 15 | `/27` (`255.255.255.224`) | `192.228.16.64` | `192.228.16.65 - 192.228.16.94` | `192.228.16.95` |
| **A14** | Wired > Switch2 > Psyche, Copland, Schumann | 4 | `/29` (`255.255.255.248`) | `192.228.4.0` | `192.228.4.1 - 192.228.4.6` | `192.228.4.7` |
| **A15** | Schumann > Akashic (Direct) | 4 | `/29` (`255.255.255.248`) | `192.228.4.16` | `192.228.4.17 - 192.228.4.22` | `192.228.4.23` |
| **A16** | Knights > Eiri (Direct) | 3 | `/29` (`255.255.255.248`) | `192.228.16.128` | `192.228.16.129 - 192.228.16.134` | `192.228.16.135` |
| **A17** | Cyberia > Wired | 2 | `/30` (`255.255.255.252`) | `192.228.28.128` | `192.228.28.129 - 192.228.28.130` | `192.228.28.131` |
| **A18** | Wired > Navi | 2 | `/30` (`255.255.255.252`) | `192.228.28.132` | `192.228.28.133 - 192.228.28.134` | `192.228.28.135` |
| **A19** | Wired > Tachibana | 2 | `/30` (`255.255.255.252`) | `192.228.28.136` | `192.228.28.137 - 192.228.28.138` | `192.228.28.139` |
| **A20** | Schumann > Accela | 2 | `/30` (`255.255.255.252`) | `192.228.4.8` | `192.228.4.9 - 192.228.4.10` | `192.228.4.11` |
| **A21** | Tachibana > Deus | 2 | `/30` (`255.255.255.252`) | `192.228.22.0` | `192.228.22.1 - 192.228.22.2` | `192.228.22.3` |
| **A22** | Deus > Protocol7 | 2 | `/30` (`255.255.255.252`) | `192.228.18.128` | `192.228.18.129 - 192.228.18.130` | `192.228.18.131` |
| **A23** | Protocol7 > Knights | 2 | `/30` (`255.255.255.252`) | `192.228.17.64` | `192.228.17.65 - 192.228.17.66` | `192.228.17.67` |
| **A24** | Knights > Phantoma | 2 | `/30` (`255.255.255.252`) | `192.228.16.136` | `192.228.16.137 - 192.228.16.138` | `192.228.16.139` |
| **A25** | Phantoma > Shibuya | 2 | `/30` (`255.255.255.252`) | `192.228.16.96` | `192.228.16.97 - 192.228.16.98` | `192.228.16.99` |

> [!NOTE]
> Seluruh 25 subnet di atas **100% non-overlapping** dan berada presisi di dalam batas Root Supernet **`192.228.0.0/19`** (`192.228.0.0` - `192.228.31.255`).

---

### 3. Perhitungan Penggabungan Rute (CIDR Supernetting)

Penggabungan rute dilakukan secara hierarkis (*bottom-up*) dari subnet terkecil hingga mencapai Root Supernet:

> [!NOTE]
> *(Diagram visual skema penggabungan CIDR terbaru akan diunggah menyusul)*

<!-- ![Skema Penggabungan CIDR](assets/Topologi_Penggabungan_CIDR.jpeg) -->

#### Tahap I (Prefix Kelompok B)
- **B1**: A14 (`192.228.4.0/29`) + A20 (`192.228.4.8/30`) $	o$ **`192.228.4.0/28`** (Rentang: `4.0` - `4.15`)
- **B2**: A3 (`192.228.12.0/23`) + A12 (`192.228.14.0/26`) $	o$ **`192.228.12.0/22`** (Rentang: `12.0` - `15.255`)
- **B3**: A13 (`192.228.16.64/27`) + A25 (`192.228.16.96/30`) $	o$ **`192.228.16.64/26`** (Rentang: `16.64` - `16.127`)
- **B4**: A16 (`192.228.16.128/29`) + A24 (`192.228.16.136/30`) $	o$ **`192.228.16.128/28`** (Rentang: `16.128` - `16.143`)
- **B5**: A11 (`192.228.17.0/26`) + A23 (`192.228.17.64/30`) $	o$ **`192.228.17.0/25`** (Rentang: `17.0` - `17.127`)
- **B6**: A8 (`192.228.18.0/25`) + A22 (`192.228.18.128/30`) $	o$ **`192.228.18.0/24`** (Rentang: `18.0` - `18.255`)
- **B7**: A4 (`192.228.20.0/23`) + A21 (`192.228.22.0/30`) $	o$ **`192.228.20.0/22`** (Rentang: `20.0` - `23.255`)
- **B8**: A5 (`192.228.24.0/24`) + A10 (`192.228.25.0/26`) $	o$ **`192.228.24.0/23`** (Rentang: `24.0` - `25.255`)
- **B9**: A17 (`192.228.28.128/30`) + A18 (`192.228.28.132/30`) $	o$ **`192.228.28.128/29`** (Rentang: `28.128` - `28.135`)

#### Tahap II (Prefix Kelompok C)
- **C1**: B1 (`192.228.4.0/28`) + A15 (`192.228.4.16/29`) $	o$ **`192.228.4.0/27`**
- **C2**: A1 (`192.228.8.0/22`) + B2 (`192.228.12.0/22`) $	o$ **`192.228.8.0/21`**
- **C3**: A9 (`192.228.16.0/26`) + B3 (`192.228.16.64/26`) $	o$ **`192.228.16.0/25`**
- **C4**: B8 (`192.228.24.0/23`) + A6 (`192.228.26.0/24`) $	o$ **`192.228.24.0/22`**
- **C5**: B9 (`192.228.28.128/29`) + A19 (`192.228.28.136/30`) $	o$ **`192.228.28.128/28`**

#### Tahap III sampai VIII (Supernet Utama)
- **Tahap III (D)**:
  - **D1**: A2 (`192.228.0.0/22`) + C1 (`192.228.4.0/27`) $	o$ **`192.228.0.0/21`**
  - **D2**: C3 (`192.228.16.0/25`) + B4 (`192.228.16.128/28`) $	o$ **`192.228.16.0/24`**
  - **D3**: A7 (`192.228.28.0/25`) + C5 (`192.228.28.128/28`) $	o$ **`192.228.28.0/24`**
- **Tahap IV (E)**:
  - **E1**: D1 (`192.228.0.0/21`) + C2 (`192.228.8.0/21`) $	o$ **`192.228.0.0/20`** (Seluruh Sayap Kiri)
  - **E2**: D2 (`192.228.16.0/24`) + B5 (`192.228.17.0/25`) $	o$ **`192.228.16.0/23`**
  - **E3**: C4 (`192.228.24.0/22`) + D3 (`192.228.28.0/24`) $	o$ **`192.228.24.0/21`** (Sayap Kanan + Cyberia)
- **Tahap V (F)**:
  - **F1**: E2 (`192.228.16.0/23`) + B6 (`192.228.18.0/24`) $	o$ **`192.228.16.0/22`**
- **Tahap VI (G)**:
  - **G1**: F1 (`192.228.16.0/22`) + B7 (`192.228.20.0/22`) $	o$ **`192.228.16.0/21`** (Seluruh Sayap Bawah)
- **Tahap VII (H)**:
  - **H1**: G1 (`192.228.16.0/21`) + E3 (`192.228.24.0/21`) $	o$ **`192.228.16.0/20`** (Bawah + Kanan + Cyberia)
- **Tahap VIII (I - Root Supernet)**:
  - **I1 (Root Supernet)**: E1 (`192.228.0.0/20`) + H1 (`192.228.16.0/20`) $	o$ **`192.228.0.0/19`** (Mencakup seluruh jaringan The Wired).

---

### 4. Konfigurasi Routing Statis & Gateway

Agregasi rute membuat tabel routing setiap router sangat ringkas dan efisien dengan memanfaatkan blok supernet hasil penggabungan:

#### A. Router Gateway Internet (`Cyberia`)
Cyberia meneruskan seluruh trafik internal The Wired ke Router Wired, serta melakukan NAT Masquerade ke internet publik:
```bash
# eth0 -> NAT1 (internet)
# eth1 -> Switch1 (JJ, MyuMyu)        A7:  192.228.28.1/25
# eth2 -> Wired                       A17: 192.228.28.129/30

# Routing ke seluruh The Wired via Wired:
ip route add 192.228.0.0/19 via 192.228.28.130   # blok I1
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
```

#### B. Router Backbone (`Wired`)
Tabel routing Wired hanya memerlukan 5 rute supernet agregat untuk menjangkau seluruh 25 subnet internal:
```bash
# Default route ke Gateway Cyberia (Internet)
ip route add default via 192.228.28.129

# Rute Supernet ke Sayap Kanan & Sayap Bawah
ip route add 192.228.24.0/22 via 192.228.28.134  # blok C4 (Sayap Kanan / Navi)
ip route add 192.228.16.0/21 via 192.228.28.138  # blok G1 (Sayap Bawah / Tachibana)

# Rute Supernet ke Sayap Kiri (Multi-access Switch2)
ip route add 192.228.8.0/22  via 192.228.4.2     # blok A1 (Psyche)
ip route add 192.228.12.0/22 via 192.228.4.3     # blok B2 (Copland)
ip route add 192.228.0.0/21  via 192.228.4.4     # blok D1 (Schumann & Accela)
```

#### C. Rantai Router Sayap Bawah (Tachibana $	o$ Shibuya)
Setiap router di sayap bawah hanya menambahkan default route ke router atasnya, serta 1 rute agregat untuk segmen router di bawahnya:
- **`Tachibana`**: `ip route add default via 192.228.28.137` | `ip route add 192.228.16.0/22 via 192.228.22.2` (blok F1)
- **`Deus`**: `ip route add default via 192.228.22.1` | `ip route add 192.228.16.0/23 via 192.228.18.130` (blok E2)
- **`Protocol7`**: `ip route add default via 192.228.18.129` | `ip route add 192.228.16.0/24 via 192.228.17.66` (blok D2)
- **`Knights`**: `ip route add default via 192.228.17.65` | `ip route add 192.228.16.0/25 via 192.228.16.138` (blok C3)
- **`Phantoma`**: `ip route add default via 192.228.16.137` | `ip route add 192.228.16.0/26 via 192.228.16.98` (blok A9)
- **`Shibuya`**: `ip route add default via 192.228.16.97`

---

### 5. Cara Penggunaan Skrip Konfigurasi

Seluruh skrip konfigurasi per node telah disesuaikan dengan rute dan penomoran subnet terbaru pada direktori [`routings/gns3/`](./routings/gns3/):
- **13 Router**: `Cyberia.sh`, `Wired.sh`, `Navi.sh`, `Tachibana.sh`, `Deus.sh`, `Protocol7.sh`, `Knights.sh`, `Phantoma.sh`, `Shibuya.sh`, `Psyche.sh`, `Copland.sh`, `Schumann.sh`, `Accela.sh`.
- **25 Host / End Device**: `Karl.sh`, `Lin.sh`, `Akashic.sh`, `Eiri.sh`, `Collective.sh`, `Kuma.sh`, `JJ.sh`, `MyuMyu.sh`, `Juri.sh`, `Masayuki.sh`, `Omnipresence.sh`, `Denpa.sh`, `Alice.sh`, `Reika.sh`, `Taro.sh`, `Yasuo.sh`, `Miho.sh`, `Ghost.sh`, `Lilith.sh`, `Specter.sh`, `Chisa.sh`, `Hodgeson.sh`, `Semi.sh`, `Lain.sh`, `Mika.sh`.

Skrip dapat langsung dijalankan pada terminal node GNS3 masing-masing:
```bash
# Contoh eksekusi pada Router (Cyberia):
bash /root/Cyberia.sh

# Contoh eksekusi pada Host (Alice):
sh /root/Alice.sh
```

---

### 6. Panduan Pengujian Konektivitas (Testing Matrix)

1. **Uji Internet Gateway pada `Cyberia`**:
   - `ping -c 3 8.8.8.8` (0% packet loss ke internet melalui NAT1).
2. **Uji Backbone pada `Wired`**:
   - `ping -c 3 192.228.28.129` (Ke Gateway Cyberia).
   - `ping -c 3 8.8.8.8` (Ke Internet melalui Cyberia).
3. **Uji Client LAN Cyberia (`JJ`)**:
   - `ping -c 3 192.228.28.1` (Ke Gateway Cyberia).
   - `ping -c 3 192.228.28.3` (Ke sesama client MyuMyu).
   - `ping -c 3 8.8.8.8` (Ke Internet).
4. **Uji Lintas Sayap (Cross-Wing Ping dari `Alice` di Sayap Kanan)**:
   - `ping -c 3 192.228.24.1` (Ke Gateway Navi).
   - `ping -c 3 192.228.26.4` (Ke host Kuma di sayap kanan).
   - `ping -c 3 192.228.0.2` (Menyeberang ke Omnipresence di sayap kiri).
   - `ping -c 3 192.228.28.2` (Menyeberang ke JJ di LAN Cyberia).
   - `ping -c 3 8.8.8.8` (Ke Internet).
5. **Uji Simpul Terdalam (Host `Lain` di Ujung Sayap Bawah)**:
   - `ping -c 3 192.228.16.1` (Ke Gateway lokal Shibuya).
   - `ping -c 3 192.228.16.3` (Ke tetangga Mika).
   - `ping -c 3 192.228.16.130` (Ke server Eiri di router Knights).
   - `ping -c 3 192.228.8.2` (Melintasi 8 router ke host Karl di Sayap Kiri).
   - `ping -c 3 8.8.8.8` (Melintasi 7 hop router tembus ke Internet publik).
