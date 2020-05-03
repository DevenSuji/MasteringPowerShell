 
# param(  
#     [String[]]$ComputerName,
#     [Switch]$LogOffline  
# )  

$UserID = 'enterprise\neatserveradmin'
        
$Password = (Get-Content -Path C:\Temp\NeatServer.txt | ConvertTo-SecureString)
        
$Creds = (New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList @($UserID, $Password))

$server_name = 'LHRWINSQLT060'
try {          
    #Get-WmiObject -Class MSFC_FCAdapterHBAAttributes -Namespace 'root\WMI' -ComputerName $server_name -Credential $Creds 
    Get-WmiObject -Class MSFC_FibrePortHbaAttributes -Namespace 'root\WMI' -ComputerName $server_name -Credential $Creds
       | ForEach-Object {  
        $hash = @{  
            ComputerName     = $_.__SERVER  
            NodeWWPN          = (($_.NodeWWN) | ForEach-Object { "{0:X2}" -f $_ }) -join ":"  
            Active           = $_.Active  
            DriverName       = $_.DriverName  
            Model            = $_.Model  
            ModelDescription = $_.ModelDescription  
        }  
        New-Object psobject -Property $hash  
    }#Foreach-Object(Adapter)  
}#try 
catch { 
    Write-Warning -Message $_ 
    if ($LogOffline) { 
        "$Computer is offline or not supported" >> "$home\desktop\Offline.txt" 
    } 
} 
     



Get-WmiObject -Class MSFC_FCAdapterHBAAttributes -Namespace 'root\WMI' -ComputerName $server_name -Credentials $Creds | Select -Expandproperty Attributes | % { ($_.PortWWN | % {"{0:x2}" -f $_}) -join ":"}

Namespace    = 'root\WMI' 
Class        = 'MSFC_FCAdapterHBAAttributes'  
ComputerName = $Computer 