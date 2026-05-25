#Requires AutoHotkey v2.0
#UseHook

#HotIf WinActive("ahk_exe WowClassic.exe") || WinActive("ahk_exe WoW.exe")

!Tab::Send "{p}"
!F4::Send "{F6}"

cancelClick := false

; =========================
; Mouse 5 (XButton2)
; =========================

$~XButton2::
{
    global cancelClick
    cancelClick := false
}

$~XButton2 up::
{
    global cancelClick
    if !cancelClick
    {
        SendInput "{RButton}"
        sleep 50
        SendInput "{0}"
    }
}

; =========================
; Mouse 4 (XButton1)
; =========================

$~XButton1::
{
    global cancelClick
    cancelClick := false
}

$~XButton1 up::
{
    global cancelClick
    if !cancelClick
    {
        SendInput "{RButton}"
        sleep 50
        SendInput "{9}"
    }
}

; =========================
; Cancel logic
; =========================

~Esc::
{
    global cancelClick

    if GetKeyState("XButton1", "P")
    || GetKeyState("XButton2", "P")
    || GetKeyState("MButton", "P")
    {
        cancelClick := true
    }
}

~RButton::
{
    global cancelClick

    if GetKeyState("XButton1", "P")
    || GetKeyState("XButton2", "P")
    {
        cancelClick := true
    }
}

#HotIf
