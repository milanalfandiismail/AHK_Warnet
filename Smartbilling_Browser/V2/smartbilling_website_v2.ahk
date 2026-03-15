#Requires AutoHotkey v2.0
#SingleInstance Force
#Include createkoordinat_PC.ahk
#Include Gdip_All.ahk

triggerFile := "C:\trigger.txt"
memberFile := "C:\member.txt"
screenshotDir := A_ScriptDir "\screenshot\"
iniFile := A_ScriptDir "\koordinat.ini"

TraySetIcon(A_ScriptDir "\smartbilling_website.ico")
CoordMode "Mouse", "Screen"

^+A:: CreateDeleteIni
; [Preset 1] Area pojok kiri atas 400x300
^!1:: {
    AmbilScreenshot(0, 0, 1920, 1080, "pojok_kiri_400x300.png")
}
^!2:: DoClickLaporan

; ============================================================
; FUNGSI SCREENSHOT
; ============================================================

; Init GDI+
if !(pToken := Gdip_Startup()) {
    MsgBox "GDI+ gagal dijalankan"
    ExitApp
}
OnExit((*) => Gdip_Shutdown(pToken))

AmbilScreenshot(x, y, w, h, namaFile) {
    global screenshotDir

    ; Validasi
    if (w <= 0 or h <= 0) {
        MsgBox "Lebar dan tinggi harus positif!"
        return 0
    }

    ; Format: "x|y|lebar|tinggi"
    pBitmap := Gdip_BitmapFromScreen(x "|" y "|" w "|" h)
    if !pBitmap {
        MsgBox "Gagal ambil screenshot"
        return 0
    }

    ; Simpan file
    path := screenshotDir . namaFile
    Gdip_SaveBitmapToFile(pBitmap, path)
    Gdip_DisposeImage(pBitmap)

    TrayTip "Screenshot tersimpan:", path
    return path
}

; ================== FUNGSI DASAR ==================
DoClick(pc) {
    ; Baca koordinat dari format "kor=311,451"
    koord := IniRead(iniFile, pc, "kor", "")
    if (koord = "") {
        TrayTip("Koordinat " pc " tidak ditemukan")
        return
    }

    ; Pisahkan dan validasi
    koordParts := StrSplit(koord, ",")
    if (koordParts.Length < 2) {
        TrayTip("Format koordinat salah untuk " pc ": " koord)
        return
    }

    xint := Trim(koordParts[1])
    yint := Trim(koordParts[2])

    x := Integer(xint)
    y := Integer(yint)
    if !(x is number && y is number) {
        TrayTip("Koordinat harus berupa angka untuk " pc ": " koord)
        return
    }

    Sleep 2000
    Click("Right", x, y)
}

DoClickMember(waktu_member) {
    x := IniRead(iniFile, waktu_member, "x", 0)
    y := IniRead(iniFile, waktu_member, "y", 0)
    if (x && y) {
        Sleep 1000
        Click("Left", x, y)
        Sleep 1000
        Click 984, 719 ; < Tombol Penjualan Paket di Voucher Billing
        Sleep 500
        Send "{Enter}"
        Sleep 500
        Click 1026, 758 ; < Tombol tutup di Paket di Voucher Billing
    } else {
        TrayTip("Waktu" waktu_member " tidak ditemukan")
    }
}

DoClickLaporan() {
    nama_laporan_file := "laporan_penjualan.pdf"

    Sleep 1500
    Click 1564, 80
    Sleep 500
    Click 496, 307
    Sleep 500
    Click 1234, 342
    Sleep 500
    Send nama_laporan_file
    Sleep 1000
    Send "{Enter}"
    Sleep 1000
    Send "{Left}"
    Sleep 1000
    Send "{Enter}"
    Sleep 1000
    Click 1279, 270
}
; ================== FUNGSI WAKTU ==================
FungsiWaktuReguler_1() {
    Sleep 100
    Send "{Right}"
    Sleep 100
    Send "{Enter}"
    Sleep 100
    Send "{Escape}"
}

FungsiWaktuReguler_2() {
    Sleep 100
    Send "{Right}"
    Sleep 100
    Send "{Down}"
    Sleep 100
    Send "{Enter}"
    Sleep 100
    Send "{Escape}"
}

