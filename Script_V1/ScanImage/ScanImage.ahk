#Requires AutoHotkey v2.0
#SingleInstance Force
#Include ShinsImageScanClass.ahk

x := 0
y := 0
w := 0
h := 0
scan := ShinsImageScanClass(0)

; ToolTip di posisi tetap (pojok kanan bawah biar ga ganggu)
tooltipX := A_ScreenWidth - 350  ; 350 pixel dari kanan
tooltipY := A_ScreenHeight - 150  ; 150 pixel dari bawah

; ToolTip awal - posisi tetap
ToolTip "MENCARI GAMBAR test.png...`n"
       . "========================`n"
       . "Status: Mencari...`n"
       . "Percobaan: 0`n"
       . "========================`n"
       . "Tekan F12 untuk STOP", tooltipX, tooltipY

; Hotkey untuk stop
F12:: ExitApp

Loop {
    if scan.Image("test.png", 30, &x, &y) {
        ; Gambar ditemukan - update ToolTip di posisi yang SAMA
        ToolTip "√ GAMBAR DITEMUKAN! √`n"
               . "========================`n"
               . "Status: MENGAMBIL DIMENSI`n"
               . "Percobaan: " A_Index "`n"
               . "========================`n"
               . "Mohon tunggu...", tooltipX, tooltipY
        Sleep 500
        
        ; Dapatkan ukuran gambar
        scan.GetImageDimensions("test.png", &w, &h)
        
        ; Hitung posisi tengah
        centerX := x + (w // 2)
        centerY := y + (h // 2)
        
        ; Update ToolTip dengan informasi - posisi TETAP
        ToolTip "✓ GAMBAR: " w "x" h " ✓`n"
               . "========================`n"
               . "Kiri atas: " x "," y "`n"
               . "Tengah: " centerX "," centerY "`n"
               . "========================`n"
               . "MENGKLIK...", tooltipX, tooltipY
        Sleep 500
        
        ; Klik di tengah
        Click("Right",centerX, centerY)
        Sleep 1000

        ExitX := x - 80
        ExitY := y - 15
        Click("Left", ExitX, ExitY)
        
        ; ToolTip sukses - posisi TETAP
        ToolTip "✓✓✓ BERHASIL! ✓✓✓`n"
               . "========================`n"
               . "Posisi klik: " centerX "," centerY "`n"
               . "Percobaan: " A_Index "`n"
               . "========================`n"
               . "SCRIPT SELESAI!", tooltipX, tooltipY
        Sleep 3000
        
        ; MsgBox tetap ada
        MsgBox "SUKSES!`n`n"
               . "Gambar ukuran: " w "x" h "`n"
               . "Posisi kiri atas: " x "," y "`n"
               . "Posisi tengah: " centerX "," centerY "`n"
               . "Sudah diklik!`n"
               . "Percobaan ke: " A_index
        
        ToolTip  ; Hapus ToolTip
        break
    }
    
    ; ToolTip progress - posisi TETAP, hanya angka counter yang berubah
    ToolTip "MENCARI GAMBAR test.png...`n"
           . "========================`n"
           . "Status: Mencari...`n"
           . "Percobaan: " A_Index "`n"
           . "========================`n"
           . "Tekan F12 untuk STOP", tooltipX, tooltipY
    
    Sleep 100
}

ToolTip  ; Pastikan ToolTip hilang