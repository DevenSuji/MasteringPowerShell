function Get-RemoteListeningConfiguration {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $True, ValueFromPipeline = $True)]
        [ValidateNotNullOrEmpty()]
        [Alias("CN")]
        [string[]]$ComputerName,
        [string]$ErrorLog
    ) # param

    Begin {
    } # Begin
    Process {
        $ports = 22, 5985, 5986
        foreach ($Computer in $ComputerName) {
            foreach ($port in $ports) {
                Test-NetConnection -Port $port -ComputerName $Computer -ErrorAction SilentlyContinue -WarningAction SilentlyContinue | Select-Object ComputerName, RemotePort, TCPTestSucceeded
            }        
        }
    } # Process
    End {
        # Intentionally left empty
    } # End
} # Get-RemoteListeningConfiguration