#SingleInstance force
LShift::
	Send {LShift Down}
return
LShift Up::
	SetKeyDelay 50
	Send {LShift Up}{LShift Down}{LShift Up}
return