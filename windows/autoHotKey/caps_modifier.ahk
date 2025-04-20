#Requires AutoHotkey v2.0

; When CapsLock is pressed, hold down LWin + Ctrl + Shift
CapsLock::
{
    Send("{LWin down}{Ctrl down}{Shift down}")
    return
}

; When CapsLock is released, release all three modifiers
CapsLock up::
{
    Send("{Shift up}{Ctrl up}{LWin up}")
    return
}

; Example: CapsLock + Q → triggers Q with Win+Ctrl+Shift held down
~CapsLock & q::
{
    Send("q")  ; With modifiers already held, this equals Win+Ctrl+Shift+Q
    return
}

SetCapsLockState "AlwaysOff"
