# Tabel Penggabungan CIDR (Supernetting)

Ini tabel supernet lengkapnya, per tahap, sesuai sheet “Penggabungan - CIDR” terbaru. Seluruh gabungan telah disinkronkan dengan penomoran subnet A1-A25 pada tabel Rute terbaru.

## Tahap I (B)

| Hasil | Gabungan dari | Hasil gabungan | Rentang alamat |
| :--- | :--- | :--- | :--- |
| B1 | A14 `192.228.4.0/29` + A20 `192.228.4.8/30` | `192.228.4.0/28` | 4.0 - 4.15 |
| B2 | A3 `192.228.12.0/23` + A12 `192.228.14.0/26` | `192.228.12.0/22` | 12.0 - 15.255 |
| B3 | A13 `192.228.16.64/27` + A25 `192.228.16.96/30` | `192.228.16.64/26` | 16.64 - 16.127 |
| B4 | A16 `192.228.16.128/29` + A24 `192.228.16.136/30` | `192.228.16.128/28` | 16.128 - 16.143 |
| B5 | A11 `192.228.17.0/26` + A23 `192.228.17.64/30` | `192.228.17.0/25` | 17.0 - 17.127 |
| B6 | A8 `192.228.18.0/25` + A22 `192.228.18.128/30` | `192.228.18.0/24` | 18.0 - 18.255 |
| B7 | A4 `192.228.20.0/23` + A21 `192.228.22.0/30` | `192.228.20.0/22` | 20.0 - 23.255 |
| B8 | A5 `192.228.24.0/24` + A10 `192.228.25.0/26` | `192.228.24.0/23` | 24.0 - 25.255 |
| B9 | A17 `192.228.28.128/30` + A18 `192.228.28.132/30` | `192.228.28.128/29` | 28.128 - 28.135 |

---

## Tahap II (C)

| Hasil | Gabungan dari | Hasil gabungan |
| :--- | :--- | :--- |
| C1 | B1 `4.0/28` + A15 `4.16/29` | `192.228.4.0/27` |
| C2 | A1 `8.0/22` + B2 `12.0/22` | `192.228.8.0/21` |
| C3 | A9 `16.0/26` + B3 `16.64/26` | `192.228.16.0/25` |
| C4 | B8 `24.0/23` + A6 `26.0/24` | `192.228.24.0/22` |
| C5 | B9 `28.128/29` + A19 `28.136/30` | `192.228.28.128/28` |

---

## Tahap III sampai VIII

| Tahap | Hasil | Gabungan dari | Hasil gabungan |
| :--- | :--- | :--- | :--- |
| III (D) | D1 | A2 `0.0/22` + C1 `4.0/27` | `192.228.0.0/21` |
| III (D) | D2 | C3 `16.0/25` + B4 `16.128/28` | `192.228.16.0/24` |
| III (D) | D3 | A7 `28.0/25` + C5 `28.128/28` | `192.228.28.0/24` |
| IV (E) | E1 | D1 `0.0/21` + C2 `8.0/21` | `192.228.0.0/20` |
| IV (E) | E2 | D2 `16.0/24` + B5 `17.0/25` | `192.228.16.0/23` |
| IV (E) | E3 | C4 `24.0/22` + D3 `28.0/24` | `192.228.24.0/21` |
| V (F) | F1 | E2 `16.0/23` + B6 `18.0/24` | `192.228.16.0/22` |
| VI (G) | G1 | F1 `16.0/22` + B7 `20.0/22` | `192.228.16.0/21` |
| VII (H) | H1 | G1 `16.0/21` + E3 `24.0/21` | `192.228.16.0/20` |
| VIII (I) | I1 | E1 `0.0/20` + H1 `16.0/20` | `192.228.0.0/19` |

---

## Urutan Penjelasan Saat Demo:

1. **Kerangka**: Jelaskan bahwa A1-A25 merupakan subnet per segmen pada topologi yang diurutkan berdasarkan kebutuhan IP dari terbesar ke terkecil (sesuai sheet "Rute" terbaru).
2. **Aturan Penggabungan**: Dua blok dapat digabung jika bersebelahan, memiliki panjang prefix yang sama, dan berada pada boundary prefix baru (misal: dua blok `/29` menjadi satu `/28`).
3. **Agregasi Rute**: Blok hasil penggabungan (seperti `blok C4`, `blok G1`, `blok B2`, `blok D1`) langsung menjadi entri routing statis ringkas pada router transit (`Wired`) dan router sayap.
