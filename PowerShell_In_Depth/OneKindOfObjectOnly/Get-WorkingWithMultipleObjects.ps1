$os = Get-WmiObject -Class Win32_OperatingSystem
$users = Get-WmiObject -Class Win32_UserAccount
$disks = Get-WmiObject -Class Win32_LogicalDisk -filter "drivetype=3"

$diskObjs = @() # Empty Array

# Enumerating Disks
foreach ($disk in $disks) {  
    $props = @{Drive = $disk.DeviceID
        Space        = $disk.Size
        FreeSpace    = $disk.FreeSpace
    } # Setting Up Single Disk Object

    $diskObj = New-Object -TypeName PSObject -Property $props # Creating the Disk Object
    $diskObjs += $diskObj # Appending to the Array
}

# Repeating the same for the users.
$userObjs = @()

foreach ($user in $users) {
    $props = @{UserName = $user.Name
        UserSID         = $user.SID
    }
    $userObj = New-Object -TypeName PSObject -Property $props
    $userObjs += $userObj
}

$props = [Ordered]@{ComputerName = $os.CSName
    OSVersion                    = $os.version
    SPVersion                    = $os.servicepackmajorversion
    Disks                        = $diskObjs
    Users                        = $userObjs
} # Combining the hash table

$obj = New-Object -TypeName PSObject -Property $props
Write-Output $obj | ft

$obj | gm