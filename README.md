# AHK_AutoTyper
Simple auto typer created with AutoHotKey

The program reads lines from "TestInputs.conf", types the contents of each line to the active text field, sends [Enter] and waits 0.5 seconds before continuing to the next line.

#Usage
USAGE: Add inputs, one for each line, to "TestInputs.conf", then save the file. Run "TestInputs.exe" and press Ctrl+9 to activate.
Lines starting with "#" are ignored
Example:

1
mail@mail.com
mypassword123
2
