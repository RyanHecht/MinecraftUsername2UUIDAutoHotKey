#Include JSON.ahk
#u::  ; Replace with your desired hotkey (currently WIN+u
    Clipboard := ""  ; Clear the clipboard
    Send ^c  ; Copy selected text (Minecraft username) to clipboard
    ClipWait  ; Wait for clipboard to contain data
    username := Clipboard  ; Save Minecraft username from clipboard to variable "username"
    url := "https://api.mojang.com/users/profiles/minecraft/" . username ; Create URL for Mojang API request
    whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")  ; Create WinHttpRequest object
    whr.Option(6) := false
    whr.Open("GET", url)  ; Open HTTP GET request to Mojang API URL
    whr.Send()  ; Send HTTP GET request
    whr.WaitForResponse()
    response := whr.ResponseText
    ;MsgBox %response%
    json := JSON.Load(response)
    if (json.HasKey("id")) {
        uuid := json.id
        formatted_uuid := SubStr(uuid, 1, 8) . "-" . SubStr(uuid, 9, 4) . "-" . SubStr(uuid, 13, 4) . "-" . SubStr(uuid, 17, 4) . "-" . SubStr(uuid, 21)
        SendInput %formatted_uuid%
    }
    else {
        MsgBox Error!
        MsgBox %response%
    }
    Reload
Return


