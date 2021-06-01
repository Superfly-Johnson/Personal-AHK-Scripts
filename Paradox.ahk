GroupAdd PDX, ahk_exe eu4.exe
GroupAdd PDX, ahk_exe hoi4.exe
GroupAdd PDX, ahk_exe CK2game.exe
#IfWinActive ahk_group PDX

PgUp::SendInput, {NumpadAdd}
PgDn::SendInput, {NumpadSub}