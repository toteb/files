# BlackCat ALPHV Ransomware
## Description: Rule to detect common IOC's for BlackCat ALPHV Ransomware (see source)
### Version 0.1
### Author: mcn1k
#### Source: https://www.ic3.gov/Media/News/2022/220420.pdf , https://www.sentinelone.com/labs/blackcat-ransomware-highly-configurable-rust-driven-raas-on-the-prowl-for-victims/

Rule {
    Process {
        Include OBJECT_NAME { -v "cmd.exe" }
        Include OBJECT_NAME { -v "powershell*" }
        Include PROCESS_CMD_LINE { -v "*wmic csproduct get UUID*" }
        Include PROCESS_CMD_LINE { -v "*fsutil behavior set SymlinkEvaluation R2?:1*" }
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