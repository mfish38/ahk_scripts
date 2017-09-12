;Based on: http://www.autohotkey.com/board/topic/10348-make-sentences-start-with-capitals/?p=308958

; This module corrects capitalization.  Note that if another module performs a replacement, then it
; needs to apply the proper capitalization.

#SingleInstance force
#NoEnv
Process Priority,,High
SetBatchLines -1

State = 1

Loop {
	Input key, I L1 V,
		(Join
		{ScrollLock}{CapsLock}{NumLock}{Esc}{BS}{PrintScreen}{Pause}{LControl}{RControl}
		{LAlt}{RAlt}{LShift}{RShift}{LWin}{RWin}{F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}
		{Left}{Right}{Up}{Down}{Home}{End}{PgUp}{PgDn}{Del}{Ins}
		)
	
	If (StrLen(ErrorLevel) > 3){     ; NewInput, EndKey
		State = 1
	} Else If (InStr(".!?",key)){    ; Sentence end
		State = 2
	} Else If (InStr("`t `n",key)){  ; White space
		State += (State == 2)
	} Else {
		If (State = 3){              ; End-Space*-Letter
			StringUpper key, key
			SendInput {BS}{%key%}    ; Letter -> Upper case
		}
		State = 1
	}
}

~LButton::
~RButton::
~MButton::
~WheelDown::
~WheelUp::
~XButton1::
~XButton2::State = 1

::i::I
