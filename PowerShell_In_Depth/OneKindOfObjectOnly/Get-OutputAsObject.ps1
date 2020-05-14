$ComputerName = $env:COMPUTERNAME

$os = Get-WmiObject –Class Win32_OperatingSystem -ComputerName $ComputerName
$cs = Get-WmiObject –Class Win32_ComputerSystem -ComputerName $ComputerName
$bios = Get-WmiObject –Class Win32_BIOS -ComputerName $ComputerName
$proc = Get-WmiObject –Class Win32_Processor -ComputerName $ComputerName | Select-Object –First 1

$props = [ordered]@{OSVersion = $os.version
    OpearatingSystem          = $os.Caption
    Model                     = $cs.model
    Manufacturer              = $cs.manufacturer
    BIOSSerial                = $bios.serialnumber
    ComputerName              = $os.CSName
    OSArchitecture            = $os.osarchitecture
    ProcArchitecture          = $proc.addresswidth
}
$obj = New-Object –TypeName PSObject –Property $props
Write-Output $obj


################################# TECHNIQUE #2 #################################
# THIS TECHNIQUE PRESERVES THE ORDER OF THE INSERTIONS

$os = Get-WmiObject –Class Win32_OperatingSystem -ComputerName $ComputerName
$cs = Get-WmiObject –Class Win32_ComputerSystem -ComputerName $ComputerName
$bios = Get-WmiObject –Class Win32_BIOS -ComputerName $ComputerName
$proc = Get-WmiObject –Class Win32_Processor -ComputerName $ComputerName | Select-Object –First 1
$obj = [PSCustomObject]@{OSVersion = $os.version
    OpearatingSystem               = $os.Caption
    Model                          = $cs.model
    Manufacturer                   = $cs.manufacturer
    BIOSSerial                     = $bios.serialnumber
    ComputerName                   = $os.CSName
    OSArchitecture                 = $os.osarchitecture
    ProcArchitecture               = $proc.addresswidth
} 
Write-Output $obj

################################# TECHNIQUE #3 Using .Net Class #################################

$source = @"
public class MyCustomObject
{
public string ComputerName {get; set;}
public string OpearatingSystem {get; set;}
public string Model {get; set;}
public string Manufacturer {get; set;}
public string BIOSSerial {get; set;}
public string OSArchitecture {get; set;}
public string OSVersion {get; set;}
public string ProcArchitecture {get; set;}
}
"@
Add-Type -TypeDefinition $source -Language CSharpversion3
$os = Get-WmiObject –Class Win32_OperatingSystem -ComputerName $ComputerName
$cs = Get-WmiObject –Class Win32_ComputerSystem -ComputerName $ComputerName
$bios = Get-WmiObject –Class Win32_BIOS -ComputerName $ComputerName
$proc = Get-WmiObject –Class Win32_Processor -ComputerName $ComputerName | Select-Object –First 1
$props = @{OSVersion = $os.version
    OpearatingSystem = $os.Caption
    Model            = $cs.model
    Manufacturer     = $cs.manufacturer
    BIOSSerial       = $bios.serialnumber
    ComputerName     = $os.CSName
    OSArchitecture   = $os.osarchitecture
    ProcArchitecture = $proc.addresswidth
}
$obj = New-Object –TypeName MyCustomObject –Property $props
Write-Output $obj