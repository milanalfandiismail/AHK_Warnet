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

; === CEK/CREATE CONFIG.INI ===
If Not FileExist("config.ini") {
    ; Buat file config.ini dengan nilai default 0
    IniWrite("0", "config.ini", "Koordinat", "refWidth")
    IniWrite("0", "config.ini", "Koordinat", "refHeight")
    IniWrite("0", "config.ini", "Koordinat", "f1X")
    IniWrite("0", "config.ini", "Koordinat", "f1Y")
    IniWrite("0", "config.ini", "Koordinat", "f2X")
    IniWrite("0", "config.ini", "Koordinat", "f2Y")
    IniWrite("0", "config.ini", "Koordinat", "f2X_")
    IniWrite("0", "config.ini", "Koordinat", "f2Y_")
    IniWrite("0", "config.ini", "Koordinat", "f1X1")
    IniWrite("0", "config.ini", "Koordinat", "f1Y1")
    IniWrite("0", "config.ini", "Koordinat", "f2X1")
    IniWrite("0", "config.ini", "Koordinat", "f2Y1")
    IniWrite("0", "config.ini", "Koordinat", "f1X2")
    IniWrite("0", "config.ini", "Koordinat", "f1Y2")
    IniWrite("0", "config.ini", "Koordinat", "f2X2")
    IniWrite("0", "config.ini", "Koordinat", "f2Y2")
    IniWrite("0", "config.ini", "Koordinat", "f2X_1")
    IniWrite("0", "config.ini", "Koordinat", "f2Y_1")
    IniWrite("0", "config.ini", "Koordinat", "f2X_2")
    IniWrite("0", "config.ini", "Koordinat", "f2Y_2")
    IniWrite("0", "config.ini", "Koordinat", "f2X_3")
    IniWrite("0", "config.ini", "Koordinat", "f2Y_3")
    IniWrite("0", "config.ini", "Koordinat", "AcceptX")
    IniWrite("0", "config.ini", "Koordinat", "AcceptY")
    IniWrite("0", "config.ini", "Koordinat", "AcceptX_1")
    IniWrite("0", "config.ini", "Koordinat", "AcceptY_1")
    IniWrite("0", "config.ini", "Koordinat", "AcceptX_HSR")
    IniWrite("0", "config.ini", "Koordinat", "AcceptY_HSR")
    IniWrite("0", "config.ini", "Koordinat", "AcceptX_HSR1")
    IniWrite("0", "config.ini", "Koordinat", "AcceptY_HSR1")
    IniWrite("0", "config.ini", "Koordinat", "AcceptX_ZZZ")
    IniWrite("0", "config.ini", "Koordinat", "AcceptY_ZZZ")
    IniWrite("0", "config.ini", "Koordinat", "AcceptX_ZZZ1")
    IniWrite("0", "config.ini", "Koordinat", "AcceptY_ZZZ1")
    
    ; Section Logo
    IniWrite("0", "config.ini", "Logo", "Genshin_X")
    IniWrite("0", "config.ini", "Logo", "Genshin_Y")
    IniWrite("0", "config.ini", "Logo", "Honkai_X")
    IniWrite("0", "config.ini", "Logo", "Honkai_Y")
    IniWrite("0", "config.ini", "Logo", "ZZZ_X")
    IniWrite("0", "config.ini", "Logo", "ZZZ_Y")
    IniWrite("0,0", "config.ini", "Logo", "PlayGame")  ; Format "x,y"
    
    ; Section Path (string kosong)
    IniWrite("", "config.ini", "Path", "Folder")
    IniWrite("", "config.ini", "Path", "Genshin_Impact")
    
    MsgBox "File config.ini telah dibuat dengan nilai default 0.`nSilakan isi koordinat yang sesuai.", "Info", 64
}

