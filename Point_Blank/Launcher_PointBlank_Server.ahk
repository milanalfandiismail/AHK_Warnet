#NoEnv
#SingleInstance Force
SetWorkingDir %A_ScriptDir%

; Meminta hak akses Administrator secara otomatis
if not A_IsAdmin
{
    Run *RunAs "%A_ScriptFullPath%"
    ExitApp
}

; Mengatur mode koordinat agar sesuai dengan layar (0,0 adalah pojok kiri atas monitor)
CoordMode, Pixel, Screen
CoordMode, Mouse, Screen

; --- Menjalankan ZLauncher Server ---
Run, reg import "Pointblank.reg", , Hide
Run, reg import "Z-Launcher.reg", , Hide

IfExist, Zlauncher.exe
{
    Run, Zlauncher.exe
}
else
{
    MsgBox, 16, Error, Zlauncher.exe tidak ditemukan!
    ExitApp
}

; --- Pengecekan Gambar Setelah Zlauncher Jalan ---
Loop
{
    ImageSearch, FoundX, FoundY, 0, 0, 1920, 1080, C:\Users\Administrator\AppData\Roaming\MacroCreator\Screenshots\Screen_20260222230603.png
    if (ErrorLevel = 0)
    {
        ; Jika gambar ditemukan, keluar dari loop pengecekan gambar
        break
    }
    Sleep, 500
}

; --- Proses Login ---
id := "mildah9"
pw := "milan123qaz"

Click, 1180, 795, Left, 1
Sleep, 500
Click, 796, 497, Left, 1
Send, %id%
Sleep, 500
Click, 791, 548, Left, 1
Send, %pw%
Sleep, 500
Send, {Enter} ; Buka tanda titik koma di awal jika ingin otomatis tekan Enter

; --- Loop Pengecekan PointBlank.exe ---
Loop
{
    Process, Exist, PointBlank.exe
    if (ErrorLevel != 0)
    {
        Process, Close, PointBlank.exe
        Sleep, 500
        break
    }
    Sleep, 1000
}

; --- Selesai & Tutup ZLauncher ---
Process, Exist, Zlauncher.exe
if (ErrorLevel != 0)
{
    Process, Close, Zlauncher.exe
}

; --- Melakukan Export Registry ---
RegKey1 := "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Z-Launcher(ID)"
RegKey2 := "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Point Blank ID"

RunWait, %ComSpec% /c reg export "%RegKey1%" "Z-Launcher.reg" /y, , Hide
RunWait, %ComSpec% /c reg export "%RegKey2%" "PointBlank.reg" /y, , Hide

MsgBox, 64, Done, Proses Selesai & Registry Berhasil di-Export!
ExitApp