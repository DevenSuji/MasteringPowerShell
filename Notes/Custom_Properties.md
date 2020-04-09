# Making Custom Properties
Source: PowerShell In Depth page no. 82

Get-Process | Select –Property Name,ID,@{name="TotalMemory";expression={$_.PM + $_.VM}}

Name                     Id   TotalMemory
----                     --   -----------
AcroRd32              10380     617844736
AcroRd32              13336     238120960
ApMsgFwd              12456     100958208
ApntEx                12856      97796096
Apoint                 8244     155594752

Look at how PM and VM has been added together and a new property has been created out of it.

Get-Process | Select –Property Name,ID,@{name="PageMemory";expression={$_.PM}}

Name                     Id PageMemory
----                     -- ----------
AcroRd32              10380  158748672
AcroRd32              13336   13807616
ApMsgFwd              12456    2314240
ApntEx                12856    2236416
Apoint                 8244    5414912

>>> Below examples shows the math behind how to convert the values to MB and GB

Get-Process | Select -Property Name,ID,@{Name="TotalMemory(InMB)";Expression={($_.PM + $_.VM) /1MB -as [int]}}

Name                     Id TotalMemory(InMB)
----                     -- -----------------
AcroRd32              10380               589
AcroRd32              13336               227
ApMsgFwd              12456                96
ApntEx                12856                93
Apoint                 8244               148

Get-Process | Select -Property Name,ID,@{Name="TotalMemory(InGB)";Expression={($_.PM + $_.VM) /1GB -as [int]}}

Name                     Id TotalMemory(InGB)
----                     -- -----------------
AcroRd32              10380                 1
AcroRd32              13336                 0
ApMsgFwd              12456                 0
ApntEx                12856                 0
Apoint                 8244                 0
