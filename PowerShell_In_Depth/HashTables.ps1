$user = @{name     = 'DonJ';
    samAccountName = 'DonJ';
    department     = 'IT';
    title          = 'CTO';
    city           = 'Las Vegas'
}

$user

$user.department
$user.title
$user | get-member

$user.title.getType().Name

$user.keys
$user.Values
$user.count

# Adding a new key value pair to the Hash Table

if (-Not $user.containsKey("EmployeeNumber")) {
    $user.Add("EmployeeNumber", 11805)
}

# Removing a key value pair from the Hash Table
$user.Remove("employeenumber")

# Creating an empty hash table and adding key value pairs to it.

$hash = @{ }
$hash.Add("Computername", $env:computername)

$running = Get-Service | Where-Object Status -eq "running" | Measure-Object
$hash.Add("Number Of Running Services", $running.count)
$os = Get-WmiObject –Class Win32_operatingsystem
$hash.Add("OS", $os.caption)
$time = Get-Date -DisplayHint time
$hash.Add("Time", $time.TimeOfDay)

$hash