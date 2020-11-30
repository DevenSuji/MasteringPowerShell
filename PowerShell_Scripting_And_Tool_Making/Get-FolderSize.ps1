function Get-FolderSize {
    [CmdletBinding()]
    Param (
        [Parameter(
            Mandatory,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName
        )]
        [String[]]$Path
    )
    
    begin {
        $Paths = Get-ChildItem -Path $Path -Directory *
    }
    
    process {
        ForEach ($Folder in $Paths) {
            Write-Verbose "Checking $Folder"
            if (Test-Path -Path $Folder) {
                Write-Verbose " + Path exists"

                #turn the folder into a true FileSystem path
                $cPath = Convert-Path $Folder

                $params = @{
                    Path    = $cPath
                    Recurse = $true
                    File    = $true
                }
                $measure = Get-ChildItem @params | Measure-Object -Property Length -Sum
                [PSCustomObject]@{
                    Path  = $cPath
                    Files = $measure.Count
                    Bytes = $measure.Sum
                }
            }
            else {
                Write-Verbose " - Path does not exist"
                [PSCustomObject]@{
                    Path  = $Folder
                    Files = 0
                    Bytes = 0
                }
            }
        }
    }
    
    end {
        
    }
}


Get-FolderSize