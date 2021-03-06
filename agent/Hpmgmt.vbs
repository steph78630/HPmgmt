'----------------------------------------------------------
' Plugin for OCS Inventory NG 2.x
' Script :		
' Version :		1.00
' Date :		  
' Author :		
'----------------------------------------------------------
' OS checked [X] on	32b	64b	(Professionnal edition)
'   Windows XP		  [ ]
'   Windows Vista	  [ ]	[ ]
'   Windows 7	  	  [ ]	[ ]
'   Windows 8.1		  [ ]	[ ]
'   Windows 10		  [ ]	[ ]
'   Windows 2k8R2 		  [ ]
'   Windows 2k12R2	  	[ ]
'   Windows 2k16	    	[ ]
' ---------------------------------------------------------
' NOTE : No checked on Windows 8
' ---------------------------------------------------------
On Error Resume Next
strComputer = "."
Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\hpq")

Set colItems = objWMIService.ExecQuery("Select * from HP_ManagementProcessor")

For Each objItem in colItems
  strILOName = objItem.Caption
  strIPILO = objItem.IPAddress
  Wscript.Echo _
    "<HPMGMT>" & VbCrLf &_
    "<CAPTION>" & strILOName & "</CAPTION>" & VbCrLf &_
    "<IPILO>" & strIPILO & "</IPILO>" & VbCrLf &_
    "</HPMGMT>"
Next

Set colItems = objWMIService.ExecQuery("Select * from HPSA_ArraySystem")

For Each objItem in colItems
  strSmart = objItem.ElementName
  Wscript.Echo _
    "<HPSMART>" & VbCrLf &_
    "<SMART>" & strSmart & "</SMART>" & VbCrLf &_
    "</HPSMART>"
Next

Set colItems = objWMIService.ExecQuery("Select * from HPSA_StorageVolume")

For Each objItem in colItems
  strRaid = objItem.ElementName
  strRaidSize = Fix((objItem.BlockSize * objItem.NumberOfBlocks) / 1073741824) & " Go"
  Wscript.Echo _
    "<HPRAID>" & VbCrLf &_
    "<RAID>" & strRaid & "</RAID>" & VbCrLf &_
    "<RAIDSIZE>" & strRaidSize & "</RAIDSIZE>" & VbCrLf &_
    "</HPRAID>"
Next

Set colItems = objWMIService.ExecQuery("Select * from HPSA_StorageExtent")

For Each objItem in colItems
  strDisk = objItem.ElementName
  strDiskName = objItem.Name
  strDiskSize = Fix((objItem.BlockSize * objItem.NumberOfBlocks) / 1073741824) & " Go"
  Wscript.Echo _
    "<HPDISK>" & VbCrLf &_
    "<DISK>" & strDisk & "</DISK>" & VbCrLf &_
    "<DISKNAME>" & strDiskName & "</DISKNAME>" & VbCrLf &_
    "<DISKSIZE>" & strDiskSize & "</DISKSIZE>" & VbCrLf &_
    "</HPDISK>"
Next
