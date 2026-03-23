#Requires AutoHotkey v2.0.18+
#SingleInstance Force

SetWorkingDir("G:\Crossfire PH\Crossfire PH")
Run("CFLauncher.exe")

loop {
    if WinExist("ahk_exe crossfire.exe") {
        Run("taskkill /f /im crossfire.exe")
        MsgBox "Update Cross Fire Selesai"
        break
    }
}
ExitApp