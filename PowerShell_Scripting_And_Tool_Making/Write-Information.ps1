<#
Function Get-Example {
    [CmdletBinding()]
    Param()
    Write-Information "First message" -tag status
    Write-Information "Note that this had no parameters" -tag notice
    Write-Information "Second message" -tag status
}
Get-Example -InformationAction SilentlyContinue -InformationVariable x


$x | Where-Object tags -in @('notice')
#>
<#
Function Test-Me {
    [cmdletbinding()]
    Param()
    Write-Information "Starting $($MyInvocation.MyCommand) " -Tags Process
    Write-Information "PSVersion = $($PSVersionTable.PSVersion)" -Tags Meta
    Write-Information "OS = $((Get-CimInstance Win32_operatingsystem).Caption)" -Tags Meta
    Write-Verbose "Getting top 5 processes by WorkingSet"
    Get-Process | Sort-Object WS -Descending |
    Select-Object -first 5 -OutVariable s
    Write-Information ($s[0] | Out-String) -Tags Data
    Write-Information "Ending $($MyInvocation.MyCommand) " -Tags Process
}
#>
<#
Function Test-Me2 {
    [cmdletbinding()]
    Param()
    Write-Host "Starting $($MyInvocation.MyCommand) " -ForegroundColor green
    Write-Host "PSVersion = $($PSVersionTable.PSVersion)" -ForegroundColor green
    Write-Host "OS = $((Get-CimInstance Win32_operatingsystem).Caption)" -ForegroundColor green
    Write-Verbose "Getting top 5 processes by WorkingSet"
    Get-Process | Sort-Object -property WS -Descending | Select-Object -first 5 -OutVariable s
    Write-Host ($s[0] | Out-String) -ForegroundColor green
    Write-Host "Ending $($MyInvocation.MyCommand) " -ForegroundColor green
}

test-me2 -InformationVariable inf2
#>

Function Test-Me3 {
    [cmdletbinding()]
    Param()
    if ($PSBoundParameters.ContainsKey("InformationVariable")) {
        $Info = $True
        $infVar = $PSBoundParameters["InformationVariable"]
    }
    if ($info) {
        Write-Host "Starting $($MyInvocation.MyCommand) " -ForegroundColor green
        (Get-Variable $infVar).value[-1].Tags.Add("Process")
        Write-Host "PSVersion = $($PSVersionTable.PSVersion)" -ForegroundColor green
        (Get-Variable $infVar).value[-1].Tags.Add("Meta")
        Write-Host "OS = $((Get-CimInstance Win32_operatingsystem).Caption)" -ForegroundColor green
        (Get-Variable $infVar).value[-1].Tags.Add("Meta")
    }
    Write-Verbose "Getting top 5 processes by WorkingSet"
    Get-Process | Sort-Object WS -Descending | Select-Object -first 5 -OutVariable s
    if ($info) {
        Write-Host ($s[0] | Out-String) -ForegroundColor green
        (Get-Variable $infVar).value[-1].Tags.Add("Data")
        Write-Host "Ending $($MyInvocation.MyCommand) " -ForegroundColor green
        (Get-Variable $infVar).value[-1].Tags.Add("Process")
    }
}
test-me3 -InformationVariable inf3

$inf3 | Group-object {$_.tags -join "-"}