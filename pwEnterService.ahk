/*
 *********************************************************************************
 * 
 * pwEnterService.ahk
 *
 * Automatic enters your password
 *
 * Attention: Keep the files "pwEnter.ini" and "pwEnter.exe" on an USB-Stick!
 * (Edit "pwEnter.ini" and enter your password, section [keepsecret], field targetAppPassword=<PASSWORD>)
 * 
 * "pwEnter.ini" contains the unencrypted password then.
 *
 * Take the stick always with you!
 *
 * 
 *
 * Version: -> appVersion
 * 
 * Copyright (c) 2024 jvr.de. All rights reserved.
 *
 * File encoding: "pwEnter.ahk" UTF-8-BOM, "pwEnter.ini" UTF-16 LE-BOM
 *
 *********************************************************************************
*/
/*
 *********************************************************************************
 * 
 * GNU GENERAL PUBLIC LICENSE
 * 
 * A copy is included in the file "license.txt"
 *
  *********************************************************************************
*/

#Requires Autohotkey v2+

#SingleInstance force

#Warn

#Include pwEnterSvSetVariables.ahk
#Include pwEnterSvSettings.ahk
#Include pwEnterSvCheckAndSend.ahk
#Include pwEnterSvHelper.ahk

DetectHiddenWindows 1

appname := "pwEnterService"
appnameLower := "pwenterservice"
appVersion := "0.023"

posSaveX := 0
posSaveY := 0

setVariables()

pwEnterSvSetup()

; Command Line parameters
hasParams := A_Args.Length
if (hasParams != 0){
  Loop hasParams {
    if(A_Args[A_index] = "remove"){
      showHintColoredTop(quot "pwEnterService" quot " removed from memory!", 2000)
      exitApp
    }
    if(A_Args[A_index] = "settings"){
      showSettings := 1
    }
  }
}

; App launch modifiers
mode := 0
if (GetKeyState("Alt", "P"))
  mode += 1
if (GetKeyState("Shift", "P"))
  mode += 2

switch mode
{
  case 1:
    exit()
  case 2:
    showSettings := 1
  case 3:
    testMode := 1
}

if (showSettings){
  pwEnterSvSettings()
} else {
  if (!testMode){
    guiMain := Gui("+0x80000000 -Caption +ToolWindow +AlwaysOnTop", appname)
  } else {
    guiMain := Gui("+AlwaysOnTop +0x80000000", appname)
  }
  guiMain.SetFont("cFFFFFF")
  guiMain.BackColor := "a900ff"
  guiMain.add("Text", "x2 y0 r2" , quot "pwEnterService" quot " started!")
  if (testMode){
    guiMain.SetFont("c000000")
    mainMsg := guiMain.add("Edit", "x2 w400", "Testmode is activated!")
  }
  if (testMode)
    guiMain.Show("y200 xcenter")
  else
    guiMain.Show("y2 xcenter")
    
  guiMainHWND := guiMain.hwnd
  sleep 3000
  if (!testMode){
    guiMain.Move(, 0, 50, 1) ; reduce to one pixel
    WinSetTransparent 0, "ahk_id " guiMainHWND
  } else {
    guiMain.OnEvent("Close", exit)
  }
  A_TrayMenu.Add("Open Github webpage", openGithubPage)
  
  DllCall("RegisterShellHookWindow", "UInt", guiMainHWND)
  OnMessage(DllCall("RegisterWindowMessage", "Str", "SHELLHOOK"), newWindowOpened)
  
  ; guiMain.OnEvent("ContextMenu", Gui_ContextMenu) ; currently not used
  
  checkAndSend(1)
}

return

;------------------------------ pwEnterSvSetup ------------------------------
pwEnterSvSetup(){
  global
  
  Firefox_WinActivateId := "ahk_exe firefox.exe"
  Firefox_ControlId := ""
  Firefox_PwBoxId := "ahk_exe firefox.exe ahk_class MozillaDialogClass"
  
  Crypditor_ExeName := IniRead(passwordsFile, "config", "Crypditor_ExeName" , "crypditor.exe")
  Crypditor_WinActivateId := "ahk_exe " Crypditor_ExeName " ahk_class TPasswordDlgDec"
  Crypditor_ControlId := "TEdit1"
  Crypditor_PwBoxId := "ahk_exe" Crypditor_ExeName
  
  Vncviewer_WinActivateId := "" ; not used
  Vncviewer_ControlId := "Edit1"
  Vncviewer_PwBoxId := "UltraVNC Viewer - Authentication"
  
  verifyDelayFirefox := IniRead(configFile, "config", "verifyDelayFirefox" , 3000)
  verifyDelayCrypditor := IniRead(configFile, "config", "verifyDelayCrypditor" , 3000)
  
  testMode := IniRead(configFile, "config", "testMode" , 0)
  
  return
}
;------------------------------ newWindowOpened ------------------------------
newWindowOpened(wParam, lParam, *){
  global
  
  pname := ""
  try {
    pname := WinGetProcessName("ahk_id " lParam)
    if (pname = "firefox.exe" || pname = Crypditor_ExeName || pname = "pwEnterServiceSettings.exe" || pname = "pwEnterServiceRemove.exe" || pname = "vncviewer.exe"){
      if (!newAppsStop){
        settimer checkAndSend, -1
      }
    }
  }
}
;------------------------------ Gui_ContextMenu ------------------------------
Gui_ContextMenu(GuiObj, GuiCtrlObj, Item, IsRightClick, X, Y){
  global
  
  ; not used

}

;----------------------------------------------------------------------------

