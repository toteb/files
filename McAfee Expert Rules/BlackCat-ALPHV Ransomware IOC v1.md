Rule {
    Process {
        Include OBJECT_NAME { -v "cmd.exe" }
        Include OBJECT_NAME { -v "powershell*" }
        Include PROCESS_CMD_LINE { -v "*wmic csproduct get UUID*" }
    }
    Target {
        Match PROCESS {
        Include GROUP_SID { -v "S-1-16-12288" }
        Include GROUP_SID { -v "S-1-16-16384" }
        Include GROUP_SID { -v "S-1-5-32-544" }
        Include -access "CREATE"
        Exclude OBJECT_NAME { -v "msasn1.dll" }
	    Exclude OBJECT_NAME { -v "dbghelp.dll" }
	    Exclude VTP_PRIVILEGES 0x8
        }
    }
}