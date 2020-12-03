$id = 'nagara09'
$ComputerName = 'daywrk64w10126'

$session = New-PSSession -ComputerName $ComputerName

Invoke-Command -Session $session -ScriptBlock { [System.Security.Principal.WindowsPrincipal]::new($Using:id).IsInRole('administrators') }