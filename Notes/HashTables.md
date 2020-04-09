# Hash Tables and PSItem

Get-Process | Select -Property Name, ID, @{Name="VirtMem";Expression={$psitem.vm}}, @{Name="PhysMem";Expression={$psitem.pm}}

Name        Id   VirtMem   PhysMem
----        --   -------   -------
AcroRd32 10380 483090432 184324096
AcroRd32 13336 224313344  13893632
ApMsgFwd 12456  98643968   2314240