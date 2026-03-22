#Requires AutoHotkey v2.0.18+
#SingleInstance Force
#include ShinsImageScanClass.ahk

x := 0
y := 0

scan := ShinsImageScanClass(0)  ; 0 = scan desktop

SetWorkingDir("D:\Garena Delta Force\launcher")
Run("launcher.bat")
SetWorkingDir A_ScriptDir

loop {
    if WinExist("ahk_exe df_garena_launcher.exe") {
        WinActivate
        Sleep 500

        ; CEK APAKAH GAMBAR DITEMUKAN
        if scan.Image("google.png", 30, &x, &y) {
            ;MsgBox "Ketemu Google! di koordinat: " x ", " y
            Click x, y
            Sleep 2000
            break
        } else {
            ; Optional: debug jika tidak ketemu
            ToolTip "Mencari gambar..."
            Sleep 500
            ToolTip
        }
    }
    Sleep 500
}

loop {
    if WinExist("ahk_exe service.exe") {
        WinActivate
        sleep 500
    }

    if scan.Image("email.png", 0, &x, &y) {
        ;MsgBox "Ketemu"
        id := "milan.gcenter1"
        click x, y
        Sleep 500
        Send id
        Sleep 500
        Send "{Enter}"
        break
    } else {
        ToolTip "Mencari Gambar Email"
        sleep 500
        Tooltip
    }
}

loop {
    if WinExist("ahk_exe service.exe") {
        WinActivate
        sleep 500
    }

    if scan.Image("password.png", 0, &x, &y) {
        ;MsgBox "Ketemu"
        pw := "milan123qaz!"
        xPos := x + 20
        yPos := y + 20
        click xPos, yPos
        Sleep 500
        SendText pw
        Sleep 500
        Send "{Enter}"
        break
    } else {
        ToolTip "Mencari Gambar password"
        sleep 500
        Tooltip
    }
}

Del:: {
    ; Inisialisasi scan di dalam hotkey
    scan := ShinsImageScanClass(0)

    loop {
        if WinExist("ahk_exe df_garena_launcher.exe") {
            WinActivate
            Sleep 500

            ; Nested if: cari exit.png dulu
            if scan.Image("exit.png", 50, &x, &y) {
                Click x, y
                Sleep 500
                ExitApp

            } else {
                ToolTip "Mencari tombol exit..."
                Sleep 500
                ToolTip
            }
        } else {
            ToolTip "Window tidak ditemukan..."
            Sleep 500
            ToolTip
        }

        Sleep 500  ; Delay di luar if untuk mencegah CPU 100%
    }
}
