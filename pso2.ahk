#SingleInstance
#IfWinActive ahk_exe pso2.exe

SetKeyDelay, 200 ; Should be set to your latency with the server.

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

^!F2::SetTimer, AutoEnter, % (AutoEnter := !AutoEnter) ? 100 : "off"

^!F3::SetTimer, AcceptClientOrder, % (AcceptClientOrder := !AcceptClientOrder) ? 200 : "off"


^!F4::GoSub, AutoFish
^!F5::GoSub, AutoFillSupport

^!F6::DepositItem(1)
^!F7::StoreAllItems(1)

; Auto clicks enter. Duh.
AutoEnter:
    Send, {Enter}
    Return

; Should accept every client orders in a list. Useful for Franca.
AcceptClientOrder:
    Send, {Enter} ; Accepts.
    Send, {Down}  ; Go to the next one.
    Return

AutoFish:
    Loop 10 {
        Send, {E}      ; Open Fishing Menu
        Send, {Enter}  ; Select first choice (starts red circle anim)
        Sleep, 1000         ; Wait for red circle (timing is wrong here)
        Send, {E}      ; Harvests fish
        Sleep, 1000         ; Wait for anim to finish
        Send, {Enter}  ; Confirm
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

; Stores all items in a category.
StoreAllItems(StorageID){
    Loop 150 { ; Should be set to max inventory space.
        DepositItem(%StorageID%)
    }
}

; Meant to be used while in inventory
DepositItem(StorageID){
    Send, {Enter} ; Opens Item interact menu then opens deposit menu
    Send, {Enter}
    Send, {Down %StorageID%} ; 0 for Default, 1 for Character, 2 for Premium, 3 for Material
    Send, {Enter}
    Return
}