Function Get-NBTName {
    $data = NBTSTAT /n | Select-String "<" | Where-Object { $_ -notmatch "__MSBROWSE__" }


    $lines = $data | ForEach-Object { $_.Line.Trim() }

    $lines | ForEach-Object {
        $temp = $_ -split "\s+"
        $phash = @{
            Name    = $temp[0]
            NbtCode = $temp[1]
            Type    = $temp[2]
            Status  = $temp[3]
        }

        $Stat = New-Object -TypeName PSObject -Property $phash
        Write-Output $Stat
    }
}

Get-NBTName | Sort-Object type | Format-Table –Autosize