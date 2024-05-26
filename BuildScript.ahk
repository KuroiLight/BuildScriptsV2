#NoEnv
remove_ext := "S)(.+)(?:\..+)"
remove_filename := "S)(.+\\)(?:.+)"

GetFile(fullpath, directory, extless)
version := GetVersion(extless)
GetAhk(ahkdir, ahk2exe, mpress)

par_in := "/in """ . fullpath . """ "

par_out32 := "/out """ . extless . "-U32_" . version . ".exe" . """ "
par_bin32 := "/bin """ . ahkdir . "Unicode 32-bit.bin" . """ "
par_32 := ahk2exe . " " . par_in . " " . par_out32 . " " . par_bin32 . (mpress ? " /mpress 1" : "")
RunWait, % par_32

par_out64 := "/out """ . extless . "-U64_" . version . ".exe" . """ "
par_bin64 := "/bin """ . ahkdir . "Unicode 64-bit.bin" . """ "
par_64 := ahk2exe . " " . par_in . " " . par_out64 . " " . par_bin64 . (mpress ? " /mpress 1" : "")
RunWait, % par_64
return

GetFile(ByRef fullpath, ByRef directory, ByRef extless) {
    global remove_ext, remove_filename
    
    FileSelectFile, fullpath, 1+2, %A_WorkingDir%,, *.ahk
    if(ErrorLevel)
        return false
    
    directory := RegExReplace(fullpath, remove_filename, "$1")
    extless := RegExReplace(fullpath, remove_ext, "$1")
    return true
}

GetVersion(extless) {
    version_file := extless . "_version.txt"
    FileReadLine, version, %version_file%, 1
    if(ErrorLevel)
        version := "0.0.0"
    version := IncrementVer(version)
    FileDelete, %version_file%
    FileAppend, %version%, %version_file%
    TimeToClip(version)
    return version
}

TimeToClip(version_number) {
    FormatTime, Changelog_Stamp,, (MM/dd/yy HH:mm:ss)
    Clipboard := version_number . " - " . Changelog_Stamp
}

GetAhk(ByRef dir, ByRef ahk2exe, ByRef mpress) {
    global remove_filename
    EnvGet, EnvPath, Path
    Paths := StrSplit(EnvPath, ";")
    for i, v in Paths {
        if(FileExist(v . "Ahk2Exe.exe")) {
            ahk2exe := v . "Ahk2Exe.exe"
            break
        } else if(FileExist(v . "Compiler\Ahk2Exe.exe")) {
            ahk2exe := v . "Compiler\Ahk2Exe.exe"
            break
        }
    }
    if(!ahk2exe)
        ahk2exe := "C:\Program Files\AutoHotkey\Compiler\Ahk2Exe.exe"
    
    dir := RegExReplace(ahk2exe, remove_filename, "$1")
    if(FileExist(dir . "mpress.exe")) {
        mpress := dir . "mpress.exe"
    }
}

IncrementVer(vers) {
    version_numbers := StrSplit(vers, ".")

    Loop % len:=version_numbers.MaxIndex() {
        ind := len - (A_Index - 1)
        new_v := version_numbers[ind] + 1
        
        if(StrLen(new_v) > StrLen(version_numbers[ind]) and ind != 1) {
            version_numbers[ind] := SubStr(new_v, 2)
            Continue
        } else {
            if(StrLen(new_v) < StrLen(version_numbers[ind]))
                new_v := "0" . new_v
            version_numbers[ind] := new_v
            break
        }
    }

    for i, v in version_numbers {
        result .= v . "."
    }
    
    return RTrim(result, ".")
}
    
        
    