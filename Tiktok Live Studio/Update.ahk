#Requires AutoHotkey v2.0
#SingleInstance Force
SetWorkingDir "G:\Aplikasi\Tiktok Live Studio"
Run "G:\Aplikasi\Tiktok Live Studio\launcher.bat"
SetWorkingDir A_ScriptDir
Del:: {
    Sleep 2000
    Click 1448, 227
    ExitApp
}
