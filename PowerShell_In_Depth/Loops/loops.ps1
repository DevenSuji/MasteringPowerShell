# In the below for loop the conditions are in one single line seperated by semi colons ;. 
# This is the preferred method

##### For Loop #####
For ($i = 0; $i –lt 10; $i++) {
    Write-Host $i
}

# In the below for loop the conditions are in different lines seperated by carriage return
For (
    $i = 0
    $i –lt 10
    $i++) {
    Write-Host $i
}
##### Do-While Loop #####

$i = 0
Do {
    $i
    $i++
} While ($i –lt 10)

##### Do-Until Loop #####
$i = 0
Do {
    $i
    $i++
} Until ($i –eq 10)

##### Until Loop #####
$i = 0
While ($i –lt 10) {
    $i
    $i++
}