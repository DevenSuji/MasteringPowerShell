function Get-ComputerStatus {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline = $True, Mandatory = $True)]
        [ValidateNotNullorEmpty()]
        [ValidatePattern("^\w+$")]
        [Alias("CN", "Machine", "Name")]
        [string[]]$ComputerName,
        [string]$ErrorLogFilePath,
        [switch]$ErrorAppend
    )
    
    begin {
        # Intentionally Empty
    }
    
    process {
        foreach ($computer in $Computername) {
            $OS = Get-CimInstance win32_operatingsystem -computername $computername |
            Select-Object -property CSName, TotalVisibleMemorySize, FreePhysicalMemory,
            NumberOfProcesses,
            @{Name = "PctFreeMemory"; Expression = { ($_.freephysicalmemory / `
                        ($_.TotalVisibleMemorySize)) * 100 }
            },
            @{Name = "Uptime"; Expression = { (Get-Date) - $_.lastBootUpTime } }

            $cpu = Get-CimInstance win32_processor -ComputerName $computername |
            Select-Object -Property LoadPercentage

            $vol = Get-Volume -CimSession $computername -DriveLetter C |
            Select-Object -property @{Name = "PctFreeC"; Expression = `
                { ($_.SizeRemaining / $_.size) * 100 }
            }
            #TODO: Clean up output
            $os, $cpu, $vol
        } #foreach $computer
    }
    
    end {
        # Intentionally Empty
    }
}