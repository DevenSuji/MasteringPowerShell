function Get-MachineInformation {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline = $true,
            Mandatory = $true)]
        [Alias('CN', 'MachineName', 'Name')]
        [string[]]$ComputerName,

        [string]$LogFailuresToPath,

        [ValidateSet('wsman', 'dcom')]
        [string]$Protocol = "wsman",

        [switch]$ProtocolFallBack
    )
    BEGIN {
        Write-Verbose "[$((get-date).TimeOfDay.ToString()) BEGIN  ]$($MyInvocation.Mycommand)"
        Write-Verbose "[$((get-date).TimeOfDay.ToString()) BEGIN  ]User = $($env:userdomain)\$($env:USERNAME)"
        $id = [System.Security.Principal.WindowsIdentity]::GetCurrent()
        $IsAdmin = [System.Security.Principal.WindowsPrincipal]::new($id).IsInRole( 'administrators')
        Write-Verbose "[$((get-date).TimeOfDay.ToString()) BEGIN  ]Is Admin = $IsAdmin"
        Write-Verbose "[$((get-date).TimeOfDay.ToString()) BEGIN  ]Computername = $env:COMPUTERNAME"
        Write-Verbose "[$((get-date).TimeOfDay.ToString()) BEGIN  ]OS = $((Get-CimInstance Win32_Operatingsystem).Caption)"
        Write-Verbose "[$((get-date).TimeOfDay.ToString()) BEGIN  ]Host = $($host.Name)"
        Write-Verbose "[$((get-date).TimeOfDay.ToString()) BEGIN  ]PSVersion = $($PSVersionTable.PSVersion)"
        Write-Verbose "[$((get-date).TimeOfDay.ToString()) BEGIN  ]Runtime = $(Get-Date)"
    }

    PROCESS {
        foreach ($Computer in $ComputerName) {
            # Establish session protocol        
            if ($protocol -eq 'Dcom') {            
                $option = New-CimSessionOption -Protocol Dcom        
            } 
            else {            
                $option = New-CimSessionOption -Protocol Wsman        
            }
            
            Write-Verbose "[$((get-date).TimeOfDay.ToString()) PROCESS  ]Connecting to $Computer over $protocol"  

            # Connect session        
            $session = New-CimSession -ComputerName $computer -SessionOption $option -ErrorAction Stop      
        
            # Query data        
            $os_params = @{'ClassName' = 'Win32_OperatingSystem'                       
                'CimSession'           = $session
            }        
            $os = Get-CimInstance @os_params

            $cs_params = @{'ClassName' = 'Win32_ComputerSystem'                       
                'CimSession'           = $session
            }        
            $cs = Get-CimInstance @cs_params        
        
            $sysdrive = $os.SystemDrive        
            $drive_params = @{'ClassName' = 'Win32_LogicalDisk'                          
                'Filter'                  = "DeviceId='$sysdrive'"                          
                'CimSession'              = $session
            }        
            $drive = Get-CimInstance @drive_params        
        
            $proc_params = @{'ClassName' = 'Win32_Processor'                         
                'CimSession'             = $session
            }        
        
            $proc = Get-CimInstance @proc_params | Select-Object -first 1        
        
            # Close session        
            Write-Verbose "[$((get-date).TimeOfDay.ToString()) PROCESS  ]Closing session to $computer"
            $session | Remove-CimSession        
        
            # Output data        
            Write-Verbose "[$((get-date).TimeOfDay.ToString()) PROCESS  ]Compiling the output for $computer"
            $obj = [pscustomobject]@{'ComputerName' = $computer                   
                'OSVersion'                         = $os.version                   
                'SPVersion'                         = $os.servicepackmajorversion                   
                'OSBuild'                           = $os.buildnumber                   
                'Manufacturer'                      = $cs.manufacturer                   
                'Model'                             = $cs.model                   
                'Procs'                             = $cs.numberofprocessors                   
                'Cores'                             = $cs.numberoflogicalprocessors                   
                'RAM'                               = ($cs.totalphysicalmemory / 1GB)                   
                'Arch'                              = $proc.addresswidth                   
                'SysDriveFreeSpace'                 = $drive.freespace
            }        

            Write-Output $obj
        } #foreach
    } #function
    END {
        Write-Verbose "[$((get-date).TimeOfDay.ToString()) END    ] Ending: $($MyInvocation.Mycommand)"
    }
}



