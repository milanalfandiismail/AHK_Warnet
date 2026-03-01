#Requires AutoHotkey v2.0.18+
#SingleInstance Force
configPath := A_ScriptDir "\config.ini"
CoordMode "Mouse", "Screen"
CoordMode "Pixel", "Screen"
; Cek apakah file config.ini ada
if !FileExist(configPath) {
    MsgBox "File config.ini tidak ditemukan! Membuat file default..."
    
    ; Buat file config.ini default
    FileAppend "[Start]`nTombolStart=F1`n", configPath
    FileAppend "[Exit]`nTombolhilang=F12`ntombolexit=1`n", configPath
    FileAppend "[Path]`nWuwa_Path=0`nWuwa_Folder=0`n", configPath
}

; Load config
try {
    tombolstart := IniRead(configPath, "Start", "TombolStart")
    tombolhilang := IniRead(configPath, "Exit", "tombolhilang")
    tombolexit := IniRead(configPath, "Exit", "TombolExit")
    Wuwa_Path := IniRead(configPath, "Path", "Wuwa_Path")
    Wuwa_Folder := IniRead(configPath, "Path", "Wuwa_Folder")
} catch Error {
    MsgBox "Gagal membaca config: " Error
}
SetWorkingDir(Wuwa_Folder)
Run Wuwa_Path
SetWorkingDir(A_ScriptDir)


; Hotkey keluar
F12:: ExitApp

; Hotkey start
^F1:: {
    Click tombolstart
}
; Hotkey exit
^F2:: {
    Click tombolexit
}
; Hotkey close
^F3:: {
    Click tombolhilang
}