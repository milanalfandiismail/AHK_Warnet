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



#If !mode_khusus
F1::
nomor_1:
Click, 82, 138 Right, 1
Sleep, 10
Return

F2::
nomor_2:
Click, 187, 142 Right, 1
Sleep, 10
Return

F3::
nomor_3:
Click, 296, 137 Right, 1
Sleep, 10
Return

F4::
nomor_4:
Click, 407, 143 Right, 1
Sleep, 10
Return

F5::
Macro5:
Click, 522, 143 Right, 1
Sleep, 10
Return

F6::
Macro6:
Click, 632, 141 Right, 1
Sleep, 10
Return

F7::
Macro7:
Click, 742, 137 Right, 1
Sleep, 10
Return

F8::
Macro8:
Click, 844, 140 Right, 1
Sleep, 10
Return

F9::
Macro9:
Click, 951, 140 Right, 1
Sleep, 10
Return

F10::
Macro10:
Click, 1069, 142 Right, 1
Sleep, 10
Return

+F1::
Macro11:
Click, 87, 229 Right, 1
Sleep, 10
Return

+F2::
Macro12:
Click, 192, 226 Right, 1
Sleep, 10
Return

+F3::
Macro13:
Click, 297, 227 Right, 1
Sleep, 10
Return

+F4::
Macro14:
Click, 402, 228 Right, 1
Sleep, 10
Return

+F5::
Macro15:
Click, 526, 223 Right, 1
Sleep, 10
Return

+F6::
Macro16:
Click, 627, 229 Right, 1
Sleep, 10
Return

+F7::
Macro17:
Click, 737, 227 Right, 1
Sleep, 10
Return

+F8::
Macro18:
Click, 841, 231 Right, 1
Sleep, 10
Return

+F9::
Macro19:
Click, 956, 223 Right, 1
Sleep, 10
Return

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

/*
; ====== CTRL + ARROW NAVIGASI MOUSE ======

jarak := 10

^Up::MouseMove, 0, -10, 0, R
^Down::MouseMove, 0, 10, 0, R
^Left::MouseMove, -10, 0, 0, R
^Right::MouseMove, 10, 0, 0, R

^Enter::Click
^Backspace::Click Right
*/

; ====== SHIFT + ARROW NAVIGASI MOUSE ======
jarak := 15

+Up::MouseMove, 0, -10, 0, R
+Down::MouseMove, 0, 10, 0, R
+Left::MouseMove, -10, 0, 0, R
+Right::MouseMove, 10, 0, 0, R

+Enter::Click
+Backspace::Click Right



