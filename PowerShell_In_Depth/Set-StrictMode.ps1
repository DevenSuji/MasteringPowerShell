Set-Strictmode –Version Latest
[int]$test = Read-Host "Enter a number"
Write-host $test
$a = [system.math]::PI * ($test * $test)
Write-Host "The area is " $a.ToDecimal(1)
