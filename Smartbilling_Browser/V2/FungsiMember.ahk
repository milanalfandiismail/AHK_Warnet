#Requires AutoHotkey v2.0


FungsiIsiNamaMember(namaMember) {
    Click 323, 73 ; < Tombol klik Voucher Billing
    Sleep 300

    Click 821, 376 ; < Tombol klik Member di Voucher Billing
    Sleep 100

    Click 953, 377 ; < Tombol klik fieldbar member di Voucher Billing
    Send "^a"
    Sleep 50
    Send "{Backspace}"
    Sleep 50

    Send namaMember
    Sleep 1000

    Click 1057, 377 ; < Tombol cari di Voucher Billing
    ; < Fungsi buat waktu
    TrayTip("Member " namaMember " selesai")
    Sleep 1000
}

FungsiIsiWaktu_Member(waktu) {
    if waktu == "1 Jam" {
        Sleep 1000
        Click 734, 454
        Loop 10
        {
            sleep 100
            Send "{Down}"
            sleep 100
        }
        Sleep 500
        Send "{Enter}"
        Sleep 500
        Click 1147, 655
        Sleep 500
        Send "{Enter}"
        Sleep 500
        Click 1188, 700
    }
    else if waktu == "2 Jam"
        DoClickMember(waktu)
    else if waktu == "3 Jam"
        DoClickMember(waktu)
    else if waktu == "4 Jam"
        DoClickMember(waktu)
    else if waktu == "10 Jam"
        DoClickMember(waktu)
    else
        TrayTip("Waktu tidak ditemukan di server")
}



DoClickMember(waktu_member) {
    
    
}