
; This class allows a function call to be "frozen" with a given set of arguments.  This "frozen"
; function call can then be executed at a later time.  This is useful if you want pass a callback
; function with a given set of arguments to another function.
;
; Example:
; 
; function(callback)
; {
;    callback.()
; }
; 
; callback(arg1, arg2)
; {
;    MsgBox, % arg1 . " " . arg2
; }
; 
; function(new FunctionCall("callback","Hello","World!"))

class FunctionCall
{
	__New(function, arguments*)
	{
		this.function := Func(function)
		this.arguments := arguments
	}
	
	__Call()
	{
		this.function.(this.arguments*)
	}
}
