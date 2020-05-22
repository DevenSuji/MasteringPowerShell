$Session = New-PSSession -ComputerName daywrk64w10126
$DriveType = 3

#This Will Not Work. It will error out
Invoke-Command -Session $Session -ScriptBlock { Get-WmiObject -Class Win32_LogicalDisk -Filter "DriveType=$DriveType" }

# This method uses Using. This works.

Invoke-Command -Session $Session -ScriptBlock { Get-WmiObject -Class Win32_LogicalDisk -Filter "DriveType=$Using:DriveType" }
