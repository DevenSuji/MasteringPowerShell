cd WSMan:\localhost\Listener # This takes us to the directory where the listeners are listed.
ls

#Keep in mind that to work with the WSMAN PSDrive, you must be in an elevated
#PowerShell session. To change the port (using port 1000 as an example), type this:
PS C:\> Set-Item WSMan:\localhost\listener\*\port 1000

PS WSMan:\localhost\Listener\Listener_1682839512> cd WSMan:\localhost\Client\DefaultPorts
PS WSMan:\localhost\Client\DefaultPorts> dir


   WSManConfig: Microsoft.WSMan.Management\WSMan::localhost\Client\DefaultPorts

Type            Name                           SourceOfValue   Value
----            ----                           -------------   -----
System.String   HTTP                                           5985
System.String   HTTPS                                          5986

If you’ve set all of your servers to port 1000 (for example), then it makes sense to also
reconfigure your clients so that they use that port by default:
PS C:\> Set-Item WSMan:\localhost\client\DefaultPorts\HTTP 1000

#####################################################################################

WINRM Listeners
---------------
Enable-PSRemoting creates a single WinRM listener that listens on all enabled IP addresses on the system.

You can discover the existing listeners by using this: 

*** Get-WSManInstance winrm/config/Listener -Enumerate

The IP addresses that are being listened on are discovered like this

*** Get-WSManInstance winrm/config/Listener -Enumerate | select -ExpandProperty ListeningOn

Alternatively, you can use the WSMAN provider

dir wsman:\localhost\listener

Creating WINRM Listeners
------------------------

You can create a new listener by using the New-WSManInstance cmdlet:

PS C:\> New-WSManInstance winrm/config/Listener -SelectorSet @{Transport='HTTP'; Address="IP:10.10.54.165"} -ValueSet @{Port=8888}

You can see the new listener like this once created

dir wsman:\localhost\listener | Format-Table -AutoSize