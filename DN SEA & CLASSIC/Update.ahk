#Requires AutoHotkey v2.0
#SingleInstance Force
#Include ShinsImageScanClass.ahk

x := 0
y := 0
scan := ShinsImageScanClass()

MsgBox "Esc : DN Sea  `nF1 : Dn Classic `nCtrl + Enter : Start/Update `nF2 : Keluar Game & Keluar Script"

SetWorkingDir("G:\Dragon Nest Sea\DNSEA")
Run("DNLauncher.exe")
SetWorkingDir(A_ScriptDir)

Esc:: { ; Dn Sea
    loop {
        if scan.image("logo.png", 0, &x, &y) {
            yPos := y - 450 ; Hardcode untuk nilai pengurangan
            click x, yPos
            break
        }
    }
}

^Enter:: { ; Tombol Update/Start
    loop {
        if scan.Image("logo.png", 0, &x, &y) {
            xPos := x + 900 ; Hardcode untuk nilai
            yPos := y - 100 ; Hardcode untuk nilai
            Click xPos, yPos
            break
        }
    }
}

F1:: { ; Dn Classic
    loop {
        if scan.image("logo.png", 0, &x, &y) {
            yPos := y - 380 ; < Hardcode untuk nilai pengurangan
            Click x, yPos
            break
        }
    }
}

f2:: {
    ProcessClose("DNLauncher.exe")
    ExitApp
}
