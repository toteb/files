# Test script - LIKE TCP#
$stopwatch = [System.Diagnostics.Stopwatch]::StartNew()

# search for all log files changed in the last 12 hours
$cutOff = (Get-Date).AddHours(-12)

# get all files
$files = Get-ChildItem -Path $env:windir -Filter *.log -Recurse -ErrorAction SilentlyContinue -Force 

# use a list to store the original results
[System.Collections.ArrayList]$result = @()

foreach($_ in $files)
{
  # find only files changed within past 12 hours
  If ($_.LastWriteTime -ge $cutOff)
  { 
    $null = $result.Add($_)
    $_.FullName
  }
}

$report = '{0} elements in {1:n2} seconds' 
$report -f $result.Count, $stopwatch.Elapsed.TotalSeconds
