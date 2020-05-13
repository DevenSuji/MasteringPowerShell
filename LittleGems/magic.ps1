$service = Get-Service | Select-Object -first 1

#The below command won’t work:
<# The output is Service name is System.ServiceProcess.ServiceController.name which is not what I expected#>

Write-Host "Service name is $service.name" –ForegroundColor Green

# Instead use this trick

Write-Host "Service name is $($service.name)" –foregroundcolor Green