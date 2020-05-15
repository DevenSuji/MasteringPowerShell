workflow Test-Workflow {
    InlineScript {
        $obj = New-Object -TypeName PSObject
        $obj | Add-Member -MemberType NoteProperty `
            -Name ExampleProperty `
            -Value 'Hello!'
        $obj | Get-Member
    }
}
Test-Workflow
####################################################################################################################################################################
Workflow Test {
    Param([string]$path)
    Get-Childitem -Path path -Recurse -File |
    Measure-Object -Property length -sum -Average |
    Add-Member -MemberType NoteProperty -Name Path -Value Path -PassThru
}
####################################################################################################################################################################
Workflow Test-Workflow {
    "This will run first"
    parallel {
        "Command 1"
        "Command 2"
        sequence {
            "Command A"
            "Command B"
        }
    }
}
####################################################################################################################################################################

Workflow Test-Workflow {
    Param ([string[]]$computername)
    Foreach –parallel ($computer in $computerName) {
        Do-Something –PScomputerName $computer
    }
}
####################################################################################################################################################################

Workflow Show-ForEachParallel {
    foreach -parallel ($i in (1..20)) {
        Write-Verbose -message "$((Get-Date).TimeOfDay) $i * 2 = $($i*2)"
        Start-Sleep -seconds (Get-Random -Minimum 1 -Maximum 5)
    }
}
Show-ForEachParallel -Verbose
####################################################################################################################################################################
Workflow Demo-ForEachThrottle {
    foreach -parallel -throttlelimit 4 ($i in (1..20)) {
        write-verbose -message "$((Get-Date).TimeOfDay) $i * 2 = $($i*2)"
        Start-Sleep -seconds (Get-Random -Minimum 1 -Maximum 5)
    }
}

Demo-ForEachThrottle -Verbose
####################################################################################################################################################################