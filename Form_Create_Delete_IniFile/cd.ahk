#Requires AutoHotkey v2.0

^+A:: {
; Nama file INI yang akan diisi
IniFile := "config.ini"

; Buat GUI
MyGui := Gui()
MyGui.Title := "Pengisi File INI"
MyGui.Opt("+AlwaysOnTop")

; Label judul
MyGui.Add("Text", "x10 y10", "Isi key yang diperlukan:")

; Input untuk Section
MyGui.Add("Text", "x10 y40 w80", "Nama Section:")
SectionEdit := MyGui.Add("Edit", "x100 y40 w200 vSection", "Section1")

; Input untuk Key
MyGui.Add("Text", "x10 y70 w80", "Nama Key:")
KeyEdit := MyGui.Add("Edit", "x100 y70 w200 vKey", "Key1")

; Input untuk Value
MyGui.Add("Text", "x10 y100 w80", "Value:")
ValueEdit := MyGui.Add("Edit", "x100 y100 w200 vValue")

; Tombol Simpan
BtnSimpan := MyGui.Add("Button", "x120 y140 w100 Default", "Simpan")
BtnSimpan.OnEvent("Click", SimpanConfig)

; Tombol Batal
BtnBatal := MyGui.Add("Button", "x230 y140 w100", "Batal")
BtnBatal.OnEvent("Click", (*) => MyGui.Destroy())

; Tampilkan GUI
MyGui.Show("w350 h190")

; Fungsi untuk menyimpan ke file INI
SimpanConfig(*)
{
    ; Ambil nilai dari GUI
    Saved := MyGui.Submit()
    
    ; Validasi
    if Saved.Section = "" or Saved.Key = ""
    {
        MsgBox("Section dan Key tidak boleh kosong!", "Error", "48")
        return
    }
    
    ; Simpan ke file INI
    IniWrite(Saved.Value, IniFile, Saved.Section, Saved.Key)
    
    ; Notifikasi sukses
    MsgBox("Data berhasil disimpan ke " . IniFile . "`n`nSection: " . Saved.Section . "`nKey: " . Saved.Key . "`nValue: " . Saved.Value, "Sukses", "T64")
    
    ; Kosongkan field Value aja, biar gampang isi next key
    ValueEdit.Value := ""
    
    ; Tampilkan lagi GUI (karena MyGui.Submit() menutup GUI)
    MyGui.Show()
}
}