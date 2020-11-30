[CmdletBinding()]
param (
    [Parameter(Mandatory = $True, ValueFromPipeline = $True)]
    [ValidateNotNullOrEmpty()]
    [string[]]$NewPath
)

$CurrentValue = [Environment]::GetEnvironmentVariable("PSModulePath", "Machine")
[Environment]::SetEnvironmentVariable("PSModulePath", $CurrentValue + [System.IO.Path]::PathSeparator + "$NewPath", "Machine")
