#Requires AutoHotkey v2.0
#SingleInstance Force
#Include ShinsImageScanClass.ahk

x := 0
y := 0
w := 0
h := 0
scan := ShinsImageScanClass(0)

; === SETUP COORDINATE MODE ===
CoordMode "Mouse", "Screen"     ; Koordinat mouse relative ke screen
CoordMode "Pixel", "Screen"     ; Koordinat pixel search relative ke screen
CoordMode "ToolTip", "Screen"   ; ToolTip position relative ke screen

; === BACA/CREATE CONFIG ===
; Cek apakah file config.ini ada
if !FileExist("config.ini") {
    ; Buat file config.ini dengan default values
    IniWrite("1920", "config.ini", "Koordinat", "refWidth")
    IniWrite("1080", "config.ini", "Koordinat", "refHeight")
    IniWrite("962", "config.ini", "Koordinat", "f1X")
    IniWrite("415", "config.ini", "Koordinat", "f1Y")
    IniWrite("962", "config.ini", "Koordinat", "f2X")
    IniWrite("962", "config.ini", "Koordinat", "f2Y")
    IniWrite("962", "config.ini", "Koordinat", "f2X_1")
    IniWrite("962", "config.ini", "Koordinat", "f2Y_1")
    IniWrite("962", "config.ini", "Koordinat", "AcceptX")
    IniWrite("962", "config.ini", "Koordinat", "AcceptY")
    IniWrite("962", "config.ini", "Koordinat", "AcceptX_1")
    IniWrite("962", "config.ini", "Koordinat", "AcceptY_1")
    IniWrite("962", "config.ini", "Logo", "Genshin_X")
    IniWrite("962", "config.ini", "Logo", "Genshin_Y")
    IniWrite("962", "config.ini", "Logo", "Honkai_X")
    IniWrite("962", "config.ini", "Logo", "Honkai_Y")
    IniWrite("962", "config.ini", "Logo", "ZZZ_X")
    IniWrite("962", "config.ini", "Logo", "ZZZ_Y")
    IniWrite("962", "config.ini", "Logo", "PlayGame")
    IniWrite("G:\HoYoPlay\run.bat", "config.ini", "Path", "Genshin_Impact")
    IniWrite("G:\HoYoPlay", "config.ini", "Path", "Folder")

    MsgBox "File config.ini telah dibuat dengan default values!`nSilahkan edit jika perlu.", "Config Created"
}

; Baca file config.ini
try {
    refW := IniRead("config.ini", "Koordinat", "refWidth")
    refH := IniRead("config.ini", "Koordinat", "refHeight")
    f1X := IniRead("config.ini", "Koordinat", "f1X")
    f1Y := IniRead("config.ini", "Koordinat", "f1Y")
    f2X := IniRead("config.ini", "Koordinat", "f2X")
    f2Y := IniRead("config.ini", "Koordinat", "f2Y")
    f2X_1 := IniRead("config.ini", "Koordinat", "f2X_1")
    f2Y_1 := IniRead("config.ini", "Koordinat", "f2Y_1")
    LogoGenshin_X := IniRead("config.ini", "Logo", "Genshin_X")
    LogoGenshin_Y := IniRead("config.ini", "Logo", "Genshin_Y")
    LogoHonkai_X := IniRead("config.ini", "Logo", "Honkai_X")
    LogoHonkai_Y := IniRead("config.ini", "Logo", "Honkai_Y")
    LogoZZZ_X := IniRead("config.ini", "Logo", "ZZZ_X")
    LogoZZZ_Y := IniRead("config.ini", "Logo", "ZZZ_Y")
    PlayGame := IniRead("config.ini", "Logo", "PlayGame")
    AcceptX := IniRead("config.ini", "Koordinat", "AcceptX")
    AcceptY := IniRead("config.ini", "Koordinat", "AcceptY")
    AcceptX_1 := IniRead("config.ini", "Koordinat", "AcceptX_1")
    AcceptY_1 := IniRead("config.ini", "Koordinat", "AcceptY_1")
    Folder := IniRead("config.ini", "Path", "Folder")
    Genshin_Impact_Path := IniRead("config.ini", "Path", "Genshin_Impact")

    ; Konversi ke angka
    refW := Integer(refW)
    refH := Integer(refH)
    f1X := Integer(f1X)
    f1Y := Integer(f1Y)
    f2X := Integer(f2X)
    f2Y := Integer(f2Y)
    f2X_1 := Integer(f2X_1)
    f2Y_1 := Integer(f2Y_1)
    LogoGenshin_X := Integer(LogoGenshin_X)
    LogoGenshin_Y := Integer(LogoGenshin_Y)
    LogoHonkai_X := Integer(LogoHonkai_X)
    LogoHonkai_Y := Integer(LogoHonkai_Y)
    LogoZZZ_X := Integer(LogoZZZ_X)
    LogoZZZ_Y := Integer(LogoZZZ_Y)
    ;PlayGame := Integer(PlayGame)
    AcceptX := Integer(AcceptX)
    AcceptY := Integer(AcceptY)

} catch as e {
    MsgBox "Error baca config.ini:`n" e.Message "`n`nPastikan format file benar.", "Error", 16
    ExitApp
}

; === HOTKEY ===
#HotIf WinActive("ahk_class UnityWndClass")

; F1
CapsLock & F1:: {
    MouseClick("Left", f1X, f1Y)
}

Capslock & F2:: {
    MouseClick("Left", f2X, f2Y)
    sleep 1000
    MouseClick("Left", f2X_1, f2Y_1)
}

Capslock & F3:: {
    MouseClick("Left", AcceptX, AcceptY)
    sleep 1000
    MouseClick("Left", AcceptX_1, AcceptY_1)
}

#HotIf

; === Hotkey ===
Capslock & G:: {
    MouseClick("Left", LogoGenshin_X, LogoGenshin_Y)
    sleep 1000
    Click PlayGame
}
Capslock & H:: {
    MouseClick("Left", LogoGenshin_X, LogoGenshin_Y)
    sleep 1000
    Click PlayGame
}
Capslock & Z:: {
    MouseClick("Left", LogoGenshin_X, LogoGenshin_Y)
    sleep 1000
    Click PlayGame
}

F12:: ExitApp

; === Informasi Pertama
MsgBox "CapsLock + F1 = Start Genshin`nCapsLock + F2 = Tombol Exit Genshin`nCapsLock + F3 = Tombol Otomatis Accept Terms `nF12 = Keluar dari Script Auto Update Genshin"

; === Menjalnkan Genshin ===
SetWorkingDir Folder
Run Genshin_Impact_Path
SetWorkingDir A_ScriptDir