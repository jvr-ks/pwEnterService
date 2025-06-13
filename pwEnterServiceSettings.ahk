; pwEnterServiceSettings.ahk

; Helper app to open the menu!

#Requires Autohotkey v2+
#SingleInstance Force
#Warn

showHintColoredTop("Editing the settings of service `" pwEnterService `" is requested!")
settimer exit, -4000

return
;---------------------------- showHintColoredTop ----------------------------
showHintColoredTop(s := "", n := 3000, fg := "cEE0000", bg := "FFFFFF"){
  global
  local t
  
  if (IsSet(hintColored))
    destroyHintColored()
    
  hintColored := Gui("+0x80000000 -Caption +Border +ToolWindow +AlwaysOnTop")
  hintColored.SetFont("c" fg)
  hintColored.BackColor := bg
  hintColored.add("Text", , s)
  hintColored.Show("center")
  
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
;----------------------------------- exit -----------------------------------
exit(*){
  global
  
  exitApp
}

;----------------------------------------------------------------------------






