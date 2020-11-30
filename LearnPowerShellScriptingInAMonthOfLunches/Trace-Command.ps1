#Trace-Command -Expression { Get-Process | ConvertTo-Html | Out-Null } -Name ParameterBinding -PSHost
Trace-Command -Expression { ("55" –eq 55) } -Name ParameterBinding -PSHost
