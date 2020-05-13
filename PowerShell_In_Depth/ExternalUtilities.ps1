
$d = driverquery /fo csv | ConvertFrom-Csv


$d | Where-Object { $_."Driver Type" -notmatch "Kernel" } |
Sort-Object @{expression = { $_."Link date" -as [datetime] } } -desc |
Select-Object -first 5 -prop "Display Name", "Driver Type", "Link Date"


NBTSTAT -n

