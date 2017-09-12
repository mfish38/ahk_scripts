#Persistent
#SingleInstance force

;http://www.autohotkey.com/board/topic/83594-how-to-hide-taskbar-with-hotkey/?p=532637
;http://www.autohotkey.com/board/topic/5095-hot-corners/

SysGet, Xmin, 76
SysGet, Ymin, 77
SysGet, Xmax, 78
SysGet, Ymax, 79
Xmax += Xmin
Ymax += Ymin

Tolerance = 1

Xmax := Xmax - Tolerance
Ymax := Ymax - Tolerance
Xmin += Tolerance
Ymin += Tolerance

TaskBarHidden = False

SetTimer, CheckMouse, 300
CheckMouse:
	CoordMode, Mouse, Screen
	MouseGetPos, MouseX, MouseY
	WinGetPos TaskbarX, y, TaskbarWidth, h, ahk_class Shell_TrayWnd
	
	if (MouseX < Xmin){
		if (%TaskBarHidden%){
			WinShow, ahk_class Shell_TrayWnd
			WinShow, Start ahk_class Button
			TaskBarHidden = False
		}
	} else if (TaskbarX < 3 - TaskbarWidth){
		if (! %TaskBarHidden%){
			WinHide, ahk_class Shell_TrayWnd
			WinHide, Start ahk_class Button
			TaskBarHidden = True
		}
	}
Return