; === BACA CONFIG.INI ===
try {
    refW := IniRead("config.ini", "Koordinat", "refWidth")
    refH := IniRead("config.ini", "Koordinat", "refHeight")
    f1X := IniRead("config.ini", "Koordinat", "f1X")
    f1Y := IniRead("config.ini", "Koordinat", "f1Y")
    f2X := IniRead("config.ini", "Koordinat", "f2X")
    f2Y := IniRead("config.ini", "Koordinat", "f2Y")
    f1X1 := IniRead("config.ini", "Koordinat", "f1X1")
    f1Y1 := IniRead("config.ini", "Koordinat", "f1Y1")
    f2X1 := IniRead("config.ini", "Koordinat", "f2X1")
    f2Y1 := IniRead("config.ini", "Koordinat", "f2Y1")
    f1X2 := IniRead("config.ini", "Koordinat", "f1X2")
    f1Y2 := IniRead("config.ini", "Koordinat", "f1Y2")
    f2X2 := IniRead("config.ini", "Koordinat", "f2X2")
    f2Y2 := IniRead("config.ini", "Koordinat", "f2Y2")
    f2X_ := IniRead("config.ini", "Koordinat", "f2X_")
    f2Y_ := IniRead("config.ini", "Koordinat", "f2Y_")
    f2X_1 := IniRead("config.ini", "Koordinat", "f2X_1")
    f2Y_1 := IniRead("config.ini", "Koordinat", "f2Y_1")
    f2X_2 := IniRead("config.ini", "Koordinat", "f2X_2")
    f2Y_2 := IniRead("config.ini", "Koordinat", "f2Y_2")
    LogoGenshin_X := IniRead("config.ini", "Logo", "Genshin_X")
    LogoGenshin_Y := IniRead("config.ini", "Logo", "Genshin_Y")
    LogoHonkai_X := IniRead("config.ini", "Logo", "Honkai_X")
    LogoHonkai_Y := IniRead("config.ini", "Logo", "Honkai_Y")
    LogoZZZ_X := IniRead("config.ini", "Logo", "ZZZ_X")
    LogoZZZ_Y := IniRead("config.ini", "Logo", "ZZZ_Y")
    PlayGame := IniRead("config.ini", "Logo", "PlayGame")  ; Tetap sebagai string "x,y"
    AcceptX := IniRead("config.ini", "Koordinat", "AcceptX")
    AcceptY := IniRead("config.ini", "Koordinat", "AcceptY")
    AcceptX_1 := IniRead("config.ini", "Koordinat", "AcceptX_1")
    AcceptY_1 := IniRead("config.ini", "Koordinat", "AcceptY_1")
    AcceptX_HSR := IniRead("config.ini", "Koordinat", "AcceptX_HSR")
    AcceptY_HSR := IniRead("config.ini", "Koordinat", "AcceptY_HSR")
    AcceptX_HSR1 := IniRead("config.ini", "Koordinat", "AcceptX_HSR1")
    AcceptY_HSR1 := IniRead("config.ini", "Koordinat", "AcceptY_HSR1")
    AcceptX_ZZZ := IniRead("config.ini", "Koordinat", "AcceptX_ZZZ")
    AcceptY_ZZZ := IniRead("config.ini", "Koordinat", "AcceptY_ZZZ")
    AcceptX_ZZZ1 := IniRead("config.ini", "Koordinat", "AcceptX_ZZZ1")
    AcceptY_ZZZ1 := IniRead("config.ini", "Koordinat", "AcceptY_ZZZ1")
    Folder := IniRead("config.ini", "Path", "Folder")
    Genshin_Impact_Path := IniRead("config.ini", "Path", "Genshin_Impact")

    ; Konversi ke integer (kecuali Folder, Genshin_Impact_Path, dan PlayGame)
    refW := Integer(refW)
    refH := Integer(refH)
    f1X := Integer(f1X)
    f1Y := Integer(f1Y)
    f2X := Integer(f2X)
    f2Y := Integer(f2Y)
    f2X_ := Integer(f2X_)
    f2Y_ := Integer(f2Y_)
    f1X1 := Integer(f1X1)
    f1Y1 := Integer(f1Y1)
    f2X1 := Integer(f2X1)
    f2Y1 := Integer(f2Y1)
    f1X2 := Integer(f1X2)
    f1Y2 := Integer(f1Y2)
    f2X2 := Integer(f2X2)
    f2Y2 := Integer(f2Y2)
    f2X_1 := Integer(f2X_1)
    f2Y_1 := Integer(f2Y_1)
    f2X_2 := Integer(f2X_2)
    f2Y_2 := Integer(f2Y_2)
    LogoGenshin_X := Integer(LogoGenshin_X)
    LogoGenshin_Y := Integer(LogoGenshin_Y)
    LogoHonkai_X := Integer(LogoHonkai_X)
    LogoHonkai_Y := Integer(LogoHonkai_Y)
    LogoZZZ_X := Integer(LogoZZZ_X)
    LogoZZZ_Y := Integer(LogoZZZ_Y)
    ; PlayGame tidak di-convert (tetap string)
    AcceptX := Integer(AcceptX)
    AcceptY := Integer(AcceptY)
    AcceptX_1 := Integer(AcceptX_1)
    AcceptY_1 := Integer(AcceptY_1)
    AcceptX_HSR := Integer(AcceptX_HSR)
    AcceptY_HSR := Integer(AcceptY_HSR)
    AcceptX_HSR1 := Integer(AcceptX_HSR1)
    AcceptY_HSR1 := Integer(AcceptY_HSR1)
    AcceptX_ZZZ := Integer(AcceptX_ZZZ)
    AcceptY_ZZZ := Integer(AcceptY_ZZZ)
    AcceptX_ZZZ1 := Integer(AcceptX_ZZZ1)
    AcceptY_ZZZ1 := Integer(AcceptY_ZZZ1)

} catch as e {
    MsgBox "Error baca config.ini:`n" e.Message "`n`nPastikan format file benar.", "Error", 16
    ExitApp
}

