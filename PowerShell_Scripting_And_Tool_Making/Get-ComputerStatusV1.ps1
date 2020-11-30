function Get-ComputerStatus {
    <#
    .SYNOPSIS
    Get computer status information.
    .DESCRIPTION
    This command retrieves system information from one or more remote computers
    using Get-CimInstance. It will write a summary object to the pipeline for
    each computer. You also have the option to log errors to a text file.
    .PARAMETER ComputerName
    The name of the computer to query. This parameter has aliases of
    CN, Machine and Name.
    .PARAMETER Errorlog
    The path to the error text file. This is not implemented yet.
    .PARAMETER ErrorAppend
    Append errors to the error file. This is not implemented yet.
    .EXAMPLE
    PS C:\> Get-Computerstatus -ComputerName Server1 

    Computername : Server1
    TotalMem : 33080040
    FreeMem : 27384236
    Processes : 218
    PctFreeMem : 82.7817499616083
    Uptime : 11.06:23:52.7176115
    CPULoad : 2
    PctFreeC : 54.8730920184876

    Get the status of a single computer

    .EXAMPLE
    PS C:\> Get-Content c:\work\computers.txt | Get-ComputerStatus | Export-CliXML c:\work\data.xml

    Pipe each computer name from the computers.txt text file to this
    command. Results are immediately exported to an XML file using
    Export-CliXML.
    #>
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline = $True, Mandatory = $True)]
        [ValidateNotNullorEmpty()]
        [ValidatePattern("^\w+$")]
        [Alias("CN", "Machine", "Name")]
        [string[]]$ComputerName,
        [string]$ErrorLogFilePath,
        [switch]$ErrorAppend
    )
    
    begin {
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN ] Starting $($myinvocation.MyCommand)"
    }
    process {
        Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS ] I'm in the Process Block"
        foreach ($computer in $Computername) {
            Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS ] I'm in the Foreach Block"
            Write-Verbose "Querying $($Computer.toUpper())"
            $Params = @{
                Classname    = "Win32_OperatingSystem"
                ComputerName = $Computer
                ErrorAction = "Stop"
            }
            $OS = Get-CimInstance @Params

            $Params.ClassName = "Win32_Processor"
            $CPU = Get-CimInstance @Params

            $Params.ClassName = "Win32_logicaldisk"
            $VOL = Get-CimInstance @Params -filter "DeviceID='c:'"

            Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS ] Compiling the PS Custom Object"

            [PSCustomObject]@{
                ComputerName      = $OS.CSName
                TotalMemory       = $OS.TotalVisibleMemorySize
                FreeMemory        = $OS.FreePhysicalMemory
                Processes         = $OS.NumberOfProcesses
                PercentFreeMemory = ($OS.FreePhysicalMemory / $OS.TotalVisibleMemorySize) * 100
                Uptime            = (Get-Date) - $OS.LastBootUpTime
                CPULoad           = $CPU.LoadPercentage
                PCTFreeC          = ($VOL.FreeSpace / $VOL.Size) * 100
            }
            Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS ] Compiling the PS Custom Object Completed"

        } #Foreach
    } #Process Block
    end {
        Write-Verbose "[$((Get-Date).TimeOfDay) END ] Ending $($myinvocation.mycommand)"
    }
}