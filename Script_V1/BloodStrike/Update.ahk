#Requires AutoHotkey v2.0.18+
#SingleInstance Force
CoordMode "Mouse", "Screen"
CoordMode "Pixel", "Screen"

MsgBox "CTRL + F2 = Keluar dari aplikasi"

SetWorkingDir "G:\BloodStrike\bloodstrike"
Run "G:\BloodStrike\bloodstrike\launcher.exe.lnk"
SetWorkingDir A_ScriptDir

^F2:: {
    Click 1442, 220
    Sleep 2000
    Click 774, 656
    Sleep 1000
    ExitApp
}