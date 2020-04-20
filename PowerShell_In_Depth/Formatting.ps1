Get-Process | Format-Wide -Property ID -Column 4

Get-Process | Format-Wide -Property ID –Autosize

Get-Service | Format-Table -Property Name, Status

Get-Service | Format-Table -Property Name, Status –AutoSize

Get-Eventlog system -Newest 5 | ft Source, Message -Wrap –auto

get-process | Format-Table Name, ID, @{name = 'VM'; expression = { $_.VM / 1MB }; formatstring = 'N2'; align = 'right'; width = 8 }

Get-WmiObject -Class Win32_LogicalDisk -Filter "Drivetype=3" |
Where-Object { ($_.FreeSpace / $_.Size) -lt .9 } |
Format-Table @{name = 'DriveLetter'; expression = { $_.DeviceID } },
@{name = 'Size'; expression = { $_.Size / 1GB }; FormatString = 'N2' },
@{name = 'FreeSpace'; expression = { $_.FreeSpace / 1GB }; FormatString = 'N2' } -AutoSize