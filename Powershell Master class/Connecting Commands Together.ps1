# Get-Member (gm)- > shows all properties of Object "Get-Process"
Get-Process *a | Get-Member

# Keep the objects as long as we can . Object can be manipulated. Strings can't.

#Adding custom property to select-object : 

get-process | Select-Object -First 5 -Property name, @{name='procId';expression={$_.id}}
