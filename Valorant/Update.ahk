#Requires AutoHotkey v2.0.18+
#SingleInstance Force
CoordMode "Mouse", "Screen"
CoordMode "Pixel", "Screen"

MsgBox "CTRL + F1 = Auto Update Click`nCTRL + F2 = Keluar dari aplikasi"

SetWorkingDir "G:\Riot Games"
Run "G:\Riot Games\launcher anti error.bat"
SetWorkingDir A_ScriptDir



^F1:: {
    Click 1401, 952
}
^F2:: {
    Click 1552, 181
    Sleep 2000
    ExitApp
}