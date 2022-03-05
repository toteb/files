powershell.exe -command "& {'C:\Users\nikolay\github files\files\Foreach-ObjectFast.ps1'}"

# Where-Object is just...
$r1 = Get-Service | Where-Object { $_.Status -eq 'Running' }

# a special case of Foreach-Object
$r2 = Get-Service | Foreach-Object { if ($_.Status -eq 'Running') { $_ } }

Compare-Object -ReferenceObject $r1 -DifferenceObject $r2 -IncludeEqual