#Requires AutoHotkey v2.0
#SingleInstance Force
#Include cd.ahk

triggerFile := "C:\trigger.txt"
iniFile := A_ScriptDir "\koordinat.ini"

^+A:: CreateDeleteIni

; ================== FUNGSI DASAR ==================
DoClick(pc) {
    x := IniRead(iniFile, pc, "x", 0)
    y := IniRead(iniFile, pc, "y", 0)
    if (x && y) {
        Sleep 2000
        Click("Right", x, y)
    } else {
        TrayTip("Koordinat " pc " tidak ditemukan")
    }
}

; ================== FUNGSI WAKTU ==================
FungsiWaktu_1() {
    Sleep 1000
    Send "{Right}"
    Sleep 1000
    Send "{Enter}"
}
FungsiWaktu_2() {
    Sleep 1000
    Send "{Right}"
    Sleep 1000
    Send "{Down}"
    Sleep 1000
    Send "{Enter}"
}
FungsiWaktu_3() {
    Sleep 1000
    Send "{Right}"
    Sleep 1000
    Send "{Down}"
    Sleep 1000
    Send "{Down}"
    Sleep 1000
    Send "{Enter}"
}
FungsiWaktu_4() {
    Sleep 1000
    Send "{Right}"
    Sleep 1000
    Send "{Down}"
    Sleep 1000
    Send "{Down}"
    Sleep 1000
    Send "{Down}"
    Sleep 1000
    Send "{Enter}"
}
FungsiWaktu_10() {
    Sleep 1000
    Send "{Right}"
    Sleep 1000
    Send "{Down}"
    Sleep 1000
    Send "{Down}"
    Sleep 1000
    Send "{Down}"
    Sleep 1000
    Send "{Down}"
    Sleep 1000
    Send "{Enter}"
}
FungsiTambahkanWaktu_1Jam() {
    Sleep 1000
    Send "{Down}"
    Sleep 1000
    Send "{Enter}"
}
FungsiTambahkanWaktu_2Jam() {
    Sleep 1000
    Send "{Down}"
    Sleep 1000
    Send "{Down}"
    Sleep 1000
    Send "{Enter}"
}

FungsiTambahkanWaktu_3Jam() {
    Sleep 1000
    Send "{Down}"
    Sleep 1000
    Send "{Down}"
    Sleep 1000
    Send "{Down}"
    Sleep 1000
    Send "{Enter}"
}

FungsiTambahkanWaktu_4Jam() {
    Sleep 1000
    Send "{Down}"
    Sleep 1000
    Send "{Down}"
    Sleep 1000
    Send "{Down}"
    Sleep 1000
    Send "{Down}"
    Sleep 1000
    Send "{Enter}"
}
FungsiTambahkanWaktu_10Jam() {
    Sleep 1000
    Send "{Down}"
    Sleep 1000
    Send "{Down}"
    Sleep 1000
    Send "{Down}"
    Sleep 1000
    Send "{Down}"
    Sleep 1000
    Send "{Down}"
    Sleep 1000
    Send "{Enter}"
}

; ================== FUNGSI AKSI ==================
FungsiAksi_BukaPaket() {
    Sleep 1000
    Send "{Down}"
    Sleep 1000
    Send "{Down}"
}
FungsiAksi_TambahkanWaktu() {
    Sleep 1000
    Send "{Down}"
    Sleep 1000
    Send "{Down}"
    Sleep 1000
    Send "{Down}"
    Sleep 1000
    Send "{Down}"
    Sleep 1000
    Send "{Right}"
    Sleep 1000
}
FungsiAksi_TutupBilling() {
    TrayTip "Beta Testing"
}
; tambah sesuai kebutuhan

; ================== TRIGGER LOOP ==================
SetTimer(CheckTrigger, 500)

CheckTrigger() {
    if !FileExist(triggerFile)
        return
    data := FileRead(triggerFile)
    FileDelete(triggerFile)
    data := Trim(data)
    if (data = "")
        return

    parts := StrSplit(data, "|")
    if parts.Length < 3 {
        TrayTip("Format salah: " data)
        return
    }

    pc := parts[1]
    waktu := parts[2]
    aksi := parts[3]

    ; 1. Klik PC
    DoClick(pc)

    ; 2. Panggil fungsi aksi berdasarkan nama
    if (aksi = "Buka Paket") {
        FungsiAksi_BukaPaket()
        if (waktu = "1")
            FungsiWaktu_1()
        else if (waktu = "2")
            FungsiWaktu_2()
        else if (waktu = "3")
            FungsiWaktu_3()
        else if (waktu = "4")
            FungsiWaktu_4()
        else if (waktu = "10")
            FungsiWaktu_10()
        ; ... tambah hingga 10
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

; Hotkey untuk testing
^F1:: {
    FileAppend("PC1|4|Buka Paket", triggerFile)
}
^F2:: ExitApp