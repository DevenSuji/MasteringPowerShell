$Computer = 'tpawinawxt002'
(Get-Service -Name NetBackup* -ComputerName $Computer).Where{ $PSItem.Status -eq 'Running' }

##############################################################################################

$p = (Get-Process).Where({$_.ws -gt 100mb},"split")
$p[0].count
$p[1].count
##############################################################################################
(Get-Process -Name Chrome).Where({$_.ws -gt 100mb},"First",10)
##############################################################################################

# The below mentioned command can be written using the where method. Basically both the commands perform the same job,
# but when it comes to efficiency where method has an upper hand.

Get-Process | Sort-Object Handles | Where-Object Handles -gt 1000 #Does not use the Where method

(Get-Process | Sort-Object Handles).Where({$_.Handles -gt 1000}) # Uses where method and gets the data that matches the condition

(Get-Process | Sort-Object Handles).Where({$_.Handles -gt 1000}, "Until") # Uses where method but gets the data that does not match the condition.

(Get-Process | Sort-Object Handles).Where({$_.Handles -gt 1000}, "Until", 3) # Uses where method but gets the first 3 sets of object that does not match the condition.

# The SkipUntil parameter is the opposite of Until. It skips all processes that don’t
# match the filter. These options yield the same result:
(Get-Process | Sort-Object Handles).Where({$_.Handles -gt 1000}, "First")
(Get-Process | Sort-Object Handles).Where({$_.Handles -gt 1000}, "First", 1)
(Get-Process | Sort-Object Handles).Where({$_.Handles -gt 1000}, "SkipUntil", 1)

##############################################################################################