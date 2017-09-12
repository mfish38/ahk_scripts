;What is it?
;This script allows the user to click a location on screen using the arrow keys.  Although windows
;comes with facilities to do this, it is slower and less accurate than the method implemented here.

;How to use it
;To use this script initiate selection mode by pressing the windows key and z (note that the windows
;key must be pressed first).  By successively tapping the arrow keys in the direction of the desired
;selection, the cross hairs will home in on the desired location.  Once the desired location is
;reached, tap left control to left click, or left alt to right click.

;Advanced Usage
;If one of the lines of the cross hair is not already over the desired location, tap the arrow keys
;in the diagonal direction towards the desired location until at least one line is over it, then
;adjust the remaining line.  This can greatly reduce the number of adjustments needed to click a
;desired location.

;How it works
;The script implements the binary search algorithm
;(http://en.wikipedia.org/wiki/Binary_search_algorithm) as a method of selection a mouse click
;location.  Using the this algorithm, the worst case number of arrow key presses needed to select a
;single given pixel in a given area is (floor(log2 Width) + floor(log2 Height)).  For a 1080p
;monitor this translates to a worse case of 20 arrow key presses.  That's a maximum of 20 key
;presses to select a single pixel out of 2,073,600!  Additionally, given that the user generally
;only needs to select one of many pixels on a button to trigger the desired action, the average
;number of arrow key presses will be lower than this.  Also, by pressing the arrow keys in the
;direction of the desired quadrant until at least one line is over the desired clickable element,
;some of the key presses occur in parallel.

;TODO: monitor selection
;possible active window option:
;WinGetPos, x, y, width, height, A

#SingleInstance force
#NoTrayIcon

#z::
;Set click() to use screen coordinates
CoordMode, Mouse, Screen

;Get the search area.
x := 0
y := 0
width := A_ScreenWidth
height := A_ScreenHeight

;Set the range of the binary search to the bounds of the search area
x_min := x
x_max := x + width
y_min := y
y_max := y + height

;Initiate a binary search for the location the user wants to click
loop {
	;Calculate the midpoint of the current search range
	x_mid := (x_max + x_min) // 2
	y_mid := (y_max + y_min) // 2

	;Display a cross hair over the midpoint.  Avoid dependency on GDI by using really oddly shaped 
	;windows to draw lines.
	;Based on http://www.autohotkey.com/board/topic/50910-draw-line-gui/?p=318127
	Gui, -Caption +ToolWindow +AlwaysOnTop
	Gui, Color, Red
	Gui, Show, NA h %height% w 1 x %x_mid% y %y%
	Gui, 2:-Caption +ToolWindow +AlwaysOnTop
	Gui, 2:Color, Red
	Gui, 2:Show, NA h 1 w %width% x %x% y %y_mid%
	
	;Wait for the user to input a command
	Input, key, I L1, {Left}{Right}{Up}{Down}{LControl}{LAlt}
		
	if (ErrorLevel = "EndKey:Up"){
		;Reduce the search range to the upper half of the current search range
		y_max := y_mid - 1
	} else if (ErrorLevel = "EndKey:Down"){
		;Reduce the search range to the lower half of the current search range
		y_min := y_mid + 1
	} else if (ErrorLevel = "EndKey:Left"){
		;Reduce the search range to the left half of the current search range
		x_max := x_mid - 1
	} else if (ErrorLevel = "EndKey:Right"){
		;Reduce the search range to the right half of the current search range
		x_min := x_mid + 1
	} else if (ErrorLevel = "EndKey:LControl"){
		;Remove the cross hair so that it doesn't interfere with clicking
		Gui, Destroy
		Gui, 2:Destroy
		
		;Click the midpoint of the current search range
		Click %x_mid% %y_mid%
		
		;The search is finished
		break
	} else if (ErrorLevel = "EndKey:LAlt"){
		;Remove the cross hair so that it doesn't interfere with clicking
		Gui, Destroy
		Gui, 2:Destroy
		
		;Click the midpoint of the current search range
		Click Right %x_mid% %y_mid%
		
		;The search is finished
		break
	}
}

return
