#Requires AutoHotkey v2.0.18+
#SingleInstance Force
configPath := A_ScriptDir "\config.ini"
CoordMode "Mouse", "Screen"
CoordMode "Pixel", "Screen"
; Cek apakah file config.ini ada
if !FileExist(configPath) {
    MsgBox "File config.ini tidak ditemukan! Membuat file default..."

    ; Buat file config.ini default
    FileAppend "[Start]`nTombolDownload=F1`nTombolClassic=`nTombolSea=`n", configPath
    FileAppend "[Exit]`nTombolExit=F12`n", configPath
    FileAppend "[Path]`nDN_Path=0`nDN_Folder=0`n", configPath
}

; Load config
try {
    tomboldownload := IniRead(configPath, "Start", "TombolDownload")
    tombolclassic := IniRead(configPath, "Start", "TombolClassic")
    tombolsea := IniRead(configPath, "Start", "TombolSea")
    tombolexit := IniRead(configPath, "Exit", "TombolExit")
    DN_Path := IniRead(configPath, "Path", "DN_Path")
    DN_Folder := IniRead(configPath, "Path", "DN_Folder")

} catch Error {
    MsgBox "Gagal membaca config: " Error
}
MsgBox "CTRL + F1 = Auto Start`n CTRL + F2 = Tombol Classic`n CTRL + F3 = Tombol Sea`n DEL = Exit`n F12 = Keluar Aplikasi"
SetWorkingDir(DN_Folder)
Run DN_Path
SetWorkingDir(A_ScriptDir)



^F1::{
    Click tomboldownload
}

^F2::{
    Click tombolclassic
}

^F3::{
    Click tombolsea
}

Del::{
    Click tombolexit
}

F12:: ExitApp