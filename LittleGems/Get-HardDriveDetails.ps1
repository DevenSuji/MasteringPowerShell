Get-WmiObject -Class Win32_LogicalDisk -Filter "Drivetype=3" |
Where-Object { ($_.FreeSpace / $_.Size) -lt .9 } |
Format-Table @{name = 'DriveLetter'; expression = { $_.DeviceID } },
@{name = 'Size'; expression = { $_.Size / 1GB }; FormatString = 'N2' },
@{name = 'FreeSpace'; expression = { $_.FreeSpace / 1GB }; FormatString = 'N2' } -AutoSize