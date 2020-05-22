function Get-SystemInfo {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            ValueFromPipelineByPropertyName = $True)]
        [Alias('hostname')]
        [ValidateScript( { Test-Connection -Computername $_ -Count 1 -Quiet })]
        [ValidateSet("Security","System","Application")] #Validate Set is used to confine the value of the parameter to a set of pre defined values.
        [ValidatePattern("\w+\\\w+")] # This validation test is a pattern test using a regular expression pattern
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