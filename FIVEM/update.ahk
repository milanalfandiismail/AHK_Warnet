#Requires AutoHotkey v2.0+
#SingleInstance Force
#Include ShinsImageScanClass.ahk

x := 0
y := 0
scan := ShinsImageScanClass()

Del:: ExitApp

SetWorkingDir("G:\FIVEM")

Sleep 1000
Run("launcher-server.bat") 

loop {
    if WinExist("ahk_exe FiveM_GTAProcess.exe") {
        Sleep 5000
        ProcessClose("FiveM_GTAProcess.exe")
        break
    }
}


Run('cmd /c reg export "HKLM\SOFTWARE\WOW6432Node\Rockstar Games" "env.reg" /y', , "RunAs")
Run('cmd /c reg export "HKLM\SYSTEM\ControlSet001\Services\Rockstar Service" "service.reg" /y', , "RunAs")
MsgBox "Berhasil Update FiveM"
ExitApp


