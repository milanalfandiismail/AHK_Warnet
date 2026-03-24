#Requires AutoHotkey v2.0
#SingleInstance Force
SetWorkingDir "G:\Zepetto\Z-Launcher(ID)"

CoordMode "Pixel", "Screen"
CoordMode "Mouse", "Screen"

; Ambil resolusi layar
ScreenWidth := A_ScreenWidth
ScreenHeight := A_ScreenHeight

x := 0
y := 0

Del:: ExitApp

; --- Menjalankan ZLauncher Server ---
Run("reg import Pointblank.reg", , "Hide")
Run("reg import Z-Launcher.reg", , "Hide")

Sleep 500

Run("G:\Zepetto\Z-Launcher(ID)\ZLauncher.exe")

Loop {
    ; ImageSearch mengembalikan True jika ditemukan, False jika tidak
    if ImageSearch(&x, &y, 0, 0, ScreenWidth, ScreenHeight, A_ScriptDir "\start.png") {
        ToolTip "Found at: " x ", " y
        Sleep 1000
        ToolTip
        
        xPos := x + 20
        yPos := y + 20

        Click xPos, yPos
        break
    } else {
        ToolTip "Searching..."
    }
    
    Sleep 500
}

id := "mildah9"
pw := "milan123qaz"

Click 943, 443
Sleep 500
Send id
Sleep 500
Click 942, 491
Sleep 500
Send pw
Sleep 500
Send "{Enter}"
Sleep 500

loop {
    if (PID := ProcessExist("Pointblank.exe")) {
        Sleep 500
        ProcessClose "Pointblank.exe"
        break
    } else {
        TrayTip "Belum Menemukan Process Pointblank.exe"
    }

    Sleep 500
}

if ProcessExist("Zlauncher.exe") {
    ProcessClose("Zlauncher.exe")
    TrayTip "Selesai, close process Zlauncher.exe"
} else {
    MsgBox "Error"
}

; --- Melakukan Export Registry ---
RegKey1 := "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Z-Launcher(ID)"
RegKey2 := "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Point Blank ID"

; Gunakan single quote di luar untuk memudahkan
RunWait(A_ComSpec ' /c reg export "' RegKey1 '" "Z-Launcher.reg" /y', , 'Hide')
RunWait(A_ComSpec ' /c reg export "' RegKey2 '" "PointBlank.reg" /y', , 'Hide')

MsgBox("Proses Selesai & Registry Berhasil di-Export!", "Done", "64")
