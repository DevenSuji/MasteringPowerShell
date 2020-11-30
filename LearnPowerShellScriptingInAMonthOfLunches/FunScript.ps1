$x = Get-Random -Minimum 1 -Maximum 4
$x
switch ($x) {
    1 { Write-Host "It's fake" }
    2 { Write-Host "Chui Mui Chui Mui" }
    3 { Write-Host "You are so mean" }
    Default { Write-Host "Ah haa" }
}


$x = "d1234"

switch -wildcard ($x) {
    "*1*" { "Contains 1" }
    "*5*" { "Contains 5" }
    "d*" { "Starts with 'd'" }
    default { "No matches" }
}