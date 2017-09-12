
RunSingleInstance(command){
	; Starts a program if it has not been started.  If it has already been started, then it is given focus.
	
	static running_pids := {}
	if running_pids.HasKey(command){
		pid := running_pids[command]
		IfWinExist ahk_pid %pid%
		{
			WinActivate ahk_pid %pid%
		} else {
			Run, %command%, , ,pid
			WinWait ahk_pid %pid%
			running_pids[command] := pid
		}
	} else {
		Run, %command%, , ,pid
		WinWait ahk_pid %pid%
		running_pids[command] := pid
	}
}
