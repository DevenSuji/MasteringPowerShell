function Get-Folder {
    [CmdletBinding()]
    Param(
        [Parameter(
            Mandatory,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName
        )]
        [string[]]$Path
    )

    ForEach ($Folder in $Path) {
        Write-Output "Checking $Folder"
    }
}

Get-Folder