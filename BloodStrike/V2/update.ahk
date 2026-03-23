#Requires AutoHotkey v2.0
#SingleInstance Force
#Include ShinsImageScanClass.ahk

x := 0
y := 0
ScreenWidth := A_ScreenWidth
ScreenHeight := A_ScreenHeight

scan := ShinsImageScanClass()

SetWorkingDir("G:\bloodstrike\bloodstrike")
Run("launcher.exe")
SetWorkingDir(A_ScriptDir)

loop {
    if WinExist("ahk_exe Bloodstrike.exe") {
        WinActivate

        if scan.Image("google.png", 30, &x, &y) {
            ProcessClose("Bloodstrike.exe")
            MsgBox "Berhasil update Bloodstrike"
            break
        }
    }
}

ExitApp