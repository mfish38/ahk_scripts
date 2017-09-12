
#include OGUI_Menu.ahk
#include FunctionCall.ahk

FRun(target)
{
	Run, % target, , ,pid
	return pid
}

FLogoff()
{
	Shutdown, 0
}

FShutdown()
{
	Shutdown, 8
}

FReboot()
{
	Shutdown, 2
}

;root_menu := new OGUI_Menu("root")
;	root_menu.add_item("Firefox", new FunctionCall("RunSingle", "C:\Program Files (x86)\Mozilla Firefox\firefox.exe"))
;	root_menu.set_item_icon("Firefox", "C:\Program Files (x86)\Mozilla Firefox\firefox.exe", 1)
;	
;	root_menu.add_item("Steam", new FunctionCall("FRun", "D:\steam\Steam.exe"))
;	root_menu.set_item_icon("Steam", "D:\steam\Steam.exe", 1)
;	
;	root_menu.add_item("Notepad++", new FunctionCall("FRun", "C:\Program Files (x86)\Notepad++\notepad++.exe"))
;	root_menu.set_item_icon("Notepad++", "C:\Program Files (x86)\Notepad++\notepad++.exe", 1)
;	
;	root_menu.add_item("Files", new FunctionCall("RunSingle", "C:\Program Files (x86)\CubicExplorer\CubicExplorer.exe"))
;	root_menu.set_item_icon("Files", "C:\Windows\system32\SHELL32.dll", 5)
;	
;	root_menu.add_item("Terminal", new FunctionCall("RunSingle", "E:\cygwin\bin\mintty.exe -i /Cygwin-Terminal.ico -"))
;	root_menu.set_item_icon("Terminal", "E:\cygwin\Cygwin-Terminal.ico", 1)
;	
;	root_menu.add_item("Task Manager", new FunctionCall("FRun", "taskmgr"))
;	root_menu.set_item_icon("Task Manager", "C:\Windows\System32\taskmgr.exe", 1)
;	
;	root_menu.add_separator()
;	
;	exit_menu := new OGUI_Menu("Exit")
;		exit_menu.add_item("Shutdown", Func("FShutdown"))
;		exit_menu.add_item("Restart", Func("FReboot"))
;	root_menu.add_menu(exit_menu)
;	root_menu.set_item_icon(exit_menu.name, "C:\Windows\system32\SHELL32.dll", 28)

;#space:: root_menu.show()

