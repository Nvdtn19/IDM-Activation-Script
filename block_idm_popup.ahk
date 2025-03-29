; ==============================================
; AutoHotkey Script to Hide IDM Nags
; GitHub: https://github.com/Nvdtn19/IDM-Activation-Script/
; Description: This script automatically detects and hides 
;              unwanted popups from Internet Download Manager (IDM).
;
; Features:
;   - Hides and closes IDM popups as fast as possible.
;   - Runs every 10ms for near-instant reaction.
;     Though, don't worries, that won't leading to high CPU/RAM usage. 
;     It only use up to 1MB of RAM, even on weak computer.
;   - Hides registration, trial expiration, hosts file warning, and exit popups.
;   - Closes update check and hosts file warning popups.
;
;       Currently this script only support the English
;       version of IDM
;
; This script requires AHK 2.0
; You can download it from https://www.autohotkey.com/
; ==============================================

#SingleInstance Force
SetTimer(HideOrCloseIDMPopups, 10) ; Run every 10ms for faster response

HideOrCloseIDMPopups() {
    idmWindow := WinExist("Internet Download Manager")
    if idmWindow {
        winText := WinGetText(idmWindow) ; Retrieve window text in AHK v2
        if winText {
            if (InStr(winText, "Your browser may not open IDM website because an important system file is damaged on your computer") 
             || InStr(winText, "Do you want to register your copy of IDM now?")
             || InStr(winText, "IDM has not been registered for 30 days. Trial period is over")
             || InStr(winText, "IDM is exiting...")) { ; Hides exit message
                WinHide(idmWindow) ; Hide these popups ASAP
            } else if (InStr(winText, "IDM cannot check for updates because an important system file is damaged on your computer")
                    || InStr(winText, "Please note that this version and all previous versions of IDM may not use " . Chr(34) . "hosts" . Chr(34) . " file when they connect to IDM home site")) {
                WinClose(idmWindow) ; Close these popups immediately
            }
        }
    }
}
