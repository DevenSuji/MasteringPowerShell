function get-disk {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $True)]
        [ValidateRange(1, 5)]
        [uint32]$drivetype,

        [Parameter(Mandatory = $True)]
        [AllowNull()]
        [AllowEmptyString()]
        [string]$computername
    )
    if ($computername -eq $null -or $computername -eq "") {
        $computername = "$env:COMPUTERNAME"
    }
    Write-Debug $computername
    Get-WmiObject -Class Win32_LogicalDisk -Filter "DriveType = $drivetype"
    -ComputerName $computername |
    Select-Object DeviceID,
    @{N = "PercentFree"; E = { [math]::Round((($_.FreeSpace / $_.Size) * 100), 2) } }
}


$comp = $null
get-disk -drivetype 3 -computername $comp -Debug | Format-Table -AutoSize

$comp = ""
get-disk -drivetype 3 -computername $comp -Debug | Format-Table -AutoSize