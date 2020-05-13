$block = {
    Import-Module ServerManager
    Get-WindowsFeature | Where-Object { $_.Installed } |
    Select-Object Name, DisplayName, Description |
    ConvertTo-HTML
}

&$block | Out-File installed.html