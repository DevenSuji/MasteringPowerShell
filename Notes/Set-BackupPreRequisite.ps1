# Client Server should be reachable from the master and media server
# Check if netbackup services are running.

Get-Service -Name 'NetBackup Client Service' -ComputerName tpawinignp017 | Set-Service -Status Running

Get-WmiObject -ComputerName tpawinignp017 -Class Win32_Service -Filter "Name='NetBackup Client Service'"

Invoke-WmiMethod -Path "Win32_Service.Name='NetBackup Client Service'" -Name StopService -Computername DC1

# Registry entry

# Firewall ports to be opened on the client 1556, 13782, 13724 

# Oldsmar server 
