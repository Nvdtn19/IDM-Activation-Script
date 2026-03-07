; ==============================================================================
; AutoHotkey Script to Hide IDM Nags
; GitHub: https://github.com/Nvdtn19/IDM-Activation-Script/
; Description: This script automatically detects and hides 
;              unwanted popups from Internet Download Manager (IDM).
;
; Features:
;   - Hybrid Event-Driven Logic: Uses Windows Shell Hooks to stay idle (0% CPU)
;     until a popup is detected.
;   - 10ms Burst Mode: Once a popup is blocked, the script enters a high-alert
;     state (10ms polling) for 1 second to catch chained/sequential popups.
;   - Ultra-Lightweight: Uses less than 2MB of RAM and zero CPU during idle, 
;     making it perfect for any computer, even low-end systems.
;   - Intelligent Filtering: Targets registration, trial expiration, hosts file 
;     warnings, and exit messages.
;
; Note: Currently this script only supports the English version of IDM.
; Requirement: AutoHotkey v2.0+ (https://www.autohotkey.com/)
; ==============================================================================

#SingleInstance Force
Persistent

global isBursting := false
global burstStartTime := 0

InitialCheck()

DllCall("RegisterShellHookWindow", "Ptr", A_ScriptHwnd)
OnMessage(DllCall("RegisterWindowMessage", "Str", "SHELLHOOK"), ShellMessage)

InitialCheck() {
    idmWindows := WinGetList("ahk_class #32770 ahk_exe IDMan.exe")
    for hwnd in idmWindows {
        if CheckIDM(hwnd) {
            StartBurstMode()
        }
    }
}

ShellMessage(wParam, lParam, *) {
    if (wParam = 1 || wParam = 4 || wParam = 6 || wParam = 32772) {
        if CheckIDM(lParam) {
            StartBurstMode()
        }
    }
}

StartBurstMode() {
    global isBursting, burstStartTime
    burstStartTime := A_TickCount
    if (!isBursting) {
        isBursting := true
        SetTimer(BurstCheck, 10)
    }
}

BurstCheck() {
    global isBursting, burstStartTime
    
    foundAnything := false
    idmWindows := WinGetList("ahk_class #32770 ahk_exe IDMan.exe")
    for hwnd in idmWindows {
        if CheckIDM(hwnd) {
            foundAnything := true
            burstStartTime := A_TickCount
        }
    }

    if (A_TickCount - burstStartTime > 1000) {
        SetTimer(BurstCheck, 0)
        isBursting := false
    }
}

CheckIDM(hwnd) {
    if !WinExist(hwnd)
        return false

    try {
        if WinGetProcessName(hwnd) = "IDMan.exe" {
            winText := WinGetText(hwnd)
            winTitle := WinGetTitle(hwnd)

            if (InStr(winText, "Your browser may not open IDM website") 
             || InStr(winText, "IDM cannot check for updates")
             || InStr(winText, "Do you want to register")
             || InStr(winText, "fake Serial Number")
             || InStr(winText, "Trial period is over")
             || InStr(winText, "IDM is exiting...")) {
                WinHide(hwnd)
                return true
            }
        }
    }
    return false
}
