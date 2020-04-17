$ComputerName = 'tpawinawxt002'

Restart-Computer -ComputerName $ComputerName -Force -Wait -For PowerShell;
while ((Get-Service -Name 'Netbackup Client Service' -ComputerName $ComputerName).status -ne "Running") {
    "Sleeping"; Start-Sleep -Seconds 120;
}

(Get-Service -Name 'Netbackup Client Service' -ComputerName $ComputerName).status
Get-Content -Path \\tpawinawxt002\C$\Users\sujide01.T1_001\Desktop\livecheck.txt