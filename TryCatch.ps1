[CmdletBinding()]
param (
    [Parameter(Mandatory = $True)]
    [String]$MachineName
)
try {
    Get-ADComputer -Identity $MachineName -ErrorAction Stop
}
catch {
    Write-Output "Machine does not exist"
}