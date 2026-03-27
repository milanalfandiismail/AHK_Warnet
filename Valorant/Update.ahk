#Requires AutoHotkey v2.0
#SingleInstance Force
#Include ShinsImageScanClass.ahk

SetWorkingDir("G:\Riot Games")

x := 0
y := 0

scan := ShinsImageScanClass()

Run("launcher anti error.bat")

SetWorkingDir(A_ScriptDir)

Id := "milanalfandiismail2"
pw := "milan123qaz"

Loop {
    loop {
        Click 1280, 720
        if scan.Image("id.png", 0, &x, &y) {
            Sleep 1000
            Sleep 1000
            Click x, y
            SendInput Id
            break
        }
    }

    loop {
        if scan.Image("pw.png", 0, &x, &y) {
            Sleep 1000
            Click x, y
            SendInput pw
            Sleep 500
            Send "{Enter}"
            break
        }
    }

    loop {
        if WinExist("ahk_exe Riot Client.exe") {
            Winactive
            Sleep 30000 ; < Hardcode, karena masih tergantung kapan muncul logo play
            Click 447, 398 ; < Ini untuk melakukan click kepada play/update pada valorant, masih hardcode
            break
        }
    }

    loop {
        if !WinExist("ahk_exe Riot Client.exe") {
            ProcessClose("Riot Client.exe")
            ProcessClose("Valorant.exe")
            ProcessClose("VALORANT-Win64-Shipping.exe")
            MsgBox "Berhasil update Valorant"
            ExitApp
        }
    }
}

F2:: {
    ProcessClose("Riot Client.exe")
    ProcessClose("Valorant.exe")
    ProcessClose("VALORANT-Win64-Shipping.exe")
    ExitApp
}
