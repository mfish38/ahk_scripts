
#SingleInstance force
#NoTrayIcon

#include %A_ScriptDir%\..\Library\RunSingleInstance.ahk

#w::RunSingleInstance("C:\Program Files (x86)\Mozilla Firefox\firefox.exe")

#e::Run "C:\Program Files (x86)\Notepad++\notepad++.exe"

;Run the following in python to get the available styles:
;	from pygments.styles import STYLE_MAP
;	STYLE_MAP.keys()
#t::RunSingleInstance("pythonw -m IPython qtconsole --style=native")

#c::RunSingleInstance("calc") 

#f::RunSingleInstance("explorer")
