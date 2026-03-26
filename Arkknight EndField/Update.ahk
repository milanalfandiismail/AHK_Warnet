#Requires AutoHotkey v2.0
#SingleInstance Force
#Include ShinsImageScanClass.ahk

SetWorkingDir("D:\GRYPHLINK")
Run("launcher.exe")
SetWorkingDir(A_ScriptDir)

x := 0
y := 0

scan := ShinsImageScanClass()

loop {
    if scan.image("start.png", 0, &x, &y) {
        Click x, y
        Sleep 2000
        Send "{Escape}"
        break
    }
}

loop {
    if WinExist("ahk_exe EndField.exe") {
        Sleep 6000
        WinActivate
        break
    }
}

F2:: {
    if WinExist("ahk_exe Endfield.exe") {
        WinActivate
        Sleep 2000
        SetWorkingDir("D:\GRYPHLINK")
        Sleep 500
        if FileExist("games\EndField Game\mmkv\gf_login_cache") {
            FileDelete("games\EndField Game\mmkv\gf_login_cache")
        }

        if FileExist("games\EndField Game\mmkv\gf_login_cache.crc") {
            FileDelete("games\EndField Game\mmkv\gf_login_cache.crc")
        }

        Sleep 500
        ProcessClose("endfield.exe")
        ProcessClose("games.exe")
        MsgBox "Update EndField Berhasil"
        ExitApp
    }
}