FungsiWaktuReguler_2_30() {
    Sleep 100
    Send "{Right}"
    Sleep 100
    Send "{Down}"
    Sleep 100
    Send "{Down}"
    Sleep 100
    Send "{Enter}"
    Sleep 100
    Send "{Escape}"
}

FungsiTambahkanWaktu_1Jam() {
    Sleep 100
    Send "{Down}"
    Sleep 100
    Send "{Enter}"
    Sleep 100
    Send "{Escape}"
}
FungsiTambahkanWaktu_2Jam() {
    Sleep 100
    Send "{Down}"
    Sleep 100
    Send "{Down}"
    Sleep 100
    Send "{Enter}"
    Sleep 100
    Send "{Escape}"
}

FungsiTambahkanWaktu_3Jam() {
    Sleep 100
    Send "{Down}"
    Sleep 100
    Send "{Down}"
    Sleep 100
    Send "{Down}"
    Sleep 100
    Send "{Enter}"
    Sleep 100
    Send "{Escape}"
}

FungsiTambahkanWaktu_4Jam() {
    Sleep 100
    Send "{Down}"
    Sleep 100
    Send "{Down}"
    Sleep 100
    Send "{Down}"
    Sleep 100
    Send "{Down}"
    Sleep 100
    Send "{Enter}"
    Sleep 100
    Send "{Escape}"
}
FungsiTambahkanWaktu_10Jam() {
    Sleep 100
    Send "{Down}"
    Sleep 100
    Send "{Down}"
    Sleep 100
    Send "{Down}"
    Sleep 100
    Send "{Down}"
    Sleep 100
    Send "{Down}"
    Sleep 100
    Send "{Enter}"
    Sleep 100
    Send "{Escape}"
}

; ================== FUNGSI AKSI ==================
FungsiAksi_BukaPaket() {
    Sleep 100
    Send "{Down}"
    Sleep 100
    Send "{Down}"
}
FungsiAksi_TambahkanWaktu() {
    Sleep 100
    Send "{Down}"
    Sleep 100
    Send "{Down}"
    Sleep 100
    Send "{Down}"
    Sleep 100
    Send "{Down}"
    Sleep 100
    Send "{Right}"
    Sleep 100
}
FungsiAksi_TutupBilling() {
    Sleep 500
    Send "{Down}"
    Sleep 500
    Send "{Enter}"
    Click 856, 801
    Sleep 500
}
; tambah sesuai kebutuhan

; ================== TRIGGER LOOP ==================
SetTimer(CheckTrigger, 500)
SetTimer(CheckMember, 500)
SetTimer(CheckScreenshot, 500)
SetTimer(CheckLaporan, 500)

