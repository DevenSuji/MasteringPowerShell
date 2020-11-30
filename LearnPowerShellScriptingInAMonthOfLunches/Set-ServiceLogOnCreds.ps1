function Get-MachineInfo {
    param (
        [string[]]$ComputerName,
        [string]$LogFailuresToPath,
        [string]$Protocol = "wsman",
        [switch]$ProtocolFallBack
    )
    foreach ($Computer in $ComputerName) {
        #Establishing Session Protocol
        if ($Protocol -eq 'Dcom') {
            $Option = New-CimSessionOption -Protocol dcom
        }
        else {
            $Option = New-CimSessionOption -Protocol Wsman        
        }
        # Creating the session
        $Session = New-CimSession -ComputerName $Computer -SessionOption $Option

        #Querying the data now
        $OS = Get-CimInstance -ClassName Win32_OperatingSystem -CimSession $Session

        #Closing the session
        $Session | Remove-CIMSession

        $OS | Select-Object -Prop @{n = 'ComputerName'; e = { $computer } }, Version, ServicePackMajorVersion 
    } #foreach
} #function