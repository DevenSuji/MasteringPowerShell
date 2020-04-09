[CmdletBinding()]
param (
    [Parameter(Mandatory = $True)]
    [string]$ComputerName,
        
    [Parameter(Mandatory = $True)]
    [string]$User
)

try {
    $ErrorActionPreference = 'Stop'
    $UserID = 'enterprise\NeatGroupAdmin'
        
    $Password = (Get-Content 'C:\TEMP\NeatGroup.txt' | ConvertTo-SecureString)
        
    $Creds = (New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList @($UserID, $Password))

    $UserValidation = Get-ADUser -Identity $User -ErrorAction Stop

    $MachineValidation = Get-ADComputer -Identity $ComputerName -Properties * -ErrorAction Stop

    $Machine_Membership_Check = Get-ADGroupMember -Identity 'neat_apple' -ErrorAction Stop

    $User_Membership_Check = Get-ADGroupMember -Identity 'neat_banana' -ErrorAction Stop
    try {
        $ErrorActionPreference = 'Stop'
        if ((($Machine_Membership_Check.Name -contains $ComputerName)`
                    -and ($User_Membership_Check.SamAccountName -notcontains $User))`
                -and (($MachineValidation.OperatingSystem -match "Windows 10")`
                    -or ($MachineValidation.OperatingSystem -match "Windows 8")`
                    -or ($MachineValidation.OperatingSystem -match "Windows 7"))) {
            Add-ADGroupMember -Identity 'neat_banana' -Members $UserValidation.DistinguishedName -Credential $Creds -ErrorAction Stop
            Write-Output "The user has been added to the required group"
        }
        elseif ((($Machine_Membership_Check.Name -notcontains $ComputerName)`
                    -and ($User_Membership_Check.SamAccountName -contains $User))`
                -and (($MachineValidation.OperatingSystem -match "Windows 10")`
                    -or ($MachineValidation.OperatingSystem -match "Windows 8")`
                    -or ($MachineValidation.OperatingSystem -match "Windows 7"))) {
            Add-ADGroupMember -Identity 'neat_apple' -Members $MachineValidation.DistinguishedName -Credential $Creds -ErrorAction Stop
            Write-Output "The machine has been added to the required group"
        }
        elseif ((($Machine_Membership_Check.Name -notcontains $ComputerName)`
                    -and ($User_Membership_Check.SamAccountName -notcontains $User))`
                -and (($MachineValidation.OperatingSystem -match "Windows 10")`
                    -or ($MachineValidation.OperatingSystem -match "Windows 8")`
                    -or ($MachineValidation.OperatingSystem -match "Windows 7"))) {
            Add-ADGroupMember -Identity 'neat_apple' -Members $MachineValidation.DistinguishedName -Credential $Creds -ErrorAction Stop
            Add-ADGroupMember -Identity 'neat_banana' -Members $UserValidation.DistinguishedName -Credential $Creds -ErrorAction Stop
            Write-Output "Machine and User both are added to the respective groups"
        } 
        elseif (($Machine_Membership_Check.Name -contains $ComputerName) -and ($User_Membership_Check.SamAccountName -contains $User)) {
            Write-Output "Duplicate Request. Please contact the user"
        } 
    }
    catch {
        Write-Output "There was a problem adding the user or machine to the group. Please check manually" 
    }
}
catch {
    Write-Output "Either the Machine or the User ID is invalid"
}