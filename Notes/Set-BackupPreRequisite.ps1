# Client Server should be reachable from the master and media server
# Check if netbackup services are running.
$ComputerName = 'server'
$NetBackUpServiceStatus1 = Get-Service -Name 'NetBackup Client Service' -ComputerName $ComputerName


#$NetBackUpServiceStatus = (Get-WmiObject -ComputerName tpawinignp017 -Class Win32_Service -Filter "Name='NetBackup Client Service'").State

if ($NetBackUpServiceStatus1.Status -ne 'Running') {
    $NetBackUpServiceStatus1 | Set-Service -Status Running
    Write-Output "NetBackup Client Service is running now"
}
else {
    Write-Output "NetBackup Client Service is already running"
}

#Invoke-WmiMethod -Path "Win32_Service.Name='NetBackup Client Service'" -Name StopService -Computername DC1

$UserID = 'enterprise\NeatServerAdmin'
        
$Password = Get-Content 'C:\TEMP\NeatServer.txt' | ConvertTo-SecureString
   
$Creds = (New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList @($UserID, $Password))

$Path = "HKLM:\SOFTWARE\Veritas\NetBackup\CurrentVersion\Config"
$Property1 = "Browser"
$Property2 = "Client_Name"
$Value = $ComputerName + '-bka'

$key = 'HKLM:\SOFTWARE\Veritas\NetBackup\CurrentVersion\Config\Server'
$valuename = 'Server'

Invoke-Command -ComputerName $ComputerName -scriptblock {

    Test-path $key
    
}

$Stoploop = $false
[int]$Retrycount = "0"

# Registry entry

Get-ItemProperty -Path $Path -Name server -

# Firewall ports to be opened on the client 1556, 13782, 13724 

# Oldsmar server 
try {
    $ping = get-wmiobject -ComputerName $ComputerName -Query "select * from win32_pingstatus where Address='$comp'"
    if ($ping.statuscode -eq 0) {
        $RemoteSession = New-PSSession -ComputerName $ComputerName -Credential $Creds
        Invoke-Command -Session $RemoteSession -ScriptBlock { param($ComputerName, $Path, $Property1, $Property2, $Value)        
            Set-ItemProperty -Path $path -Name $Property1 -Value $Value
            Set-ItemProperty -Path $path -Name $Property2 -Value $Value
        } -ArgumentList $ComputerName, $Path, $Property1, $Property2, $Value
                   
        Write-Output "Registry Key Tweaked Successfully" 
        $Stoploop = $true
    }
    else {
        Write-Output "Machine $server_item is not yet online. Retrying in 3 minute..."
        Start-Sleep -Seconds 180
        $Retrycount = $Retrycount + 1
    }
    
}
catch {
    if ($Retrycount -gt 30) {
        Write-Output "Failed the tweak the Registry"
        $Stoploop = $true
    }

}