# Help about_Functions_Advanced_Parameters
# about_Functions_CmdletBindingAttribute

function Get-SystemInfo {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            ValueFromPipelineByPropertyName = $True)]
        [string[]]$computerName
    )
    $OperatingSystem = Get-WmiObject -Class Win32_OperatingSystem -ComputerName $computerName
    $ComputerSystem = Get-WmiObject -Class Win32_ComputerSystem -ComputerName $computerName
    $props = [ordered]@{
        OSVersion      = $OperatingSystem.Version
        OSName         = $OperatingSystem.Caption
        Model          = $ComputerSystem.Model
        Manufacturer   = $ComputerSystem.Manufacturer
        ComputerName   = $OperatingSystem.PSComputerName
        OSArchitecture = $OperatingSystem.OSArchitecture
    }
    $NewPowerShellObject = New-Object -TypeName PSObject -Property $props
    Write-Output $NewPowerShellObject
}

Get-SystemInfo 

# In this code, objects are being given a ComputerName property with values from the
# original Name property and are then being piped into the Get-SystemInfo function.
# Both of the preceding examples are using pipeline input;

# Accepting Values by Pipeline

Get-Content names.txt | Get-SystemInfo

Get-ADComputer –Filter * |
Select-Object @{n = 'ComputerName'; e = { $_.Name } } |
Get-SystemInfo

# Accepting Values by Property

Get-SystemInfo –computerName SERVER2

#Obviously, the preceding just passes in a single computer name.

Get-SystemInfo –computerName (Get-Content names.txt)