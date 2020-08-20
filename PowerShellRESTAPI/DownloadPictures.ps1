$Uri = "https://pbs.twimg.com/media/D1C-REyXQAABCU7?format=png&name=900x900"

$tempf = [system.io.path]::GetTempPath()

$Outfile = "$tempf/cds.jpg"

## Downloading the file and saving it to the local disk
Invoke-WebRequest -Uri $Uri -OutFile $Outfile

## Opening the PIC
Start-Process $Outfile