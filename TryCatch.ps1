try {
    #Get-Content c:\filedoesnotexist.txt -ErrorAction Stop
    Get-Content C:\Users\sujide01\Documents\Notepads\Junk.txtt -ErrorAction Stop
    Write-Output "File Exists"
}
catch {
    Write-Output "File does not exist"
}