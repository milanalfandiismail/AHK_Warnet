#Requires AutoHotkey v2.0
#SingleInstance Force
#Include ShinsImageScanClass.ahk

x := 0
y := 0
ScreenWidth := A_ScreenWidth
ScreenHeight := A_ScreenHeight

scan := ShinsImageScanClass(0)

SetWorkingDir("G:\HoYoPlay")
Run("run_server.bat")
SetWorkingDir(A_ScriptDir)

; Bagian Click Menu Game, Agara Gambar ter reconize
loop {
    if WinExist("ahk_exe HYP.exe") {
        WinActivate
        Sleep 2000
        Click 351, 803
        break
    }
}

loop {
    if WinExist("ahk_exe HYP.exe") {
        WinActivate

        if scan.Image("hsr.png", 0, &x, &y) or scan.Image("hsr1.png", 0, &x, &y) {
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
    if WinExist("ahk_exe StarRail.exe") {
        Sleep 1000
        WinActivate
        break
    }
}

#HotIf WinExist("ahk_class UnityWndClass") and WinExist("ahk_exe StarRail.exe") 

F1:: {
    Click 1280, 720
}
F2:: {
    ProcessClose("StarRail.exe")
    ProcessClose("HYP.exe")
    ExitApp
}
#HotIf

Del:: ExitApp