pw := "milan123qaz!"


^P::
CoordMode, Mouse, Screen
Click, 895, 506 Left, 1
Sleep, 500
Send, {Text}%pw%
Sleep, 500
Send, {Enter}

ExitApp