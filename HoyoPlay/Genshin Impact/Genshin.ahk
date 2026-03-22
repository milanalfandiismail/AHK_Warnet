#Requires AutoHotkey v2.0
#SingleInstance Force
#Include ShinsImageScanClass.ahk
#Include OCR.ahk

x := 0
y := 0
ScreenWidth := A_ScreenWidth
ScreenHeight := A_ScreenHeight

scan := ShinsImageScanClass(0)

SetWorkingDir("G:\HoYoPlay")
Run("run_server.bat")
SetWorkingDir(A_ScriptDir)

MsgBox "F1 = Start Game `nF2 = Exit Game `nDEL= Exit Script"

loop {
    if WinExist("ahk_exe HYP.exe") {
        WinActivate

        if scan.Image("genshin.png", 0, &x, &y) or scan.Image("genshin1.png", 0, &x, &y) {
            Sleep 5000
            Click x, y
            break
        } else {
            Tooltip "Mencari Gambar Genshin"
            Sleep 1000
            Tooltip
        }
    }
    Sleep 1000
}

loop {
    if WinExist("ahk_exe HYP.exe") {
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
    if WinExist("ahk_exe GenshinImpact.exe") {
        Sleep 1000
        WinActivate
        break
    }
}

#HotIf WinExist("ahk_class UnityWndClass") and WinExist("ahk_exe GenshinImpact.exe") 

F1:: {
    Click 1280, 720
}
F2:: {
    ProcessClose("GenshinImpact.exe")
    ProcessClose("HYP.exe")
    ExitApp
}
#HotIf

Del:: ExitApp