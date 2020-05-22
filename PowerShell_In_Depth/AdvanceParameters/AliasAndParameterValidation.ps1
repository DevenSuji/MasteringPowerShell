function Get-SystemInfo {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            ValueFromPipelineByPropertyName = $True)]
        [Alias('hostname')]
        [ValidateCount(1, 5)]
        [ValidateLength(5, 20)]
        [string[]]$computerName
    )
    BEGIN { }
    PROCESS {
        foreach ($computer in $computername) {
            $os = Get-WmiObject –Class Win32_OperatingSystem `
                -ComputerName $computer
            $cs = Get-WmiObject –Class Win32_ComputerSystem `
                -ComputerName $computer
            $props = [ordered]@{
                OSVersion      = $os.version
                Model          = $cs.model
                Manufacturer   = $cs.manufacturer
                ComputerName   = $os.PSComputerName
                OSArchitecture = $os.osarchitecture
            }
            $obj = New-Object –TypeName PSObject –Property $props
            Write-Output $obj
        }
    }
    END { }
}


Get-SystemInfo