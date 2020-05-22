Function Get-Stuff {
    [CmdletBinding()]
    Param(
        [Parameter(ParameterSetName = 'Fred')][string]$one,
        [Parameter(ParameterSetName = 'Fred')][string]$two,
        [Parameter(ParameterSetName = 'Wilma')][string]$buckle,
        [Parameter(ParameterSetName = 'Wilma')][string]$my,
        [Parameter(ParameterSetName = 'Wilma')][string]$shoe,
        [Parameter(ParameterSetName = 'Dino')][string]$bag,
        [Parameter(ParameterSetName = 'Dino')][string]$sack,
        [Parameter()][string]$peach,
        [Parameter()][string]$apple
    )
}

Get-Stuff -one apple -two mango -peach bleach -apple good -Verbose
