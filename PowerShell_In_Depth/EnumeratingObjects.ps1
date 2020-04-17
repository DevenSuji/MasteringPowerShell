Get-ADComputer –filter * | ForEach-Object –Process {
    (Get-ADComputer -Identity $PSItem.SamAccountName).DistinguishedName
}


Get-Process | ForEach-Object {if ($_.Id -eq 2120){$_.Kill()}}