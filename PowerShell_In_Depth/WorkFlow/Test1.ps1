$w1 = New-PSWorkflowSession -ComputerName "INLHTBM542"

$sb = {
    workflow Get-OS {
        Get-WmiObject -Class Win32_OperatingSystem |
        Select-Object -Property Caption
    }
    Get-OS
}

Invoke-Command -Session $w1 -ScriptBlock $sb