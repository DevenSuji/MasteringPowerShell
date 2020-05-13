[CmdletBinding()]
param (
    [Parameter(Mandatory = $True)]
    [String]$Computer,
    [int]$DriveType = 3
)

#[string]$ComputerName = 'DAYWRK64W10126'

Get-WmiObject –Class Win32_LogicalDisk –Filter "DriveType=3" -ComputerName $Computer | 
Select-Object –Property DeviceID, @{Name = 'ComputerName'; Expression = { $_.PSComputerName } }, Size, FreeSpace



Get-WmiObject –Class Win32_Service |
Where-Object {$_.StartMode –eq 'Auto' –and $_.State –ne 'Running' }