CheckTrigger() {
    if !FileExist(triggerFile)
        return
    data := FileRead(triggerFile)
    FileDelete(triggerFile)
    data := Trim(data)
    if (data = "")
        return

    parts := StrSplit(data, "|")
    if parts.Length < 4 {
        TrayTip("Format salah: " data)
        return
    }

    pc := parts[1]
    waktu := parts[2]
    aksi := parts[3]
    role := parts[4]

    ; 1. Klik PC
    DoClick(pc)
    
    ; 2. Panggil fungsi aksi berdasarkan nama
    if (aksi = "Buka Paket") {
        FungsiAksi_BukaPaket()
        /*
        if (role = "reguler") {
            if (waktu = "1")
                FungsiWaktuReguler_1()
            else if (waktu = "2")
                FungsiWaktuReguler_2()
            else if (waktu = "2.30")
                FungsiWaktuReguler_2_30()
            else if (waktu = "3")
                FungsiWaktuReguler_3()
            else if (waktu = "3.40")
                FungsiWaktuReguler_3_40()
            else if (waktu = "5")
                FungsiWaktuReguler_5()
        }
        else if (role = "vip") {
            if (waktu = "1")
                FungsiWaktuVip_1()
            else if (waktu = "2")
                FungsiWaktuVip_2()
            else if (waktu = "3")
                FungsiWaktuVip_3()
            else if (waktu = "4")
                FungsiWaktuVip_4()
        }
        else if role = "vvip" {
            if (waktu = "1")
                FungsiWaktuVVip_1()
            else if (waktu = "1.15")
                FungsiWaktuVVip_1_15()
            else if (waktu = "2")
                FungsiWaktuVVip_2()
            else if (waktu = "3")
                FungsiWaktuVVip_3()
            else if (waktu = "4")
                FungsiWaktuVVip_4()
            else if (waktu = "5")
                FungsiWaktuVVip_5()
            else if (waktu = "6")
                FungsiWaktuVVip_6()
            else if (waktu = "7")
                FungsiWaktuVVip_7()
            else if (waktu = "8")
                FungsiWaktuVVip_8()
            else if (waktu = "9")
                FungsiWaktuVVip_9()
            else if (waktu = "10")
                FungsiWaktuVVip_10()
        }
            */

    } else {
        TrayTip("Aksi" aksi " tidak dikenali")
    }
    if (aksi = "Tambah Waktu") {
        FungsiAksi_TambahkanWaktu()
        if (waktu = "1")
            FungsiTambahkanWaktu_1Jam()
        else if (waktu = "2")
            FungsiTambahkanWaktu_2Jam()
        else if (waktu = "3")
            FungsiTambahkanWaktu_3Jam()
        else if (waktu = "4")
            FungsiTambahkanWaktu_4Jam()
        else if (waktu = "10")
            FungsiTambahkanWaktu_10Jam()
    } else {
        TrayTip("Error, waktu diluar nilai")
    }
    if (aksi = "Tutup Billing")
        FungsiAksi_TutupBilling()
    else
        TrayTip("Aksi " aksi " tidak dikenal")

}

; ================== TRIGGER KHUSUS MEMBER ==================
CheckMember() {
    if !FileExist(memberFile)
        return
    data := FileRead(memberFile)
    FileDelete(memberFile)
    data := Trim(data)
    if (data = "")
        return

    parts := StrSplit(data, "|")

    ; Minimal ada nama member
    if parts.Length < 1 {
        TrayTip("Format member salah: " data)
        return
    }

    namaMember := parts[1]
    waktu := ""  ; default kosong
    if parts.Length >= 2
        waktu := parts[2]  ; parameter waktu (opsional)

    ; Panggil fungsi isi member dengan parameter tambahan
    FungsiIsiMember(namaMember)
    Sleep 1500
    FungsiIsiWaktu_Member(waktu)
}

; ======================== Trigger ScreenShot ======================
CheckScreenshot() {
    screenshotFile := "C:\screenshot.txt"
    if !FileExist(screenshotFile) {
        return
    } else {
        AmbilScreenshot(5, 94, 1200, 180, "smartbilling_kasir.png")
        FileDelete (screenshotFile)
        sleep 1000
    }
}

CheckLaporan() {
    laporanFile := "C:\laporan.txt"
    if !FileExist(laporanFile) {
        return
    } else {
        sleep 1000
        DoClickLaporan()
        FileDelete(laporanFile)
        sleep 500
    }
}

FungsiIsiMember(namaMember) {
    Click 331, 74 ; < Tombol klik Voucher Billing
    Sleep 300

    Click 663, 438 ; < Tombol klik Member di Voucher Billing
    Sleep 100

    Click 779, 436 ; < Tombol klik fieldbar member di Voucher Billing
    Send "^a"
    Sleep 50
    Send "{Backspace}"
    Sleep 50

    Send namaMember
    Sleep 1000

    Click 896, 436 ; < Tombol cari di Voucher Billing
    ; < Fungsi buat waktu
    TrayTip("Member " namaMember " selesai")
    Sleep 1000
}

FungsiIsiWaktu_Member(waktu) {
    if waktu == "1 Jam"
        DoClickMember(waktu)
    else if waktu == "2 Jam"
        DoClickMember(waktu)
    else if waktu == "3 Jam"
        DoClickMember(waktu)
    else if waktu == "4 Jam"
        DoClickMember(waktu)
    else if waktu == "10 Jam"
        DoClickMember(waktu)
    else
        TrayTip("Waktu tidak ditemukan di server")
}

; Hotkey untuk testing
^F1:: {
    FileAppend("PC-1|4|Buka Paket|reguler", triggerFile)
}

^F2:: ExitApp