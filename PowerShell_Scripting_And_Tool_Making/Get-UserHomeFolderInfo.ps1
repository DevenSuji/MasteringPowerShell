function Get-UserHomeFolderInfo {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [String]$HomeRootPath
    )
    
    begin {}
    
    process {
        Write-Verbose "Enumerating $HomeRootPath"
        $params = @{
            Path      = $HomeRootPath
            Directory = $True
        }
        foreach ($folder in (Get-ChildItem @params)) {
            Write-Verbose "Checking $($folder.name)"
            $params = @{
                Identity    = $folder.Name
                ErrorAction = 'SilentlyContinue'
            }
            $user = Get-ADUser @params
            if ($user) {
                Write-Verbose " + User Exists"
                $result = Get-FolderSize -Path $folder.FullName
                [PSCustomObject]@{
                    User   = $folder.Name
                    Path   = $folder.FullName
                    Files  = $result.files
                    Bytes  = $result.bytes
                    Status = 'OK'
                }
            }
            else {
                Write-Verbose " - User does not exist"
                [PSCustomObject]@{
                    User   = $folder.name
                    Path   = $folder.fullname
                    Files  = 0
                    Bytes  = 0
                    Status = 'Orphan'
                }
            }
        }
    }
    
    end {
        
    }
}