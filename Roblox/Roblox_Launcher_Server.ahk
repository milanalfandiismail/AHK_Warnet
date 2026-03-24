#NoEnv
#SingleInstance Force
#Persistent

Del:: ExitApp

SetWorkingDir %A_ScriptDir%
SetTimer, AutoClose, 2000 ; Cek setiap 0.5 detik agar tidak berat

IfExist, ROBLOX LAUNCHER.bat
{
    Run, "ROBLOX LAUNCHER.bat"
}
else
{
    MsgBox, 16, Error, Zlauncher.exe tidak ditemukan!
    ExitApp
}

#Persistent
SetTimer, AutoClose, 500 ; Cek setiap 0.5 detik

AutoClose:
; Deteksi jika jendela Roblox aktif
IfWinActive, ahk_exe RobloxPlayerBeta.exe
{
    ; Koordinat tombol exit (sesuaikan dengan posisi tombol X di Roblox)
    TargetX := 1575
    TargetY := 6
    
    Sleep, 5000
    ; Klik kiri pada koordinat tersebut
    ; Click, %TargetX%, %TargetY% Left, 1
    
    ; Tunggu sebentar setelah klik
    ; Sleep, 1000
    
    ; Tutup process Roblox
    Process, Close, RobloxPlayerBeta.exe
    
    ; Alternatif: jika ingin menutup jendela saja (bukan process)
    WinClose, ahk_exe RobloxPlayerBeta.exe
    
    ; Alternatif: jika ingin memaksa tutup
    WinKill, ahk_exe RobloxPlayerBeta.exe

    ExitApp
}
