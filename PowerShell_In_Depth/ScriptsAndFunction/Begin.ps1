function Begin {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $True)]
        [int]
        $PercentFreeSpace
    )
    BEGIN { 
        # Empty Block
    }
    PROCESS {
        If ((100 * ($_.FreeSpace / $_.Size) –lt $PercentFreeSpace)) {
            Write-Output $_
        }
    }
    END { 
        # Empty Block
    }
}