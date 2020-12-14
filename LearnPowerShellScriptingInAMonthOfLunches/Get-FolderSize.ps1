function Get-FolderSize {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            ValueFromPipelineByPropertyName = $True)]
        [String[]]$Path
    )
    
    begin {
        # Leaving the Begin Block Empty Deliberately
    }
    
    process {
        foreach ($Folder in $Path) {
            Write-Verbose "Checking $folder"
            if (Test-Path -Path $folder) {
                Write-Verbose " + Path exists"
                $params = @{'Path' = $Folder
                    'Recurse'      = $True
                    'File'         = $True
                }
                $Measure = Get-ChildItem @params | Measure-Object -Property Length -Sum
                [PSCustomObject]@{
                    'Path'  = $Folder
                    'Files' = $Measure.Count
                    'Bytes' = $Measure.Sum
                }
            }
            else {
                Write-Verbose " - Path does not exist"
                [PSCustomObject]@{
                    'Path'  = $Folder
                    'Files' = 0
                    'Bytes' = 0
                }
            } #Else
        } #Foreach
    

    }
    end {
    
    }
}