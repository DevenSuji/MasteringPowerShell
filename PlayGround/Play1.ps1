function Show-This {
    Write-Host "Inside the function" –Foreground Green
    Write-Host "Variable contains '$variable'" –Foreground Green
    $variable = 'Function'
    Write-Host "Variable now contains '$variable'" –Foreground Green
    gw -Class Win32_BIOS
}
Write-Host "Inside the script" –Foreground Red
$variable = "Script"
Write-Host "Variable now contains '$variable'" –Foreground Red
New-Alias -Name gw -Value Get-WmiObject -Force
Gw -Class Win32_ComputerSystem
Show-This
Write-Host "Back in the script" –Foreground Red
Write-Host "Variable contains '$variable'" –Foreground Red
Write-Host "Done with the script" –Foreground Red