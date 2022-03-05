$stopwatch = [System.Diagnostics.Stopwatch]::StartNew()

# search for all log files changed in the last 12 hours
$cutOff = (Get-Date).AddHours(-12)

# get all files
Get-ChildItem -Path $env:windir -Filter *.log -Recurse -ErrorAction SilentlyContinue -Force |
  # find only files changed within past 12 hours
  Where-Object { $_.LastWriteTime -ge $cutOff } |
  # store them also in $result
  Tee-Object -Variable result |
  # output path
  Select-Object -ExpandProperty FullName

$report = '{0} elements in {1:n2} seconds' 
$report -f $result.Count, $stopwatch.Elapsed.TotalSeconds