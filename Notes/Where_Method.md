# Where method is a very method that comes aloing with PowerShell V4. This Where method can be used to replace Where-Object. Look at the examples below.

Get-Process | Where-Object -FilterScript {$_.workingset -gt 1mb -AND $_.company -notmatch "Microsoft"}
Get-Process | Where {$_.workingset -gt 1mb -AND $_.company -notmatch "Microsoft"}
ps | ? {$_.ws -gt 1mb -AND $_.company -notmatch "Microsoft"}

The above listed Where-Object, Where and ? can be replaced with the below Where method

(Get-Service -Name M*).Where{$PSItem.status -eq 'stopped'}