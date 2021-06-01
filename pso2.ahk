#SingleInstance
#IfWinActive ahk_exe pso2.exe

SetKeyDelay, 200 ; Should be set to your latency with the server.

Subpalette := ["{Numpad1}","{Numpad2}","{Numpad3}","{Numpad4}","{Numpad5}","{Numpad6}","{Numpad7}","{Numpad8}","{Numpad9}","{Numpad0}"]

; Example rebind to change the subpalette keys to anything you'd like. 
/*
1::SendInput, % Subpalette[1]
2::SendInput, % Subpalette[2]
3::SendInput, % Subpalette[3]
4::SendInput, % Subpalette[4]
5::SendInput, % Subpalette[5]
6::SendInput, % Subpalette[6]
7::SendInput, % Subpalette[7]
8::SendInput, % Subpalette[8]
9::SendInput, % Subpalette[9]
0::SendInput, % Subpalette[0]
*/
^!F1::Suspend, Toggle

^!F2::SetTimer, AutoEnter, % (AutoEnter := !AutoEnter) ? 500 : "off"

^!F3::SetTimer, AcceptClientOrder, % (AcceptClientOrder := !AcceptClientOrder) ? 500 : "off"


^!F4::GoSub, AutoFish
^!F5::GoSub, AutoFillSupport

; Auto clicks enter. Duh.
AutoEnter:
    SendInput, {Enter}
    Return

; Should accept every client orders in a list. Useful for Franca.
AcceptClientOrder:
    SendInput, {Enter} ; Accepts.
    SendInput, {Down}  ; Go to the next one.
    Return

AutoFish:
    Loop 10 {
        SendInput, {E}      ; Open Fishing Menu
        SendInput, {Enter}  ; Select first choice (starts red circle anim)
        Sleep, 1000         ; Wait for red circle (timing is wrong here)
        SendInput, {E}      ; Harvests fish
        Sleep, 1000         ; Wait for anim to finish
        SendInput, {Enter}  ; Confirm
    }
    Return

; Autofill all support items
AutoFillSupport:
    Send, {E}			; Start Dialogue
    Send, {Enter}		; Open BuyItems submenu
    Sleep, 2000
    Loop, 8 {			; There are 8 support items, so the loop runs 8 times.
        Send, {Left}	; Select Maximum.
	    Send, {Enter}	; Buy
        Send, {Enter}   ; Confirm
	    Send, {Down}	; Go to the next one
    }
    Return

/*
AutoHarvest:
    Loop 10 {

    }
    Return
*/
/*
Autostore(NumOfStorage)
    SendInput, {Enter}
    SendInput, {Down}	; Select Storage
    SendInput, {Enter}	; Open ^
    Loop NumOfStorage {
        SendInput, {Down} 	; 1 for Default, 2 for Character, 3 for Premium, 4 for Material
    }
    SendInput, {Enter}
    Return
*/