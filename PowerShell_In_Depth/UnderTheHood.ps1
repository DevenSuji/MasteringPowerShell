$pn = "-n 1"
$addr = "127.0.0.1"

[management.automation.psparser]::Tokenize("ping $addr $pn", [ref]$null) | ft Content, Type –a


Invoke-Expression "ping $addr $pn"


$freespace = 560
$size = 1000
Write-Host "There is $(100 - (($freespace / $size) * 100))% free space"