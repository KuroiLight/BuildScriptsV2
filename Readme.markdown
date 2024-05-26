# BuildScript v2
###### Automates Compiles for selected ahk file to Unicode 32/64 bit.
###### works with Latest AutoHotkey Unicode 32&64Bit

#### What it does
* reads the current version number from a file (<yourscriptsname>_version.txt) and increments it, then adds the version number to your executable name
* tries to find ahk2exe
* compiles FileSelected target script to Unicode x64 and x32, and enables mpress if present to compress binaries
* will copy a string in the form of <version number - (date time)> to the clipboard for reference

#### Installation
> Download the pre-compiled binary, or download the .ahk file and install AutoHotkey_L from the official site and run the script. All available settings can be changed from the INI that is created during the first run. An explanation of the INI settings is further below. AutoHotkey_L can be found here https://github.com/Lexikos/AutoHotkey_L or http://ahkscript.org/

#### Usage
make sure the ahk compiler (ahk2exe) is located in "C:\Program Files\AutoHotkey\Compiler\" or its directory is in your Path variable.
[optional] create a file named <yourscriptsname>_version.txt and put the a version number in it.
Launch BuildScript, FileSelect Dialog will popup, select script, and it will do the rest.