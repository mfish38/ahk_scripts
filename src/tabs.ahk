#SingleInstance force
#NoTrayIcon

SetWindowPos(hWnd, hWndInsertAfter, X, Y, cx, cy, uFlags){
	return DllCall("SetWindowPos"
		,"UInt", hWnd
		,"UInt", hWndInsertAfter
		,"Int",  X
		,"Int",  Y
		,"Int",  cx
		,"Int",  cy
		,"UInt", uFlags)
}
HWND_BOTTOM = 1
HWND_NOTOPMOST = -2
HWND_TOP = 0
HWND_TOPMOST = -1
SWP_ASYNCWINDOWPOS = 0x4000
SWP_NOSIZE = 0x0001
SWP_NOMOVE = 0x0002
SWP_NOZORDER = 0x0004
SWP_NOACTIVATE = 0x0010

UpdateWindow(hWnd){
	return DllCall("UpdateWindow", "UInt", hWnd)
}

ShowWindow(hWnd, nCmdShow){
	return DllCall("ShowWindow", "UInt", hWnd, "Int", nCmdShow)
}
SW_FORCEMINIMIZE = 11
SW_HIDE = 0
SW_MAXIMIZE = 3
SW_MINIMIZE = 6
SW_RESTORE = 9
SW_SHOW = 5
SW_SHOWDEFAULT = 10
SW_SHOWMAXIMIZED = 3
SW_SHOWMINIMIZED = 2
SW_SHOWMINNOACTIVE = 7
SW_SHOWNA = 8
SW_SHOWNOACTIVATE = 4
SW_SHOWNORMAL = 1

embed_window(parent_window_handle, child_window_handle, x, y, w, h){
	; Based on: http://stackoverflow.com/a/16641537
	
	; Change the parent of the window to embed to that of the window that it should be embedded in.
	DllCall("SetParent", "UInt", child_window_handle, "UInt", parent_window_handle)

	; Change the style of the window to embed to that of a child window. (This hides the menu bar.)
	; WS_CHILD=0x40000000
	; WinGet, explorer_style, Style, ahk_id %child_window_handle%
	; WinSet, Style, % explorer_style | WS_CHILD, ahk_id %child_window_handle%

	; Remove the title bar and frame
	WinSet, Style, -0xC00000, ahk_id %child_window_handle%
	
	;Set the position of the child window within the parent window.
	SetWindowPos(child_window_handle, 0, x, y, w, h, SWP_NOZORDER)
	
	; Ensure that the window is completely redrawn (prevents blank spaces when done)
	;UpdateWindow(explorer_id1)
}


Gui, Add, Tab2, Hwndtab_id gtab_handler vcurrent_tab +AltSubmit +Theme -Background, One|two

Gui, +LastFound
WinGet, gui_id, ID

Gui, +Resize
Gui, Show

; launch an explorer instance
Run, explorer
sleep 500
WinGet, explorer_id1, ID, A
embed_window(gui_id, explorer_id1, 0, 0, tab_width, tab_height)

; launch an explorer instance
Run, explorer
sleep 500
WinGet, explorer_id2, ID, A
embed_window(gui_id, explorer_id2, 0, 0, tab_width, tab_height)

current_window_id := explorer_id1

WinHide, ahk_id %explorer_id2%

return

repaint:
	UpdateWindow(current_window_id)
	UpdateWindow(tab_id)
	UpdateWindow(gui_id)
return

resize_tab_control:
	tab_top = 21
	GuiControl, Move, current_tab, % "x" 0 "y" 0 "w" width + 2 "h" height + 1
return

resize_current_tab:
	border_width = 7
	SetWindowPos(current_window_id, 0, -border_width, tab_top, width + border_width * 2, height - tab_top + border_width, SWP_NOACTIVATE | SWP_NOZORDER)
return

tab_handler:
	; Update the current tab variable
	Gui, Submit, NoHide
	
	if (current_tab = 1){
		current_window_id := explorer_id1
		Gosub, resize_current_tab
		ShowWindow(explorer_id1, SW_SHOWNA)
		WinHide, ahk_id %explorer_id2%
	}else{
		current_window_id := explorer_id2
		Gosub, resize_current_tab
		ShowWindow(explorer_id2, SW_SHOWNA)
		WinHide, ahk_id %explorer_id1%
	}
	Gosub, repaint
return

GuiSize:
	; Only handle resize events
	if (A_EventInfo != 0){
		return
	}
	
	width := A_GuiWidth
	height := A_GuiHeight
	
	Gosub, resize_tab_control
	Gosub, resize_current_tab
	Gosub, repaint
return

GuiClose:
	ExitApp
return
