//%attributes = {}
  //Importiert Adressen, die im Standardformat der Datei "Standard-Adress-Import.txt" aufbereitet sind
p_LogDatenAktualisieren ("StandardImp. neueAdressen";vUmfrage;0;"")

FldDelimit:=9
RecDelimit:=13

CONFIRM:C162("Adressen im Standardformat importieren?")
If (OK=1)
	
	FORM SET INPUT:C55([TelefonNummer:4];"Import_Standard")
	USE CHARACTER SET:C205("MacRoman";1)
	IMPORT TEXT:C168([TelefonNummer:4];"")
	USE CHARACTER SET:C205(*;1)
	ALERT:C41("Alles erledigt!")
End if 

p_LogDatenAktualisieren ("Startbildschirm";vUmfrage;0;"")
