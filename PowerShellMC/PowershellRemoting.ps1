# & - > execution string 
# $comm = Get-Command → stores get-command as a sting inside comm variable. With &$comm we execute the actual string from the variable.

# Also to import module inside a session:
$dcs = "dc01", "dc02"
$mysession = New-PSSession -ComputerName $dcs
Import-Module -Name ActiveDirectory -PSSession $mysession

