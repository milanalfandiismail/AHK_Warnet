#Requires AutoHotkey v2.0+
#SingleInstance Force
#Include ShinsImageScanClass.ahk

x := 0
y := 0
scan := ShinsImageScanClass()

Del:: ExitApp

SetWorkingDir("G:\FIVEM")


Run('cmd /c reg import "service.reg"', , "RunAs")
Run('cmd /c reg import "env.reg"', , "RunAs")

Run('cmd /c mklink /j "C:\Program Files\Rockstar Games" "G:\FIVEM\Program Files\Rockstar Games"', , "RunAs")
Run('cmd /c mklink /j "C:\Program Files (x86)\Rockstar Games" "Program Files x86\Rockstar Games"', , "RunAs")
Run('cmd /c mklink /j "%programdata%\Rockstar Games" "ProgramData\Rockstar Games"', , "RunAs")
Run('cmd /c mklink /j "%appdata%\CitizenFX" "Config"', , "RunAs")
Run('cmd /c mklink /j "%localappdata%\Rockstar Games" "localappdata\Rockstar Games" >nul 2>&1', , "RunAs")

Sleep 1000
Run("Fivem.exe")


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


