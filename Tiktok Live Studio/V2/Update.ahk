#Requires AutoHotkey v2.0
#SingleInstance Force
SetWorkingDir "G:\Aplikasi\Tiktok Live Studio"
Run "G:\Aplikasi\Tiktok Live Studio\launcher.bat"
SetWorkingDir A_ScriptDir

x := 0
y := 0

ScreenWidth := A_ScreenWidth
ScreenHeight := A_ScreenHeight

loop {
    if ImageSearch(&x, &y, 0, 0, ScreenWidth, ScreenHeight, A_ScriptDir "\logo.png") {
        ToolTip "Menemukan"
        Sleep 1000
        xPos := x + 20
        yPos := y + 20
        Click xPos, yPos
        break
    }
}

if ProcessExist("TikTok LIVE Studio.exe") {
    ProcessClose("TikTok LIVE Studio.exe")
    MsgBox "Selesai Update Tiktok Live Studio"
    ExitApp
}


Del:: {
    ExitApp
}
