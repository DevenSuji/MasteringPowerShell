# ExpandProperty

Usually when objects are fetched, they belong to different object type. If you want to consume that object as a string use -ExpandProperty. Look at the below examples

PS C:\Windows\System32> Get-Service -Name AdobeARMservice | Select-Object DisplayName

DisplayName
-----------
Adobe Acrobat Update Service

PS C:\Windows\System32> Get-Service -Name AdobeARMservice | Select-Object DisplayName  | gm


   TypeName: Selected.System.ServiceProcess.ServiceController

Name        MemberType   Definition
----        ----------   ----------
Equals      Method       bool Equals(System.Object obj)
GetHashCode Method       int GetHashCode()
GetType     Method       type GetType()
ToString    Method       string ToString()
DisplayName NoteProperty string DisplayName=Adobe Acrobat Update Service

But when we use the same command with -ExpandProperty, the output object is of the type string.

PS C:\Windows\System32> Get-Service -Name AdobeARMservice | Select-Object -ExpandProperty DisplayName
Adobe Acrobat Update Service

PS C:\Windows\System32> Get-Service -Name AdobeARMservice | Select-Object -ExpandProperty DisplayName | gm


   TypeName: System.String

# Shortcut and Easy

(Get-Service m*).Displayname

This way of dotted notation can be used instead of -ExpandProperty and it returns System.String object.

PS C:\Windows\System32> (Get-Service m*).Displayname | Select-Object -First 3
Downloaded Maps Manager
BitLocker Management Client Service
MessagingService_66a923

PS C:\Windows\System32> (Get-Service m*).Displayname | Select-Object -First 3 | gm


   TypeName: System.String
