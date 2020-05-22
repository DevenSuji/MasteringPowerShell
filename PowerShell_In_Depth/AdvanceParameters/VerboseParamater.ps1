function Get-SystemInfo {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            ValueFromPipelineByPropertyName = $True)]
        [string[]]$computerName
    )
    BEGIN { }
    PROCESS {
        foreach ($computer in $computername) {
            Write-Verbose "Connecting to $computer"
            $os = Get-WmiObject –class Win32_OperatingSystem `
                -ComputerName $computer
            $cs = Get-WmiObject –class Win32_ComputerSystem `
                -ComputerName $computer
            Write-Verbose "Connection done, building object"
            $props = [ordered]@{
                OSVersion      = $os.version
                Model          = $cs.model
                Manufacturer   = $cs.manufacturer
                ComputerName   = $os.PSComputerName
                OSArchitecture = $os.osarchitecture
            }
            $obj = New-Object –TypeName PSObject –Property $props
            Write-Verbose "Object done, OS ver is $($os.version)"
            Write-Output $obj
        }
    }
    END { }
}