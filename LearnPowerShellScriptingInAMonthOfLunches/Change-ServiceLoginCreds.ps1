Invoke-CimMethod -Query "Select * FROM Win32_Service where name='BITS'" -Method Change -Arguments @{'StartName' = 'Enterprise\sujide01';
    'StartPassword'                                                                                             = 'Mer0*Chamkauchu'
} -ComputerName $env:COMPUTERNAME


Invoke-CimMethod -Query "SELECT * FROM Win32_Service WHERE Name='BITS'"
                 -Method Change
                 -Arguments @{'StartName'='LocalSystem'}