Get-Command -Verb Get | Measure-Object

Get-Process | Measure-Object -Property PM -Average -Sum -Min -Max

$files = Get-ChildItem C:\Users\sujide01\Documents -recurse –file | Group-Object Extension

$files | Sort-Object Count -Descending | Select-Object -First 5 Count, Name, @{Name = "Size"; Expression = { ($PSitem.Group | Measure-Object Length -Sum).Sum } }

<#
Here you created a custom property called Size that took the Group property from
each GroupInfo object and piped it to Measure-Object to get the sum of the length
property. This is a nice example of the PowerShell’s flexibility and capability. You
started out by running a simple DIR command and ended up with completely different
but extremely valuable output.
#>

