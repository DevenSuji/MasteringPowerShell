# You see the ... that shows in the output of the below commands.

Get-Module Microsoft.PowerShell.Utility

Get-Module Microsoft.PowerShell.Utility | Select-Object ExportedCommands


# One way around this issue to see more entries is to use one of our parentheticals as objects tips in section

(Get-Module Microsoft.PowerShell.Utility).ExportedCommands

#      OR

Get-Module Microsoft.PowerShell.Utility | Select-Object -ExpandProperty ExportedCommands

# OR Set the $FormatEnumerationLimit = -1
# See the difference by running both the commands
get-module Microsoft.PowerShell.Utility | Select-Object Name,ExportedCommands | format-list

$FormatEnumerationLimit = -1

get-module Microsoft.PowerShell.Utility | Select-Object Name,ExportedCommands | format-list
