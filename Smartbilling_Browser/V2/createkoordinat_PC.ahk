#Requires AutoHotkey v2.0
#SingleInstance Force

f11:: CreateDeleteIni

CreateDeleteIni(*) {
    ; Nama file INI yang akan diisi
    IniFile := "koordinat.ini"
    
    ; Buat GUI
    MyGui := Gui()
    MyGui.Title := "Simpan Posisi Mouse ke INI"
    MyGui.Opt("+AlwaysOnTop")
    
    ; Label judul
    MyGui.Add("Text", "x10 y10", "Simpan koordinat mouse ke file INI:")
    
    ; Input untuk Nama PC/Section
    MyGui.Add("Text", "x10 y40 w80", "Nama PC:")
    SectionEdit := MyGui.Add("Edit", "x100 y40 w200 vSection", "PC-1")
    
    ; Tampilkan posisi mouse realtime
    MyGui.Add("Text", "x10 y70 w80", "Posisi Mouse:")
    MousePosText := MyGui.Add("Text", "x100 y70 w200", "Gerakkan mouse...")
    
    ; Tombol Simpan (ambil posisi current)
    BtnSimpan := MyGui.Add("Button", "x120 y110 w100 Default", "Simpan Posisi")
    BtnSimpan.OnEvent("Click", SimpanPosisiMouse)
    
    ; Tombol Batal/Tutup
    BtnBatal := MyGui.Add("Button", "x230 y110 w100", "Tutup")
    BtnBatal.OnEvent("Click", TutupGui)
    
    ; Event untuk close button (X)
    MyGui.OnEvent("Close", TutupGui)
    
    ; Timer untuk update posisi mouse - panggil setelah fungsi didefinisikan
    UpdateMousePosition() {
        if MyGui.Hwnd {
            MouseGetPos(&mx, &my)
            MousePosText.Value := "X: " mx ", Y: " my
        }
    }
    
    ; Set timer setelah fungsi didefinisikan
    SetTimer(UpdateMousePosition, 100)
    
    ; Tampilkan GUI
    MyGui.Show("w350 h160")
    
    ; Fungsi untuk menyimpan posisi mouse
    SimpanPosisiMouse(*)
    {
        ; Ambil nilai dari GUI
        Saved := MyGui.Submit()
        
        ; Validasi
        if Saved.Section = ""
        {
            MsgBox("Nama PC tidak boleh kosong!", "Error", "48")
            MyGui.Show()
            return
        }
        
        ; Ambil posisi mouse terkini
        MouseGetPos(&mx, &my)
        koord := mx . "," . my
        
        ; Simpan ke file INI dengan format kor=x,y
        IniWrite(koord, IniFile, Saved.Section, "kor")
        
        ; Notifikasi sukses
        MsgBox("Koordinat berhasil disimpan ke " . IniFile . "`n`nSection: " . Saved.Section . "`nkor = " . koord, "Sukses", "T64")
        
        ; Buka lagi GUI untuk input berikutnya
        MyGui.Show()
    }
    
    ; Fungsi untuk menutup GUI dan membersihkan timer
    TutupGui(*)
    {
        ; Matikan timer dulu
        SetTimer(UpdateMousePosition, 0)
        ; Destroy GUI
        MyGui.Destroy()
    }
}