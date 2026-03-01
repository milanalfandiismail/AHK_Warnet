#Requires AutoHotkey v2.0
#SingleInstance Force
#Include ShinsImageScanClass.ahk

; ==============================
; INIT
; ==============================

configPath := A_ScriptDir "\config.ini"

nama_file_gambar := IniRead(configPath, "File_Gambar", "File_Gambar", "Default")
nama_file_gambar2 := IniRead(configPath, "File_Gambar", "File_Gambar2", "Default")
nama_folder := IniRead(configPath, "Folder_Path", "Folder_Path", "Default")
nama_file_exe := IniRead(configPath, "File_Exe_Path", "File_Exe", "Default")

scan := ShinsImageScanClass(0)

CoordMode("ToolTip", "Screen")
tooltipX := A_ScreenWidth - 150
tooltipY := 10

SetWorkingDir(nama_folder)
Run nama_file_exe
SetWorkingDir(A_ScriptDir)

F12:: ExitApp

; ==============================
; LOOP PROGRESS 2 STEP
; ==============================

step := 1
attempt := 0
lastText := ""

loop {
    attempt++

    ; ===================================
    ; STEP 1 - Cari Gambar Pertama
    ; ===================================
    if (step = 1) {
        currentText := "PROGRESS: STEP 1 / 2`n..."
        if (currentText != lastText) {
            ToolTip currentText, tooltipX, tooltipY
            lastText := currentText
        }
        if scan.Image(nama_file_gambar, 30, &x, &y) {

            scan.GetImageDimensions(nama_file_gambar, &w, &h)

            centerX := x + (w // 2)
            centerY := y + (h // 2)

            currentText := "Gambar Ditemukan `n..."
            if (currentText != lastText) {
                ToolTip currentText, tooltipX, tooltipY
                lastText := currentText
            }

            Click("Right", centerX, centerY)
            Sleep 1200

            step := 2
            attempt := 0
        }
    }

    ; ===================================
    ; STEP 2 - Cari Gambar Kedua
    ; ===================================
    else if (step = 2) {

        currentText := "PROGRESS: STEP 2 / 2`n..."
        if (currentText != lastText) {
            ToolTip currentText, tooltipX, tooltipY
            lastText := currentText
        }
        Sleep 1000

        if scan.Image(nama_file_gambar2, 0, &x2, &y2) {

            scan.GetImageDimensions(nama_file_gambar2, &w2, &h2)

            ExitX := x2 + (w2 // 2)
            ExitY := y2 + (h2 // 2)

            currentText := "Gambar Ditemukan`n..."
            if (currentText != lastText) {
                ToolTip currentText, tooltipX, tooltipY
                lastText := currentText
            }

            Click("Left", ExitX, ExitY)
            Sleep 1000
            break
        }
    }

    Sleep 150
}

ToolTip
ExitApp