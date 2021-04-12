#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#NoTrayIcon
#a::
	toggle += 1 ; This increments toggle state (so values after execution of this line will be one of 0,1,2)
	if (toggle = 1)
	{
		Run nircmd setdefaultsounddevice "dorm"
		soundToggleBox("dorm")
	}
	else if (toggle = 2)
	{
		Run nircmd setdefaultsounddevice "speaker"
		soundToggleBox("speaker")
		toggle :=  -1 ; set to -1 so on next run it will end up being 0
	}
	else
	{
		Run nircmd setdefaultsounddevice "headphone"
		soundToggleBox("headphone")
	}
Return
; Display sound toggle GUI
soundToggleBox(Device)
{
	IfWinExist, soundToggleWin
	{
		Gui, destroy
	}
	
	Gui, +ToolWindow -Caption +0x400000 +alwaysontop
	Gui, Add, text, x35 y8, Default sound: %Device%
	SysGet, screenx, 0
	SysGet, screeny, 1
	xpos:=screenx-275
	ypos:=screeny-100
	Gui, Show, NoActivate x%xpos% y%ypos% h30 w200, soundToggleWin
	
	SetTimer,soundToggleClose, 2000
}
soundToggleClose:
    SetTimer,soundToggleClose, off
    Gui, destroy
Return