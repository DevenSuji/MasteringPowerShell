Get-Service | Group-Object –property Status
<#
Here you’re taking all the service objects and piping them to Group-Object, organizing
them into groups based on the Status property. What you get back is a different object.
Even though you started with service objects, Group-Object writes a different type of
object to the pipeline. You can verify this by piping your command to Get-Member:
#>

Get-Service | Group-Object -Property Status | Get-Member

(Get-Service | Group-Object -Property Status).group
(Get-Service | Group-Object -Property Status).Name
(Get-Service | Group-Object -Property Status).Values

$Services = Get-Service | Group-Object -Property Status
$Services[0] # Gets the Running Sets of Services
$Services[1] # Gets the Stopped Sets of Services

$Services[0].Group[0..5] # Gets the first 5 Running Sets of Services
$Services[1].Group[0..5] # Gets the first 5 Stopped Sets of Services

<#
Grouping objects can come in handy when you’re more interested in the collective
results. For example, suppose you want to find out what types of files are in a given
folder. We’ll look at a local folder, but this would easily translate to a shared folder on
one of your file servers. At a glance you can see which file types are most in use
#>

$files = Get-ChildItem C:\Users\sujide01\Documents -recurse –file | Group-Object -Property Extension

$files | Sort-Object Count -descending | Select-Object -first 5 Count, Name

$services = Get-WmiObject –Class Win32_Service | Group-Object StartMode –AsHashTable

$services.Unknown.Name

<#
Finally, sometimes you don’t care about the grouped items themselves, only the results
of the grouping. In those situations you can use the –NoElement parameter, which
omits the Group property.
#>

Get-ChildItem -Path C:\Users\sujide01\Documents\BitBucketProd -Recurse -File | `
    Group-Object extension -NoElement | `
    Sort-Object count -Descending | `
    Select-Object -first 5


