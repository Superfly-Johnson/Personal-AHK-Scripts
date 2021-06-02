#SingleInstance
#IfWinActive ahk_exe pso2.exe

SetKeyDelay, 100 ; Should be set to your latency with the server.

Subpalette := ["{Numpad1}","{Numpad2}","{Numpad3}","{Numpad4}","{Numpad5}","{Numpad6}","{Numpad7}","{Numpad8}","{Numpad9}","{Numpad0}"]

; Example rebind to change the subpalette keys to anything you'd like. 
/*
1::Send, % Subpalette[1]
2::Send, % Subpalette[2]
3::Send, % Subpalette[3]
4::Send, % Subpalette[4]
5::Send, % Subpalette[5]
6::Send, % Subpalette[6]
7::Send, % Subpalette[7]
8::Send, % Subpalette[8]
9::Send, % Subpalette[9]
0::Send, % Subpalette[0]
*/
^!F1::Suspend, Toggle

^!Enter::SetTimer, AutoEnter, % (AutoEnter := !AutoEnter) ? 25 : "off"

^!F3::SetTimer, AcceptClientOrder, % (AcceptClientOrder := !AcceptClientOrder) ? 50 : "off"


^!F::GoSub, AutoFish
;^!F5::GoSub, AutoFillSupport

^!F6::SetTimer, DepositItem1, % (DepositItem1 := !DepositItem1) ? 50 : "off"

; Auto clicks enter. Duh.
AutoEnter:
    Send, {Enter}
    Return

; Should accept every client orders in a list. Useful for Franca. Bugs out for some reason...
AcceptClientOrder:
    Send, {Enter} ; Accepts.
    Send, {Down}  ; Go to the next one.
    Return

AutoFish:
    Loop 3 {
        Send, {E}      ; Open Fishing Menu
        Send, {Enter}  ; Select first choice (starts red circle anim)
        Sleep, 3000         ; Wait for red circle (timing is wrong here)
        Send, {E}      ; Harvests fish       ; Wait for anim to finish
        Send, {Enter}  ; Confirm
        Sleep 1000
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

DepositItem1:
    DepositItem(1)
    Return

; Meant to be used while in inventory
DepositItem(StorageID){
    Send, {Enter} ; Opens Item interact menu then opens deposit menu
    Send, {Enter}
    Send, {Down %StorageID%} ; 0 for Default, 1 for Character, 2 for Premium, 3 for Material
    Send, {Enter}
    Return
}