; === HOTKEY GENSHIN ===
#HotIf WinActive("ahk_class UnityWndClass") and Winactive("ahk_exe GenshinImpact.exe")

; F1
^F1:: {
    MouseClick("Left", f1X, f1Y)
}

^F2:: {
    MouseClick("Left", f2X, f2Y)
    sleep 1000
    MouseClick("Left", f2X_, f2Y_)
}

^F3:: {
    MouseClick("Left", AcceptX, AcceptY)
    sleep 1000
    MouseClick("Left", AcceptX_1, AcceptY_1)
}

#HotIf

; === HOTKEY HSR ===
#HotIf WinActive("ahk_class UnityWndClass") and Winactive("ahk_exe StarRail.exe")

; F1
^F1:: {
    MouseClick("Left", f1X1, f1Y1)
}

^F2:: {
    MouseClick("Left", f2X1, f2Y1)
    sleep 1000
    MouseClick("Left", f2X_1, f2Y_1)
}

^F3:: {
    MouseClick("Left", AcceptX_HSR, AcceptY_HSR)
    sleep 1000
    MouseClick("Left", AcceptX_HSR1, AcceptY_HSR1)
}

#HotIf

#HotIf

; === HOTKEY ZZZ ===
#HotIf WinActive("ahk_class UnityWndClass") and Winactive("ahk_exe ZenlessZoneZero.exe")

; F1
^F1:: {
    MouseClick("Left", f1X2, f1Y2)
}

^F2:: {
    MouseClick("Left", f2X2, f2Y2)
    sleep 1000
    MouseClick("Left", f2X_2, f2Y_2)
}

^F3:: {
    MouseClick("Left", AcceptX_ZZZ, AcceptY_ZZZ)
    sleep 1000
    MouseClick("Left", AcceptX_ZZZ1, AcceptY_ZZZ1)
}

#HotIf

; === Hotkey ===
^G:: {
    MouseClick("Left", LogoGenshin_X, LogoGenshin_Y)
    sleep 1000
    Click PlayGame
}
^H:: {
    MouseClick("Left", LogoHonkai_X, LogoHonkai_Y)
    sleep 1000
    Click PlayGame
}
^Z:: {
    MouseClick("Left", LogoZZZ_X, LogoZZZ_Y)
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