<#
The $LASTEXITCODE Variable
When you call an executable program instead of a PowerShell Cmdlet, Script or Function, the
$LASTEXITCODE variable automatically contains the process’s exit code. Most processes use the
convention of setting an exit code of zero when the code finishes successfully, and non-zero if an
error occurred, but this is not guaranteed. It’s up to the developer of the executable to determine
what its exit codes mean.
Note that the $LASTEXITCODE variable is only set when you call an executable directly, or via
PowerShell’s call operator (&) or the Invoke-Expression cmdlet. If you use another method such as
Start-Process or WMI to launch the executable, they have their own ways of communicating the
exit code to you, and will not affect the current value of $LASTEXITCODE.
#>

PING.EXE 192.168.45.90 -n 1

$LASTEXITCODE


<#
The $? Variable
The $? variable is a Boolean value that is automatically set after each PowerShell statement or
pipeline finishes execution. It should be set to True if the previous command was successful, and
False if there was an error.
When the previous command
#>

Get-ADUser -Identity sujide01 -ErrorAction SilentlyContinue | Out-Null
$?


