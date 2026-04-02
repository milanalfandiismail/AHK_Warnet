#Requires AutoHotkey v2.0
#SingleInstance Force


SetWorkingDir("G:\RobloxPortable\Roblox") ; Sesuaikan dengan path roblox nya
Run('cmd.exe /c "ROBLOX LAUNCHER.bat"') ; Kadang terjadi bug, dikarenakan menjalankan lewat .bat


Sleep 10000

Loop {
	if WinExist("ahk_exe RobloxPlayerBeta.exe") {
		ProcessClose("RobloxPlayerBeta.exe")
		break
	}
}

MsgBox "Update Roblox Berhasil"
ExitApp
