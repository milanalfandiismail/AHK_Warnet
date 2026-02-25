# README – Panduan Config.ini AutoHotkey

File **config.ini** digunakan untuk menyimpan koordinat tombol, path aplikasi, dan logo.
⚠️ **PENTING:** Semua komentar yang ada sebelumnya di belakang angka harus dihapus dari `.ini` supaya script AutoHotkey v2 tidak error.
Komentar sudah saya pindahkan ke README agar mudah dibaca.

---

## [Koordinat]

| Key          | Value | Keterangan / Komentar       |
| ------------ | ----- | --------------------------- |
| refWidth     | 1920  | Resolusi referensi lebar    |
| refHeight    | 1080  | Resolusi referensi tinggi   |
| f1X          | 952   | Genshin Tombol Enter Tengah |
| f1Y          | 448   | Genshin Tombol Enter Tengah |
| f1X1         | 952   | HSR Tombol Enter Tengah     |
| f1Y1         | 448   | HSR Tombol Enter Tengah     |
| f1X2         | 952   | ZZZ Tombol Enter Tengah     |
| f1Y2         | 448   | ZZZ Tombol Enter Tengah     |
| f2X          | 88    | Genshin Tombol Exit         |
| f2Y          | 976   | Genshin Tombol Exit         |
| f2X1         | 88    | HSR Tombol Exit             |
| f2Y1         | 976   | HSR Tombol Exit             |
| f2X2         | 88    | ZZZ Tombol Exit             |
| f2Y2         | 976   | ZZZ Tombol Exit             |
| f2X_1        | 1071  | Genshin Exit                |
| f2Y_1        | 577   | Genshin Exit                |
| f2X_2        | 1071  | HSR Exit                    |
| f2Y_2        | 577   | HSR Exit                    |
| f2X_3        | 1071  | ZZZ Exit                    |
| f2Y_3        | 577   | ZZZ Exit                    |
| AcceptX      | 578   | Genshin Impact              |
| AcceptY      | 490   | Genshin Impact              |
| AcceptX_1    | 1152  | Genshin Impact              |
| AcceptY_1    | 787   | Genshin Impact              |
| AcceptX_HSR  | 200   | HSR                         |
| AcceptY_HSR  | 200   | HSR                         |
| AcceptX_ZZZ  | 517   | ZZZ                         |
| AcceptY_ZZZ  | 606   | ZZZ                         |
| AcceptX_HSR1 | 200   | HSR                         |
| AcceptY_HSR1 | 200   | HSR                         |
| AcceptX_ZZZ1 | 927   | ZZZ                         |
| AcceptY_ZZZ1 | 816   | ZZZ                         |

> 💡 Pastikan semua value di atas **hanya angka**, tanpa komentar di belakang. Komentar sudah dicatat di README.

---

## [Path]

| Key            | Value               | Keterangan                            |
| -------------- | ------------------- | ------------------------------------- |
| Genshin_Impact | G:\HoYoPlay\run.bat | Path untuk menjalankan Genshin Impact |
| Folder         | G:\HoYoPlay         | Folder instalasi HoYoPlay             |

---

## [Logo]

| Key       | Value    | Keterangan                                               |
| --------- | -------- | -------------------------------------------------------- |
| Genshin_X | 193      | Posisi X logo Genshin                                    |
| Genshin_Y | 672      | Posisi Y logo Genshin                                    |
| Honkai_X  | 196      | Posisi X logo Honkai / HSR                               |
| Honkai_Y  | 730      | Posisi Y logo Honkai / HSR                               |
| ZZZ_X     | 189      | Posisi X logo ZZZ                                        |
| ZZZ_Y     | 787      | Posisi Y logo ZZZ                                        |
| PlayGame  | 1195,812 | Koordinat tombol Play Game (tidak di-convert ke Integer) |

---

## Tips Tambahan

1. Jangan menulis komentar di belakang angka di `.ini`, karena `Integer()` akan error.
2. Jika ingin menambahkan catatan, tulis **di baris atas** seperti ini:

```ini
; Genshin Tombol Enter Tengah
f1X=952
```

3. `PlayGame` tetap string karena ada tanda koma (`,`) dan akan di-split saat digunakan:

```ahk
coords := StrSplit(PlayGame, ",")
x := Integer(coords[1])
y := Integer(coords[2])
```

4. Semua koordinat dan path harus **sesuai resolusi dan folder di PC kamu**.
