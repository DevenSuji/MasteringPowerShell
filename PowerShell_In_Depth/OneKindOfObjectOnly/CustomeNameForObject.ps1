$os = Get-WmiObject -Class Win32_OperatingSystem
$users = Get-WmiObject -Class Win32_UserAccount
$disks = Get-WmiObject -Class Win32_LogicalDisk -filter "drivetype=3"
$diskObjs = @()
foreach ($disk in $disks) {
    $props = @{Drive = $disk.DeviceID
        Space        = $disk.Size
        FreeSpace    = $disk.FreeSpace
    }
    $diskObj = New-Object -TypeName PSObject -Property $props
    $diskObjs = $diskObjs + $diskObj
}
$userObjs = @()
foreach ($user in $users) {
    $props = @{UserName = $user.Name
        UserSID         = $user.SID
    }
    $userObj = New-Object -TypeName PSObject -Property $props
    $userObjs = $userObjs + $userObj
}
$props = @{ComputerName = $os.CSName
    OSVersion           = $os.version
    SPVersion           = $os.servicepackmajorversion
    Disks               = $diskObjs
    Users               = $userObjs
}
$obj = New-Object -TypeName PSObject -Property $props
$obj.PSObject.TypeNames.Insert(0, 'Deven.Made.Object')
Write-Output $obj

$obj | gm