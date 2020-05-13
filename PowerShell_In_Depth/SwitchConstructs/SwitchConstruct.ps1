<# Here is how you convert an IF ELSE statement to SWITCH #>

If ($printer.status –eq 0) {
    $status = "OK"
}
elseif ($printer.status –eq 1) {
    $status = "Out of Paper"
}
elseif ($printer.status –eq 2) {
    $status = "Out of Ink"
}
elseif ($printer.status –eq 3) {
    $status = "Input tray jammed"
}
elseif ($printer.status –eq 4) {
    $status = "Output tray jammed"
}
elseif ($printer.status –eq 5) {
    $status = "Cover open"
}
elseif ($printer.status –eq 6) {
    $status = "Printer Offline"
}
elseif ($printer.status –eq 7) {
    $status = "Printer on Fire!!!"
}
else {
    $status = "Unknown"
}

$status

#######################################################################

$printer.status = 7

Switch ($printer.status) {
    0 { $status = "OK" }
    1 { $status = "Out of paper" }
    2 { $status = "Out of Ink" }
    3 { $status = "Input tray jammed" }
    4 { $status = "Output tray jammed" }
    5 { $status = "Cover open" }
    6 { $status = "Printer Offline" }
    7 { $status = "Printer on Fire!!" }
    Default { $status = "Unknown" }
}

#########################################################################

# MULTIPLE COMPARISION WITH A SWITCH

$servername = 'dc01lax'
$message = ""
Switch –wildcard ($servername) {
    "DC*" {
        $message += "Domain Controller"
    }
    "FS*" {
        $message += "File Server"
    }
    "*LAS" {
        $message += " Las Vegas"
    }
    "*LAX" {
        $message += " Los Angeles"
    }
}

Write-Output $message

#########################################################################

<#There might be times when multiple matches are possible but you don’t want them
all to execute. In that case, just add the Break keyword to the appropriate spot. Once
you do so, the Switch construct will exit entirely. For example, suppose you don’t care
about a domain controller’s location but you do care about a file server. You might
make the following modification: #>

#$servername = 'fs01las'
$servername = 'dc01las'
$message = ""
Switch –wildcard ($servername) {
    "DC*" {
        $message += "Domain Controller"
        break
    }
    "FS*" {
        $message += "File Server"
    }
    "*LAS" {
        $message += " Las Vegas"
    }
    "*LAX" {
        $message += " Los Angeles"
    }
}

$message

#########################################################################


foreach ($proc in (Get-Process)) {
    switch ($proc.Handles) {
        { $_ -gt 1500 } {
            Write-Host "$($proc.Name) has very high handle count"
            break 
        }
        { $_ -gt 1200 } {
            Write-Host "$($proc.Name) has high handle count"
            break 
        }
        { $_ -gt 800 } {
            Write-Host "$($proc.Name) has medium-high handle count"
            break 
        }
        { $_ -gt 500 } {
            Write-Host "$($proc.Name) has medium handle count"
            break 
        }
        { $_ -gt 250 } {
            Write-Host "$($proc.Name) has low handle count"
            break 
        }
        { $_ -lt 100 } {
            Write-Host "$($proc.Name) has very low handle count"
            break 
        }
    }
}

#########################################################################
