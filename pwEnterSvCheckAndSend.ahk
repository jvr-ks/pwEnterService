; pwEnterSvCheckAndSend.ahk
; Part of pwEnterService.ahk

;------------------------------- checkAndSend -------------------------------
checkAndSend(forced := 0){
  global
  
  static showOnceOnly := 0
  
  pw := ""
  
  useFirefox := 0
  useCrypditor := 0
  
  if (!FileExist(passwordsFile)){
    settimer checkAndSend, 0
    if (!showOnceOnly){
      showHintColoredTop("USB stick not inserted (problem reading: " passwordsFile ") ?", 10000)
      showOnceOnly := 1
    }
    return
    
  } else {
    showOnceOnly := 0
  }
  
  if (pwEnterSvGetPwFirefox() != "")
    useFirefox := 1
    
  if (pwEnterSvGetPwCryptor() != "")
    useCrypditor := 1
    
  if (pwEnterSvGetPwVncviewer() != "")
    useVncviewer := 1
    
  if (testMode){
    if (trim(pname) != "")
      displayTestmodeMsg("Started app is: " pname)
  }
  ;-------------------------------- Firefox --------------------------------
  if ((InStr(pname, "firefox.exe") && useFirefox) || forced && WinExist(Firefox_WinActivateId)){
    if (forced){
      if (WinExist(Firefox_PwBoxId))
        WinActivate(Firefox_PwBoxId)
    }
    forced := 0
    CoordMode "Mouse", "Screen"
    MouseGetPos &posSaveX, &posSaveY
    started := WinWaitActive(Firefox_PwBoxId,,30)
    if (started){
      if (testMode){
        displayTestmodeMsg("Password request detected, app: " pname)
      }
      pw := pwEnterSvGetPwFirefox()
      try {
        WinActivate(Firefox_PwBoxId)
        ;ControlFocus: id of control is hidden in Firefox
        sleep 50
        ControlSendText pw,, Firefox_PwBoxId
        sleep 500
        ControlSend "{Enter}",, Firefox_PwBoxId
      }
      pw := ""
      CoordMode "Mouse", "Screen"
      MouseMove posSaveX, posSaveY
      sleep verifyDelayFirefox
      ; still exists?
      if (WinExist(Firefox_PwBoxId)){
        showHintColoredTop("Firefox password failed! (Set the focus on the password request box)`n`nTrying again in 5 seconds!`n`n(Press Escape to abort).", 5000)
        if (!GetKeyState("Escape", "P")){
          settimer checkAndSend, -5000
        } else {
          showHintColoredTop("Retry canceled!")
        }
      }
    }
  }
  ;-------------------------------- Crypditor_ -------------------------------- 
  if (((pname = Crypditor_ExeName) && useCrypditor) || forced && WinExist(Crypditor_WinActivateId)){
    started := WinWaitActive(Crypditor_WinActivateId,,30)
    forced := 0
    CoordMode "Mouse", "Screen"
    MouseGetPos &posSaveX, &posSaveY
    ;tooltip pname " detected"
    if (started){
      if (testMode){
        displayTestmodeMsg("Password request detected, app: " pname)
      }
      pw := pwEnterSvGetPwCryptor()
      try {
        WinActivate(Crypditor_WinActivateId)
        ControlFocus Crypditor_ControlId, Crypditor_WinActivateId
        sleep 50
        ControlSendText pw, Crypditor_ControlId, Crypditor_PwBoxId
        sleep 500
        ControlSend "{Enter}", Crypditor_ControlId, Crypditor_PwBoxId
      }
      pw := ""
      CoordMode "Mouse", "Screen"
      MouseMove posSaveX, posSaveY
      sleep verifyDelayCrypditor
      ; still exists?
      if (WinExist(Crypditor_WinActivateId)){
        showHintColoredTop("Crypditor password failed! (Set the focus on the password request box)`n`n Trying again in 5 seconds!`n`n(Press Escape to abort).", 5000)
        if (!GetKeyState("Escape", "P")){
          settimer checkAndSend, -5000
        } else {
          showHintColoredTop("Retry canceled!")
        }
      }
    }
  }
  if (pname = "pwEnterServiceSettings.exe"){
    newAppsStop := 1
    pwEnterSvSettings()
    pause
  }
  if (pname = "pwEnterServiceRemove.exe"){
    newAppsStop := 1
    exit()
  }
  
  ;--------------------------------- Vncviewer ---------------------------------
  ; Vncviewer_WinActivateId not used
  if ((InStr(pname, "vncviewer.exe") && useVncviewer) || forced && WinExist(Vncviewer_PwBoxId)){
    if (forced){
      WinWaitActive(Vncviewer_PwBoxId,,30)
      if (WinExist(Vncviewer_PwBoxId))
        WinActivate(Vncviewer_PwBoxId)
    }
    forced := 0
    CoordMode "Mouse", "Screen"
    MouseGetPos &posSaveX, &posSaveY
    started := WinWaitActive(Vncviewer_PwBoxId,,30)
    if (started){
      if (testMode){
        displayTestmodeMsg("Password request detected, app: " pname)
      }
      pw := pwEnterSvGetPwVncviewer()
      try {
        ;WinActivate(Vncviewer_PwBoxId)
        ;ControlFocus Vncviewer_ControlId, Vncviewer_WinActivateId
        sleep 50
        ControlSendText pw, Vncviewer_ControlId, Vncviewer_PwBoxId
        sleep 500
        ControlSend "{Enter}", Vncviewer_ControlId, Vncviewer_PwBoxId
      }
      pw := ""
      CoordMode "Mouse", "Screen"
      MouseMove posSaveX, posSaveY
      sleep verifyDelayVncviewer
      
      ; still exists?
      if (WinExist(Vncviewer_PwBoxId)){
        showHintColoredTop("Vncviewer password failed! (Set the focus on the password request box)`n`nTrying again in 5 seconds!`n`n(Press Escape to abort).", 5000)
        if (!GetKeyState("Escape", "P")){
          settimer checkAndSend, -5000
        } else {
          showHintColoredTop("Retry canceled!")
        }
      }
    }
  }
  displayTestmodeMsg("")
}
;--------------------------- pwEnterSvGetPwFirefox ---------------------------
pwEnterSvGetPwFirefox(){
  return IniRead(passwordsFile, "keepsecret", "Firefox_Password" , "")
}
;--------------------------- pwEnterSvGetPwCryptor ---------------------------
pwEnterSvGetPwCryptor(){
  return IniRead(passwordsFile, "keepsecret", "Crypditor_Password" , "")
}
;--------------------------- pwEnterSvGetPwVncviewer ---------------------------
pwEnterSvGetPwVncviewer(){
  return IniRead(passwordsFile, "keepsecret", "Vncviewer_Password" , "")
}
;----------------------------------------------------------------------------

















