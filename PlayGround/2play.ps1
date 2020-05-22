function Get-SystemInfo {
    $OperatingSystem = Get-WmiObject -Class Win32_OperatingSystem -ComputerName localhost
    $ComputerSystem = Get-WmiObject -Class Win32_ComputerSystem -ComputerName localhost
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