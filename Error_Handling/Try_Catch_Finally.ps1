try {
    $testvariable = 'This is a test.'
    Write-Host 'Statement before the error.'
    [System.IO.File]::ReadAllText('C:\does\not\exist.txt')
    Write-Host 'Statement after the error'
}
catch [System.IO.IOException] {
    Write-Host 'An IO Exception was caught.'
    Write-Host "Exception type: $($_.Exception.GetType().FullName)"
}
catch {
    Write-Host 'Some other type of error was caught'
}
finally {
    $testvariable = 'The finally block was executed'
}

Write-Host "`$testVariable = '$testvariable'."


try {
    Get-ADUser -Identity sujide00 -ErrorAction Stop
}
catch {
    # I can do both mentioned below
    Write-Output $_.Exception.Message
    Write-Output $Error[0].Exception.Message
}