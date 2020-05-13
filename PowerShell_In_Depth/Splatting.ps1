#Get-WmiObject -Class Win32_LogicalDisk -ComputerName SERVER2 -Filter "DriveType=3" -Credential $cred

# This is how to do splatting....

$params = @{class = 'Win32_LogicalDisk'
    computername  = 'ServerName'
    Filter        = "DriveType=3"
    Credential    = $cred
}

Get-WmiObject @params