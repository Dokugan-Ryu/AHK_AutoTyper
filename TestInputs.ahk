#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

^9::
FileRead, Inputs, TestInputs.conf
Array := StrSplit(Inputs, "`r`n")
For key, value in Array
{
	If (SubStr(value, 1, 1) != "#")
	{
		Send %value%
		Send {Enter}
		Sleep, 500
	}
}
return