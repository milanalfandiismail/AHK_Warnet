#Requires AutoHotkey v2.0
#SingleInstance Force
#Include cd.ahk
#Include Gdip_All.ahk

; --- KONFIGURASI PATH ---
triggerFile := A_ScriptDir "\trigger.txt"
memberFile := A_ScriptDir "\member.txt"
screenshotDir := A_ScriptDir "\screenshot\"
iniFile := A_ScriptDir "\koordinat.ini"

CoordMode "Mouse", "Screen"

; --- INIT GDI+ ---
pToken := Gdip_Startup()
if (!pToken) {
    MsgBox "GDI+ gagal dijalankan"
    ExitApp
}
OnExit((*) => Gdip_Shutdown(pToken))

; --- FUNGSI HELPER KOORDINAT ---

; 1. Baca X dan Y terpisah (Untuk Section PC & Waktu)
GetCoordXY(section) {
    x := IniRead(iniFile, section, "x", "")
    y := IniRead(iniFile, section, "y", "")
    if (x = "" || y = "") {
        return 0
    }
    return { x: Integer(x), y: Integer(y) }
}

; 2. Baca X|Y dari Key (Untuk Section Grup UI)
GetCoordKey(section, key) {
    val := IniRead(iniFile, section, key, "")
    if (val = "" || InStr(val, "|") = 0) {
        return 0
    }
    parts := StrSplit(val, "|")
    return { x: Integer(parts[1]), y: Integer(parts[2]) }
}

; 3. Baca X|Y|W|H (Untuk Screenshot)
GetCoordArea(section, key) {
    val := IniRead(iniFile, section, key, "")
    if (val = "" || InStr(val, "|") = 0) {
        return 0
    }
    parts := StrSplit(val, "|")
    if (parts.Length < 4) {
        return 0
    }
    return { x: Integer(parts[1]), y: Integer(parts[2]), w: Integer(parts[3]), h: Integer(parts[4]) }
}

; --- WRAPPER KLIK ---

ClickSectionXY(section, delay := 0) {
    coord := GetCoordXY(section)
    if (coord) {
        Sleep delay
        Click coord.x, coord.y
        return true
    }
    return false
}

ClickSectionKey(section, key, delay := 0) {
    coord := GetCoordKey(section, key)
    if (coord) {
        Sleep delay
        Click coord.x, coord.y
        return true
    }
    return false
}

; --- FUNGSI UTAMA ---

AmbilScreenshot(section, key, namaFile) {
    global screenshotDir
    rect := GetCoordArea(section, key)
    
    if (!rect) {
        MsgBox "Gagal ambil koordinat screenshot"
        return 0
    }

    pBitmap := Gdip_BitmapFromScreen(rect.x "|" rect.y "|" rect.w "|" rect.h)
    if (!pBitmap) {
        MsgBox "Gagal ambil bitmap"
        return 0
    }

    path := screenshotDir . namaFile
    Gdip_SaveBitmapToFile(pBitmap, path)
    Gdip_DisposeImage(pBitmap)
    TrayTip "Screenshot tersimpan:", path
    return path
}

DoClickPC(pcSection) {
    ClickSectionXY(pcSection, 2000)
}

; --- FUNGSI ISI MEMBER ---
FungsiIsiMember(namaMember) {
    ClickSectionKey("MemberUI", "VoucherBilling", 300)
    ClickSectionKey("MemberUI", "FieldMember", 100)
    ClickSectionKey("MemberUI", "InputMember", 50)
    
    Send "^a"
    Sleep 50
    Send "{Backspace}"
    Sleep 50
    
    Send namaMember
    Sleep 1000
    
    ClickSectionKey("MemberUI", "BtnCari", 1000)
    TrayTip "Member " namaMember " selesai diisi"
}

