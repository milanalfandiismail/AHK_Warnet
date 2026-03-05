#Requires AutoHotkey v2.0
#SingleInstance Force
#Include Gdip_All.ahk

; Init GDI+
if !(pToken := Gdip_Startup()) {
    MsgBox "GDI+ gagal dijalankan"
    ExitApp
}
OnExit((*) => Gdip_Shutdown(pToken))

; Buat folder screenshot
screenshotDir := A_ScriptDir . "\screenshot\"
if !DirExist(screenshotDir)
    DirCreate(screenshotDir)

; ============================================================
; FUNGSI SCREENSHOT
; ============================================================
AmbilScreenshot(x, y, w, h, namaFile) {
    global screenshotDir
    
    ; Validasi
    if (w <= 0 or h <= 0) {
        MsgBox "Lebar dan tinggi harus positif!"
        return 0
    }
    
    ; Format: "x|y|lebar|tinggi"
    pBitmap := Gdip_BitmapFromScreen(x "|" y "|" w "|" h)
    if !pBitmap {
        MsgBox "Gagal ambil screenshot"
        return 0
    }
    
    ; Simpan file
    timestamp := FormatTime(, "yyyy-MM-dd_HH-mm-ss")
    path := screenshotDir . namaFile
    Gdip_SaveBitmapToFile(pBitmap, path)
    Gdip_DisposeImage(pBitmap)
    
    TrayTip "Screenshot tersimpan:", path
    return path
}

; ============================================================
; CARA 1: Input Dialog Sederhana (Hotkey: Ctrl+Alt+D)
; ============================================================
^!d:: {
    ; Buat GUI input sederhana
    myGui := Gui()
    myGui.Title := "Tentukan Area Screenshot"
    
    ; Tambah input fields
    myGui.Add("Text", "xm", "X:")
    xInput := myGui.Add("Edit", "yp w100 Number", "100")
    
    myGui.Add("Text", "xm", "Y:")
    yInput := myGui.Add("Edit", "yp w100 Number", "100")
    
    myGui.Add("Text", "xm", "Lebar:")
    wInput := myGui.Add("Edit", "yp w100 Number", "300")
    
    myGui.Add("Text", "xm", "Tinggi:")
    hInput := myGui.Add("Edit", "yp w100 Number", "200")
    
    myGui.Add("Text", "xm", "Nama File (opsional):")
    namaInput := myGui.Add("Edit", "yp w200", "screenshot.png")
    
    ; Tombol
    btnOk := myGui.Add("Button", "xm w80 Default", "OK")
    btnCancel := myGui.Add("Button", "x+10 w80", "Batal")
    
    ; Event handler
    btnOk.OnEvent("Click", Submit)
    btnCancel.OnEvent("Click", (*) => myGui.Destroy())
    
    myGui.Show()
    
    Submit(*) {
        ; Ambil nilai dari input
        x := xInput.Value
        y := yInput.Value
        w := wInput.Value
        h := hInput.Value
        nama := namaInput.Value
        
        ; Validasi angka
        if !IsNumber(x) or !IsNumber(y) or !IsNumber(w) or !IsNumber(h) {
            MsgBox "Semua input harus angka!"
            return
        }
        
        ; Pakai nama default kalo kosong
        if (nama = "")
            nama := "manual.png"
        
        ; Ambil screenshot
        AmbilScreenshot(x, y, w, h, nama)
        
        ; Tutup GUI
        myGui.Destroy()
    }
}

; ============================================================
; CARA 2: Input Cepat dengan InputBox (Hotkey: Ctrl+Alt+Q)
; ============================================================
^!q:: {
    ; Tanya X
    xVal := InputBox("Masukkan koordinat X:", "X", "w200", "0")
    if xVal.Result = "Cancel"
        return
    x := xVal.Value
    
    ; Tanya Y
    yVal := InputBox("Masukkan koordinat Y:", "Y", "w200", "0")
    if yVal.Result = "Cancel"
        return
    y := yVal.Value
    
    ; Tanya Lebar
    wVal := InputBox("Masukkan lebar area:", "Lebar", "w200", "300")
    if wVal.Result = "Cancel"
        return
    w := wVal.Value
    
    ; Tanya Tinggi
    hVal := InputBox("Masukkan tinggi area:", "Tinggi", "w200", "200")
    if hVal.Result = "Cancel"
        return
    h := hVal.Value
    
    ; Ambil screenshot
    AmbilScreenshot(x, y, w, h, "input_cepat.png")
}

; ============================================================
; CARA 3: Preset dengan Hotkey Berbeda (Hotkey: Ctrl+Alt+1/2/3)
; ============================================================

; [Preset 1] Area pojok kiri atas 400x300
^!1:: {
    AmbilScreenshot(345, 146, 1200, 300, "pojok_kiri_400x300.png")
}

; [Preset 2] Area tengah layar 500x400
^!2:: {
    ; Hitung tengah layar
    x := (A_ScreenWidth - 500) // 2
    y := (A_ScreenHeight - 400) // 2
    AmbilScreenshot(x, y, 500, 400, "tengah_500x400.png")
}

; [Preset 3] Area kanan bawah 350x250
^!3:: {
    x := A_ScreenWidth - 350
    y := A_ScreenHeight - 250
    AmbilScreenshot(x, y, 350, 250, "kanan_bawah.png")
}

; Info saat skrip dijalankan
TrayTip "Auto Screenshot Manual siap!", 
    "Ctrl+Alt+D = Dialog input`nCtrl+Alt+Q = InputBox cepat`nCtrl+Alt+1/2/3 = Preset area"