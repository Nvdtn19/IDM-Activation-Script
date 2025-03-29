; ==============================================
; AutoHotkey Script to Hide IDM Nags
; GitHub: https://github.com/Nvdtn19/IDM-Activation-Script/
; Description: This script automatically detects and hides 
;              unwanted popups from Internet Download Manager (IDM).
; This script requires AHK 2.0
; You can download it from https://www.autohotkey.com/
; ==============================================

#SingleInstance Force
SetTimer(HideIDMPopups, 500) ; Run every 500ms


HideIDMPopups() {
    idmWindow := WinExist("Internet Download Manager")
    if idmWindow {
        winText := WinGetText(idmWindow)
        if winText && (InStr(winText, "Your browser may not open IDM website because an important system file is damaged on your computer") 
                    || InStr(winText, "Do you want to register your copy of IDM now?")
                    || InStr(winText, "IDM has not been registered for 30 days. Trial period is over")) {
            WinHide(idmWindow)
        }
    }
}
