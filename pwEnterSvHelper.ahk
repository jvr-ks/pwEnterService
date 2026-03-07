; pwEnterSvHelper.ahk
; Part of pwEnterService.ahk


;---------------------------- showHintColoredTop ----------------------------
showHintColoredTop(s := "", n := 4000, fg := "cFFFFFF", bg := "A900FF"){
  global
  local t
  
  if (IsSet(hintColored))
    destroyHintColored()
    
  hintColored := Gui("+0x80000000 -Caption +ToolWindow +AlwaysOnTop")
  hintColored.SetFont("c" fg)
  hintColored.BackColor := bg
  hintColored.add("Text", , s)
  hintColored.Show("y2 xcenter")
  
  if (n > 0){
    sleep n
    destroyHintColored()
  }
  if (n < 0){
    settimer destroyHintColored, n
  }
  ; if n = 0: keep displayed
}
;---------------------------- destroyHintColored ----------------------------
destroyHintColored(*){
  global
  
  hintColored.Destroy()
}
;---------------------------- displayTestmodeMsg ----------------------------
displayTestmodeMsg(s := ""){
  global
  
  if (testMode && IsSet(mainMsg)){
    ActiveHwnd := WinExist("A")
    mainMsg.Value := s
    WinActivate("ahk_id" ActiveHwnd)
  }
}
;------------------------------ openGithubPage ------------------------------
openGithubPage(*){
  global
  
  Run("https://github.com/jvr-ks/simpletools/#pwEnterService")
}
;----------------------------------- exit -----------------------------------
exit(*){
  global
  
  if (IsSet(hintColored))
   guiMain.Destroy()
  
  showHintColoredTop("pwEnterService.exe: Exiting, by, by ...!", 5000)

  exitApp
}








;----------------------------------------------------------------------------

















