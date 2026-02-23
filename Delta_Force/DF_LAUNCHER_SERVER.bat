@echo off
Color a

cd /d %~dp0
start "" "google.ahk"
start "" "id.ahk"
start "" "pw.ahk"
start "" "close.ahk"

Echo [ ! ] Menjalankan Delta Force
cd /d G:\Garena Delta Force\launcher
mklink /j "%appdata%\df_garena_launcher" "G:\Garena Delta Force\launcher\appdata\df_garena_launcher"
mklink /j "%appdata%\df_garena_launcher_30029605" "G:\Garena Delta Force\launcher\appdata\df_garena_launcher_30029605"

start "" "df_garena_launcher.exe"



exit