Rule {
    Process {
        Include OBJECT_NAME {
            -v "**"
        }
        Include PROCESS_CMD_LINE {
            -v "*wmic csproduct get UUID"
        }
    }
    Target {
        Match PROCESS {
        Include -access "CREATE" ; # Prevents section creation
        Exclude OBJECT_NAME { -v "msasn1.dll" }
	    Exclude OBJECT_NAME { -v "dbghelp.dll" }
	    Exclude VTP_PRIVILEGES 0x8
        }
    }
}