#Requires AutoHotkey v2.0

; Lokasi file INI (di folder yang sama dengan script)
IniFile := A_ScriptDir "\config.ini"

^!a::
{
    ; Ambil posisi mouse
    MouseGetPos &x, &y

    ; Input nama section
    SectionName := InputBox(
        "Masukkan nama section (contoh: PC1):",
        "Tambah Koordinat"
    )

    ; Kalau user cancel
    if (SectionName.Result = "Cancel")
        return

    Section := Trim(SectionName.Value)

    ; Validasi kosong
    if (Section = "")
    {
        MsgBox "Nama section tidak boleh kosong."
        return
    }

    ; Simpan X dan Y sebagai key terpisah
    IniWrite x, IniFile, Section, "x"
    IniWrite y, IniFile, Section, "y"

    MsgBox "Koordinat (" x ", " y ") disimpan di section [" Section "]."
}