$UserID = 'enterprise\NeatServerAdmin'
        
$Password = (Get-Content 'C:\TEMP\NeatServer.txt' | ConvertTo-SecureString)
    
$Creds = (New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList @($UserID, $Password))

$PSDefaultParameterValues = @{"Get-WmiObject:credential" = $creds }

Get-WmiObject -Class win32_operatingsystem -ComputerName 'tpawinignp017' -Property * | Select-Object -Property *