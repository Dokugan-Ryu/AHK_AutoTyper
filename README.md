# AHK_AutoTyper
Simple auto typer created with and compiled with AutoHotKey.

The program reads lines from "AutoTyper.txt", types the contents of each line to the active text field, sends [Enter] and waits 0.5 seconds before continuing to the next line.

# Usage
Add inputs, one for each line, then save this file. Run "AutoTyper.exe" and press Ctrl+9 to activate.

Lines starting with "#" and inside "/* ... */" are ignored.

Settings:

	delay=number	Delay between inputs for each line in microseconds

Example:

1

example@example.com

mypassword123

2
