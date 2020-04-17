("don", "jeff", "richard").foreach( { $_.toupper() })


Get-Process | Select-Object name,id,vm,pm | ConvertTo-Csv -NoTypeInformation