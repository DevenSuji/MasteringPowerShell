function stop-wmiprocess {
    [CmdletBinding(SupportsShouldProcess = $True,
        ConfirmImpact = "Medium" )]
    param (
        [parameter(Mandatory = $True)]
        [string]$name
    )
    if ($psCmdlet.ShouldProcess("$name", "Stop Process")) {
        Get-WmiObject -Class Win32_Process -Filter "Name = '$name'" |
        Invoke-WmiMethod -Name Terminate
    }
}


stop-wmiprocess -name chrome