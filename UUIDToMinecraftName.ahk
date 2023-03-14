#Include JSON.ahk
#n::  ; Replace with your desired hotkey (currently WIN+N)
    Clipboard := ""  ; Clear the clipboard
    Send ^c  ; Copy selected text (Minecraft username or UUID) to clipboard
    ClipWait  ; Wait for clipboard to contain data
    input := Clipboard  ; Save input from clipboard to variable "input"
    if (RegExMatch(input, "^[0-9a-fA-F]{8}(-[0-9a-fA-F]{4}){4}[0-9a-fA-F]{8}$", uuid)) {
        url := "https://sessionserver.mojang.com/session/minecraft/profile/" . uuid  ; Create URL for Mojang API request
        whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")  ; Create WinHttpRequest object
        whr.Open("GET", url)  ; Open HTTP GET request to Mojang API URL
        whr.Send()  ; Send HTTP GET request
        whr.WaitForResponse()
        response := whr.ResponseText
        ; MsgBox %response%
        json := JSON.Load(response)
        if (json.HasKey("name")) {
            username := json.name
            SendInput %username%
        }
        else {
            MsgBox Error!
            MsgBox %response%
        }
    } else {
        MsgBox Selected text not a UUID!
    }
Reload
Return
