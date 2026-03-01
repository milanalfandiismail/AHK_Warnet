; This script was created using Pulover's Macro Creator
; www.macrocreator.com

#NoEnv
#UseHook On
SetWorkingDir %A_ScriptDir%
CoordMode, Mouse, Screen
SendMode Input
#SingleInstance Force
SetTitleMatchMode 2
#WinActivateForce
SetControlDelay 1
SetWinDelay 0
SetKeyDelay -1
SetMouseDelay -1
SetBatchLines -1


; ============================
; Info Hotkey
; ============================
MsgBox, 
(
Daftar Hotkey:
----------------------------
Ctrl+Alt+A : Tambah koordinat (simpan posisi mouse saat ini ke PC)
Ctrl+Alt+D : Hapus koordinat dari PC
Ctrl+Alt+U : Gunakan koordinat (pindah mouse ke PC + klik kanan)

Mode Khusus (^F11 untuk toggle):
  ^F12 : Membuat Member (form input Nama, ID, Password)
  ^m   : Isi Member (input nama, lalu klik di form)
  ^Del : Klik di koordinat tertentu (fixed)

Navigasi Mouse:
  Shift + Arrow : Gerakkan mouse 10px
  Shift+Enter   : Klik kiri
  Shift+Backspace : Klik kanan

CTRL+1..5 : Klik kiri di lokasi fixed (558,510 dll)
CTRL+Enter: Klik kiri di lokasi fixed (987,718)

F12 : Keluar aplikasi

File koordinat tersimpan di: coordinates.ini
)


; ============================
; Membuat file coordinates.ini
; =============================
IniFile := A_ScriptDir . "\coordinates.ini"
; Pastikan file INI ada, buat jika belum
if !FileExist(IniFile)
{
    ; Buat file kosong dengan FileOpen
    file := FileOpen(IniFile, "w")
    if IsObject(file)
        file.Close()
    else
        MsgBox, Gagal membuat file coordinates.ini. Pastikan folder dapat ditulis.
}

; =========================
;        MODE SYSTEM
; =========================
mode_khusus := false

; set default icon (normal)
Menu, Tray, Icon, %A_ScriptDir%\normal.ico
Menu, Tray, Tip, MODE NORMAL

^F11::
    mode_khusus := !mode_khusus

    if (mode_khusus)
    {
        Menu, Tray, Icon, %A_ScriptDir%\special.ico
        Menu, Tray, Tip, MODE KHUSUS AKTIF
    }
    else
    {
        Menu, Tray, Icon, %A_ScriptDir%\normal.ico
        Menu, Tray, Tip, MODE NORMAL
    }
return

; =========================
; System Close
; =========================
F12:: ExitApp

; =========================
;     KOORDINAT INI
; =========================
; Hotkey untuk menambah koordinat (Ctrl+Alt+A)
#if !mode_khusus
IniFile := A_ScriptDir . "\coordinates.ini"
^!a::
    MouseGetPos, x, y
    InputBox, PC, Tambah Koordinat, Masukkan nomor PC (1-20):, , 200, 150
    if ErrorLevel
        return
    ; Validasi PC adalah angka
    if PC is not digit
    {
        MsgBox, Nomor PC harus angka.
        return
    }
    ; Simpan ke INI (gunakan backtick sebelum koma)
    IniWrite, %x%`,%y%, %IniFile%, PCs, %PC%
    MsgBox, Koordinat (%x%, %y%) disimpan untuk PC %PC%.
return

; Hotkey untuk menghapus koordinat (Ctrl+Alt+D)
^!d::
    InputBox, PC, Hapus Koordinat, Masukkan nomor PC yang akan dihapus:, , 200, 150
    if ErrorLevel
        return
    if PC is not digit
    {
        MsgBox, Nomor PC harus angka.
        return
    }
    IniDelete, %IniFile%, PCs, %PC%
    MsgBox, PC %PC% telah dihapus.
return

; Hotkey untuk menggunakan koordinat (Ctrl+Alt+U)
^!u::
    InputBox, PC, Gunakan Koordinat, Masukkan nomor PC:, , 200, 150
    if ErrorLevel
        return
    if PC is not digit
    {
        MsgBox, Nomor PC harus angka.
        return
    }
    IniRead, koord, %IniFile%, PCs, %PC%, NOTFOUND
    if (koord = "NOTFOUND")
    {
        MsgBox, PC %PC% tidak ditemukan.
        return
    }
    ; Pisahkan x dan y menggunakan StrSplit
    xy := StrSplit(koord, ",")
    if (xy.Length() < 2)
    {
        MsgBox, Format koordinat salah.
        return
    }
    MouseMove, xy[1], xy[2], 0
    Sleep, 50
    Click right
return
#if

#If mode_khusus
    ; === Bagian Membuat Member ===
    ^F12::
    Membuat_Member:
        Gui, Destroy
        Gui, Add, Text,, Nama:
        Gui, Add, Edit, vNama w500

        Gui, Add, Text,, ID:
        Gui, Add, Edit, vID w500

        Gui, Add, Text,, Password:
        Gui, Add, Edit, vPassword w500 Password

        Gui, Add, Button, gSubmit, OK
        Gui, Show,, Form Input
    Return

    Submit:
        Gui, Submit
        Gui, Destroy

        Sleep, 2000
        Click, 443, 42 Left, 1
        Sleep, 3000
        Click, 463, 107 Left, 1
        Sleep, 1000
        Click, 586, 298 Left, 1
        Sleep, 1000
        Click, 354, 866 Left, 1
        Sleep, 1000
        Click, 805, 394 Left, 1
        Send, {Text}%Nama%
        Sleep, 1000
        Click, 805, 426 Left, 1
        Send, {Text}%ID%
        Sleep, 1000
        Click, 800, 453 Left, 1
        Send, {Text}%Password%
        Sleep, 1000
        Click, 804, 481 Left, 1
        Send, {Text}%Password%
        Sleep, 1000
        Click, 877, 786 Left, 1
        Sleep, 1000
        MsgBox, Member telah dibuat `nNama: %Nama%` `nID: %ID%
    Return
    ^Del::Click, 1281, 260 Left, 1
#If

#If mode_khusus
    ; =========================
    ;   CTRL+M = Isi Member
    ; =========================
    ^m::
        InputBox, DataInput, Isi Form, Silakan masukkan Nama Member yang ingin diisi:, , 300, 150
        if (ErrorLevel)
            return

        Click, 331, 74
        Sleep, 300

        Click, 663, 438
        Sleep, 100

        Click, 779, 436
        Send, ^a
        Sleep, 50
        Send, {Backspace}
        Sleep, 50

        Send, %DataInput%
        Sleep, 1000

        Click, 896, 436
    return

    ; =========================
    ;   CTRL + 1 - 0 (10 Lokasi)
    ; =========================

    ^1::Click, 558, 510 Left, 1
    ^2::Click, 560, 535 Left, 1
    ^3::Click, 559, 554 Left, 1
    ^4::Click, 561, 574 Left, 1
    ^5::Click, 559, 593 Left, 1
    ^Enter:: Click, 987, 718 Left, 1
    ^9::Click, X9, Y9
    ^0::Click, X10, Y10

#If

; ====== SHIFT + ARROW NAVIGASI MOUSE ======
jarak := 15

+Up::MouseMove, 0, -10, 0, R
+Down::MouseMove, 0, 10, 0, R
+Left::MouseMove, -10, 0, 0, R
+Right::MouseMove, 10, 0, 0, R

+Enter::Click
+Backspace::Click Right