; --- FUNGSI DOCLICKMEMBER (DIKEMBALIKAN) ---
DoClickMember(waktu_member) {
    ; 1. Ambil koordinat waktu dari section [1 Jam], [2 Jam], dst
    coordWaktu := GetCoordXY(waktu_member)
    
    if (coordWaktu) {
        Sleep 1000
        Click coordWaktu.x, coordWaktu.y
        
        Sleep 1000
        ; 2. Klik Tombol Penjualan Paket (Dari INI MemberUI)
        ClickSectionKey("MemberUI", "BtnJualPaket", 500)
        
        Sleep 500
        Send "{Enter}"
        
        Sleep 500
        ; 3. Klik Tombol Tutup (Dari INI MemberUI)
        ClickSectionKey("MemberUI", "BtnTutupPaket", 500)
    } else {
        TrayTip("Waktu " waktu_member " tidak ditemukan di koordinat")
    }
}

DoClickLaporan() {
    ClickSectionKey("Laporan", "Step1", 1500)
    ClickSectionKey("Laporan", "Step2", 500)
    ClickSectionKey("Laporan", "Step3", 500)
    Sleep 500
    Send "laporan_penjualan.pdf"
    Sleep 1000
    Send "{Enter}"
    Sleep 1000
    Send "{Left}"
    Sleep 1000
    Send "{Enter}"
    Sleep 1000
    ClickSectionKey("Laporan", "Step4", 1000)
}

FungsiTutupBilling() {
    Sleep 500
    Send "{Down}"
    Sleep 500
    Send "{Enter}"
    ClickSectionKey("MemberUI", "BtnTutupBilling", 500)
}

FungsiAksi(actionName, waktu) {
    if (actionName = "Buka Paket") {
        waktuSection := waktu . " Jam"
        ClickSectionXY(waktuSection, 500)
    } else if (actionName = "Tambah Waktu") {
        waktuSection := waktu . " Jam"
        ClickSectionXY(waktuSection, 500)
        Sleep 100
        Send "{Escape}"
    } else if (actionName = "Tutup Billing") {
        FungsiTutupBilling()
    } else {
        TrayTip "Aksi " actionName " tidak dikenal"
    }
}

; --- TRIGGER LOOP ---
SetTimer(CheckTrigger, 500)
SetTimer(CheckMember, 500)
SetTimer(CheckScreenshot, 500)

CheckTrigger() {
    if (!FileExist(triggerFile)) {
        return
    }
    
    data := FileRead(triggerFile)
    FileDelete(triggerFile)
    data := Trim(data)
    if (data = "") {
        return
    }

    parts := StrSplit(data, "|")
    if (parts.Length < 3) {
        TrayTip "Format trigger salah"
        return
    }

    pcSection := parts[1]
    waktu := parts[2]
    aksi := parts[3]

    DoClickPC(pcSection)
    FungsiAksi(aksi, waktu)
}

CheckMember() {
    if (!FileExist(memberFile)) {
        return
    }

    data := FileRead(memberFile)
    FileDelete(memberFile)
    data := Trim(data)
    if (data = "") {
        return
    }

    parts := StrSplit(data, "|")
    if (parts.Length < 1) {
        return
    }

    namaMember := parts[1]
    waktuLabel := ""
    if (parts.Length >= 2) {
        waktuLabel := parts[2]
    }

    ; 1. Isi Data Member
    FungsiIsiMember(namaMember)
    Sleep 1500
    
    ; 2. Pilih Waktu (Memanggil DoClickMember)
    if (waktuLabel != "") {
        DoClickMember(waktuLabel)
    }
}

CheckScreenshot() {
    screenshotFile := "C:\screenshot.txt"
    if (!FileExist(screenshotFile)) {
        return
    }
    
    AmbilScreenshot("Screenshot", "SmartBilling", "smartbilling_kasir.png")
    FileDelete(screenshotFile)
    Sleep 1000
}

; --- HOTKEY TESTING ---
^F1:: {
    FileAppend("PC-1|4|Buka Paket", triggerFile)
    TrayTip "Trigger test dibuat untuk PC-1"
}

^F3:: {
    FileAppend("NamaCustomer|1 Jam", memberFile)
    TrayTip "Member test dibuat"
}

^F2:: ExitApp