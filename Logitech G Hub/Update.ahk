#Requires AutoHotkey v2.0


Run('cmd.exe /c "G:\LOGITECH\LGHUB launcher.bat"')
SetWorkingDir A_ScriptDir
CoordMode "Mouse", "Screen"
CoordMode "Pixel", "Screen"

F2:: {
    ProcessClose("lghub.exe")
	ProcessClose("lghub_agent.exe")
	ProcessClose("lghub_system_tray.exe")
	Run('cmd.exe /c "net stop LGHUBUpdaterService"')
	MsgBox "Berhasil update LGHUB"
    ExitApp
}

