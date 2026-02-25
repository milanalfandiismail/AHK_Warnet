#Requires AutoHotkey v2.0.18+
#SingleInstance Force
configPath := A_ScriptDir "\config.ini"
CoordMode "Mouse", "Screen"
CoordMode "Pixel", "Screen"
; Cek apakah file config.ini ada
if !FileExist(configPath) {
    MsgBox "File config.ini tidak ditemukan! Membuat file default..."
    
    ; Buat file config.ini default
    FileAppend "[Exit]`ntombolexit=1`ntombolexit1=1`n", configPath
    FileAppend "[Path]`nFiveM_Path=0`nFiveM_Folder=0`n", configPath
}


; Load config
try {
    tombolexit := IniRead(configPath, "Exit", "TombolExit")
    tombolexit1 := IniRead(configPath, "Exit", "TombolExit1")
    FiveM_Path := IniRead(configPath, "Path", "FiveM_Path")
    FiveM_Folder := IniRead(configPath, "Path", "FiveM_Folder")
} catch Error {
    MsgBox "Gagal membaca config: " Error
}

MsgBox "F12 = Keluar Script`nCTRL + F2 = Keluar FiveM`nDel = Keluar Script Serta Melakukan Export Regedit"
SetWorkingDir(FiveM_Folder)
Run FiveM_Path
SetWorkingDir(A_ScriptDir)


; Hotkey keluar
F12:: ExitApp

; Hotkey exit game
^F2:: {
    Sleep 5000
    Click tombolexit
    Sleep 5000
    Click tombolexit1
}
Del:: {
    Sleep 2000
    try Run 'cmd /c reg export "HKLM\SOFTWARE\WOW6432Node\Rockstar Games" "' FiveM_Folder '\env.reg" /y', , "Hide"
    try Run 'cmd /c reg export "HKLM\SYSTEM\ControlSet001\Services\Rockstar Service" "' FiveM_Folder '\service.reg" /y', , "Hide"
    ExitApp
}
