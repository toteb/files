# Get-Member (gm)- > shows all properties of Object "Get-Process"
Get-Process *a | Get-Member

#Adding custom property to select-object : 
get-process | Select-Object -First 5 -Property name, @{name='procId';expression={$_.id}}

#Opens small nice GUI with a lot of selectable and filterable stuff. 
Get-Process | Out-GridView

# Copy output to Clipboard 
get-process *b | clip

# Measuring object
Get-Process | Measure-Object

#Sorting Object 
Get-Process | Sort-Object ws -Descending | Select-Object -First 5

#With powershell Core - 
Get-WinEvent -LogName Security -MaxEvents 5

#execute command on remote a machine
Invoke-Command -ComputerName PC1 -ScriptBlock {Get-WinEvent -LogName Security -MaxEvents 5} 

# Compare objects 
Compare-Object
#Example: Take get-process into $procs with notepad running and same for $procs2 but without notepad running. 
Compare-Object -ReferenceObject $procs -DifferenceObject $procs2 -Property Name

$confirmpreference # → shows confirm preference for various command sorted by severity of impact 

# $_ represents the current pipeline object and let's you access a property of a piped in object instead of the entire object
# $psitem is same as $_
# All above powershell 3, we can skip entirely $_ or $psitem and pipe directly -? Get-Process | where HandleCount -gt 900

# ? - # alias for Where-Object
# % - # alias for ForEach-Object