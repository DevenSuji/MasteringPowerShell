$Servers = Get-Content C:\Users\sujide01\Desktop\LiveServers.txt

foreach ($item in $Servers) {
    #Write-Host "Working on the computer $item"
    if (Test-Connection -TargetName $item -Quiet -ErrorAction SilentlyContinue) {
        Write-Host "$item is reachable"
    }
    else {
        Write-Host "$item is NOT reachable"
    }
    
}