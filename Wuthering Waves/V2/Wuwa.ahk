#Requires AutoHotkey v2.0
#SingleInstance Force
#Include ShinsImageScanClass.ahk

x := 0
y := 0
ScreenWidth := A_ScreenWidth
ScreenHeight := A_ScreenHeight

scan := ShinsImageScanClass(0)

SetWorkingDir("G:\Wuthering Waves")
Run("launcher.exe")
SetWorkingDir(A_ScriptDir)

loop {
    if WinExist("ahk_exe launcher_main.exe") {
        WinActivate

        if scan.Image("start.png", 0, &x, &y) {
            Sleep 5000
            Click x, y
            break
        } else {
            Tooltip "Mencari Gambar Start"
            sleep 1000
            Tooltip
        }
    }
}

loop {
    if WinExist("ahk_exe Client-Win64-Shipping.exe.exe") {
        Sleep 1000
        WinActivate
        break
    }
}

#HotIf WinExist("ahk_exe Client-Win64-Shipping.exe") 

F1:: {
    Click 1280, 720
}
F2:: {
    ProcessClose("Client-Win64-Shipping.exe")
    ProcessClose("launcher_main.exe")
    ExitApp
}
#HotIf

Del:: ExitApp