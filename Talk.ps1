#https://gallery.technet.microsoft.com/Convert-Alphanumeric-8c1d6a79
function Invoke-Speech {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $true,
            ValueFromPipeline = $true)]
        [string[]]$Text,

        [switch]$Asynchronous
    )
    BEGIN {
        Add-Type -AssemblyName System.Speech
        $speech = New-Object -TypeName System.Speech.Synthesis.SpeechSynthesizer
    }
    PROCESS {
        foreach ($phrase in $text) {
            if ($Asynchronous) {
                $speech.SpeakAsync($phrase) | Out-Null

            }
            else {
                $speech.speak($phrase)
            }
        }
    }
    END {}
}