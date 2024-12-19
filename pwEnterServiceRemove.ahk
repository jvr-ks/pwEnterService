; pwEnterServiceRemove.ahk

; Helper app to remove "pwEnterService" from memory!

#Requires Autohotkey v2+
#SingleInstance Force
#Warn

; "pwEnterService.exe" closes itself if it detects a running app named "pwEnterServiceRemove.exe"
currentRunningApps := getRunningAppsAsString()
if (InStr(currentRunningApps, "pwEnterService.exe")){
  showHintColoredPosY("Closing of service `" pwEnterService `" requested!")
  Loop 6 {
    currentRunningApps := getRunningAppsAsString()
    if (!InStr(currentRunningApps, "pwEnterService.exe"))
      break
    sleep 1000
  }
  if (InStr(currentRunningApps, "pwEnterService.exe")){
    showHintColoredPosY("ERROR, `"pwEnterService`" does not react on the closing request!",,,,0)
  } else {
  showHintColoredPosY("Ok, `"pwEnterService`" removed from memory!",,,,0)
  }
} else {
  showHintColoredPosY("`"pwEnterService`" is not running!",,,,0)
  exitApp
}

exitApp

;-------------------------- getRunningAppsAsString --------------------------
getRunningAppsAsString(){
  DetectHiddenWindows true
  
  runningApps := ""
  runningAppsList := WinGetList(,, "Program Manager")
  if (runningAppsList.Length > 0){
    for key, idNumber in runningAppsList {
      try {
        idTitle := WinGetTitle(idNumber)
        runningApps .= idTitle . " | "
      }
    }
  }
  return runningApps
}
;-------------------------- showHintColoredPosY --------------------------
showHintColoredPosY(s := "", n := 3000, fg := "cEE0000", bg := "FFFFFF", yPos := 80){
  global
  local t
  
  if (IsSet(hintColored))
    destroyHintColored()
    
  hintColored := Gui("+0x80000000 -Caption +Border +ToolWindow +AlwaysOnTop")
  hintColored.SetFont("c" fg)
  hintColored.BackColor := bg
  hintColored.add("Text", , s)
  hintColored.Show("y" yPos " xcenter")
  
  if (n > 0){
    sleep n
    destroyHintColored()
  } else {
    settimer destroyHintColored, n
  }
}
;---------------------------- destroyHintColored ----------------------------
destroyHintColored(*){
  global
  hintColored.Destroy()
}

;----------------------------------------------------------------------------






