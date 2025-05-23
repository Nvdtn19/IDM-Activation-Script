## IDM Activation Script
A fork of [WindowsAddict's IDM Activation Script (archived)](https://github.com/WindowsAddict/IDM-Activation-Script), which is an open source tool to activate and reset trial of [Internet Download Manager](https://www.internetdownloadmanager.com).

## Features

-   IDM freeze trial and activation with registry key lock method
-   Block any IDM nags after freezing the trial period (Currently only works with the English version of IDM)
-   Activation and trial persist even after installing IDM updates
-   IDM trial reset
-   Fully open source
-   Based on the transparent batch script

## IAS Latest Release

Last Release - v1.5 (24-Apr-2025)

#### OS requirement

-   The project is supported only on Windows 7/8/8.1/10/11, with all important updates installed.
-   The PowerShell method to run IAS is supported on Windows 8 and higher.


## Download / How to use it?

-   First fresh install [Internet Download Manager](https://www.internetdownloadmanager.com/). Make sure previous cracks/patches are removed/uninstalled if there are any.
-   After that follow the below steps to activate it.

## Note

-   📌 The activation option is currently not working in the script, use the Freeze trial option to lock 30-day trial period for the lifetime.

### Method 1 - PowerShell

(Recommended)

Not available yet

### Method 2 - Traditional

-   Download the file from [GitHub](https://github.com/Nvdtn19/IDM-Activation-Script/archive/refs/heads/main.zip) 
-   Right-click on the downloaded zip file and extract
-   In the extracted folder, run the file named `IAS.cmd`
-   You will see the activation options, and follow onscreen instructions.
-   That's all.

## Info

#### Freeze Trial

-   IDM provides a 30-day trial period, you can use this option in the script to lock this trial period for the lifetime so that you won't have to reset the trial again and your trial won't expire.
-   This method requires the Internet at the time of applying this option.
-   IDM updates can be installed directly without having to freeze it again.

#### Activation

(\*Currently not working)

-   This script applies the registry lock method to activate the Internet download manager (IDM).
-   This method requires the Internet at the time of activation.
-   IDM updates can be installed directly without having to activate it again.
-   After the activation, if in some cases, IDM starts to show an activation nag screen, then just run the activation option again without using the reset option.

#### Reset IDM Activation / Trial

-   Internet download manager provides a 30-day trial period, you can use this script to reset this Activation / Trial period whenever you want.
-   This option also can be used to restore status if in case IDM reports a fake serial key and other similar errors.

#### Advanced Info

-   To activate in unattended mode, run the script with the `/act` parameter.
-   To freeze the trial in unattended mode, run the script with the `/frz` parameter.
-   To reset in unattended mode, run the script with the `/res` parameter.

## How does it work?

-   IDM stores the data related to trial and activation across various registry keys. Some of these keys are locked to protect them from tampering and data is stored in a pattern to track the fake serial issue and the remaining trial days. To activate it, the script here simply generates those registry keys by triggering a few downloads in IDM, identifies those registry keys, and locks them so IDM can't edit and view them. That way IDM cannot show the warning that it's activated with a fake serial key.

## Troubleshoot

-   Browser Integration Fix: [Chrome](https://www.internetdownloadmanager.com/register/new_faq/bi9.html) - [Firefox](https://www.internetdownloadmanager.com/register/new_faq/bi4.html)
-   Raise the issue on [Github](https://github.com/Nvdtn19/IDM-Activation-Script) with screenshots.

## Changelog

#### v1.5
The scheduled task for blocking IDM popups will now:
- Tries restarting every 1 minute up to 3 times if the task fails.
- Synchronizes task across time zones.
- Ensures the task runs interactively.

#### v1.4
The scheduled task for blocking IDM popups will now:
- Run at startup (not just on logon).
- Ensure it runs with the highest privileges.
- Ensure it runs regardless of AC power state.
- Ensure it runs as soon as possible after a scheduled start is missed.
- Remove the "stop the task if it runs longer than..." condition
Also, the AHK script will now run every 100ms instead of 10ms to prevent from high resource usage (although it is almost zero)

#### v1.3
[This release is unofficial and not from the original author of the script since this is a fork]

-   New features: [Block IDM Nags](https://www.reddit.com/r/Piracy/comments/1c65bb5/any_idea_how_to_prevent_this_popup_from_appearing/) after freezing the trial period. How this methods works:
  - Block the ```secure.internetdownloadmanager.com``` domain in the hosts file to prevent license check. The nags window is actually come from that domain. There should be no issues that affect IDM if that domain is blocked.
  - When the trial period is expired, IDM will try to load the nags from that domain and shows to the user. But since that domain is now blocked, IDM will failed to load it and instead, shows another nags popup, "Your browser may not open IDM website because an important system file is damaged on your computer. Repair this file?" everytime it tries to show the original nags.
  - So we have created an [IDM nags blocker script](https://github.com/Nvdtn19/IDM-Activation-Script/blob/main/block_idm_popup.ahk) that also auto hide this kind of nags!
  - The script will download [AutoHotkey](https://www.autohotkey.com/) if it is not already presented, since the nags blocker requires it to work properly. And then configure to make the popup blocker script always run in the background, so it can track and block any kinds of annoying IDM popups, including registration, trial expiration, host file warning, and also the "IDM is exiting..." popups. 

#### v1.2

-   Added back activation option with a randomized name, email, and key in registration details along with a warning that it's not working for some users, the recommended option is to use Freeze trial.

#### v1.1

-   IDM update 6.42b3 has started showing fake serial popups with IAS activation, due to this we have removed the activation option and replaced it with the Freeze trial option to lock the 30-day trial period for the lifetime.
-   Now the script will disable quick-edit in CMD windows using Powershell instead of editing registry, thanks to @abbodi1406 for the code and @awuctl for the idea.
-   Code to relaunch script with conhost.exe to avoid terminal app is now merged in quick-edit disable code, thanks to @abbodi1406.

#### v1.0

-   Added the code to relaunch the script with conhost.exe if the script is running from the terminal app.
-   Fixed an issue in getting the current user account SID.

#### v0.9

-   Fixed an issue where the script can not activate and reset IDM in non-admin user accounts.
-   Fixed an issue where the script incorrectly shows that IDM is activated.
-   Fixed an issue where a fake serial pop-up may appear. The script will also show the info to run the activation option again without using the reset option.
-   Fixed an issue where Powershell code to launch IAS may not work due to GitHub block in some regions. It will use the new [BitBucket](https://bitbucket.org/WindowsAddict/idm-activation-script/) repo as a fallback link.
-   IDM registry scanning and locking code is now written in Powershell.
-   The script update checker code is added to the script.
-   The script will now disable quick edit mode temporarily because users often click inside the script window and it pauses the script.
-   The script will back up the CLSISD registry keys before performing operations on them.
-   Many error checks are added to better identify the issues.

#### v0.8

-   Move the project to [Github](https://github.com/WindowsAddict/IDM-Activation-Script) and [massgrave.dev](https://massgrave.dev/idm-activation-script.html)
-   Minor bug fixes
-   Add info to inform users that empty registry keys are being deleted when the script deletes a lot of them

## Screenshots

![](https://massgrave.dev/images/IAS.png?raw=true)

![](https://massgrave.dev/images/IAS_Freeze_Trial.png?raw=true)

## Credits

|                                             |                                                                                                                                                                                                                                        |
|----------------------|--------------------------------------------------|
| Dukun Cabul                                 | Original researcher of this IDM trial reset and activation logic, made an Autoit tool for these methods, [IDM-AIO_2020_Final](https://nsaneforums.com/topic/371047-discussion-internet-download-manager-fixes/page/8/#comment-1632062) |
| AveYo aka BAU                               | [reg_own lean and mean snippet](https://pastebin.com/XTPt0JSC)                                                                                                                                                                         |
| [abbodi1406](https://github.com/abbodi1406) | Help in coding                                                                                                                                                                                                                         |
| WindowsAddict                               | IAS Author                                                                                                                                                                                                                             |

And thanks to the IAS users for their interest, feedback, and assistance.

------------------------------------------------------------------------

Made with Love ❤️
