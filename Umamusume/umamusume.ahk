#Requires AutoHotkey v2.0
#SingleInstance Force
#Include ShinsImageScanClass.ahk

Del:: ExitApp

Run("steam://rungameid/3224770")

SetWorkingDir(A_ScriptDir)

x := 0
y := 0
scan := ShinsImageScanClass(0)

loop {
    if scan.image("start.png", 0, &x, &y) {
        Sleep 2000
        xPos := x - 50
        yPos := y - 50
        Click xPos, yPos
        break
    }
}
loop {
    if WinExist("ahk_exe UmamusumePrettyDerby.exe") {
        WinActivate
        break
    }
}

f2:: {
    Sleep 2000
    ProcessClose("UmamusumePrettyDerby.exe")
    ExitApp
}
