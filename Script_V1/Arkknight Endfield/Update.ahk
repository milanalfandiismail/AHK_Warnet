#Requires AutoHotkey v2.0.18+
#SingleInstance Force
configPath := A_ScriptDir "\config.ini"
CoordMode "Mouse", "Screen"
CoordMode "Pixel", "Screen"
; Cek apakah file config.ini ada
if !FileExist(configPath) {
    MsgBox "File config.ini tidak ditemukan! Membuat file default..."

    ; Buat file config.ini default
    FileAppend "[Start]`nTombolStart=F1`nTombolStart1=1`n", configPath
    FileAppend "[Exit]`nTombolExit=F12`nTombolExit1=1`nTombolClose=2`n", configPath
    FileAppend "[Path]`nEndfield_Path=0`nEndField_Folder=0`n", configPath
}

; Load config
try {
    tombolstart := IniRead(configPath, "Start", "TombolStart")
    tombolstart1 := IniRead(configPath, "Start", "TombolStart1")
    tombolexit := IniRead(configPath, "Exit", "TombolExit")
    tombolexit1 := IniRead(configPath, "Exit", "TombolExit1")
    tombolclose := IniRead(configPath, "Exit", "TombolClose")
    endfield_Path := IniRead(configPath, "Path", "Endfield_Path")
    endfield_Folder := IniRead(configPath, "Path", "Endfield_Folder")

} catch Error {
    MsgBox "Gagal membaca config: " Error
}
MsgBox "CTRL + F1 = Auto Start`nCTRL + F2 = Auto Exit Game`nDel = Keluar dari Game`nF12 = Keluar dari Script"
SetWorkingDir(endfield_Folder)
Run endfield_Path
SetWorkingDir(A_ScriptDir)

^F1:: {
    Click tombolstart
    Sleep 1000
    Click tombolstart1
}

^F2::{
    Click tombolexit
    Sleep 1500
    Click tombolexit1
}

Del:: {
    Click tombolclose
    basePath := endfield_Folder "\games\EndField Game\mmkv\"
    try FileDelete basePath "gf_login_cache"
    try FileDelete basePath "gf_login_cache.crc"
    Sleep 1000
}

F12:: ExitApp
