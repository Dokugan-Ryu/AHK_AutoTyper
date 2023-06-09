#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.

global delay := 5000
global filename := "AutoTyper.txt"

; Reads lines from a file into a string array
GetInputs() {

  FileRead, Inputs, %filename%
  newArray := StrSplit(Inputs, "`r`n")
  return newArray
}

; Removes lines starting with "#"
RemoveSingleLineComments(Array) {
  newArray := []
  For key, value in Array {
    If (SubStr(value, 1, 1) != "#") {
      newArray.Push(value)
    }
  }
  return newArray
}

; Removes lines delimited by /* and */
RemoveBlockComments(Array) {
  ;MsgBox % Array[1]
  newArray := []
  inBlockComment := 0
  For key, value in Array {
    If(SubStr(value, 1, 2) == "/*") {
      inBlockComment = 1
    }
    If(SubStr(value, 1, 2) == "*/") {
      inBlockComment := 0
      Continue
    }

    If(inBlockComment) {
      Continue
    } else {
      newArray.Push(value)
    }
  }
  return newArray
}

;TODO Gets a key-value pair in from an array of strings with the format "key=value"
GetKeyPair(Array){
  result := {}
  For Key, Value in Array{
    keyValue := StrSplit(Value, "=")
    result.Push({keyValue[1]: keyValue[2]})
  }
  Return result
}

ReadSettings(Array) {
  newArray := []
  settingsLines := []
  startingLine := 0
  endingLine := 0

  ;Determine settings region start and finish
  For key, value in Array {
    If (value == "[SETTINGS]"){
      startingLine := key
    } Else If (value == "[/SETTINGS]") {
      endingLine := key
    }
  }

  ;generate settings array
  i := startingLine*1+1
  ;startingLine++
  While (i < endingLine){
    settingsLines.Push(Array[i])
    i++
  }

  ;convert settings string array to key-value array
  settings := GetKeyPair(settingsLines)
  
  ;set values
  For Key, Value in settings {
    If (Value.HasKey("delay")){
      global delay := Value.delay*1
    } Else If (Value.HasKey("filename")){
      global filename := Value.filename
    }
  }
  
  ;Remove settings region
  For Key, Value in Array {
    If (Key < startingLine OR Key > endingLine)
      newArray.Push(Array[Key])  
  }
  return newArray
}

; Ctrl+9 to activate
^9::
Array := GetInputs()
Array := RemoveSingleLineComments(Array)
Array := RemoveBlockComments(Array)
Array := ReadSettings(Array)

  For key, value in Array {
    Send %value%
    Send {Enter}   
    Sleep, delay
  }
return
