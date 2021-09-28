//%attributes = {}
p_LogDatenAktualisieren ("Anonymisieren";vUmfrage;0;"")

vbOK:=False:C215
QUERY:C277([Variablen:5];[Variablen:5]Umfrage:3=vUmfrage)
DIALOG:C40([Variablen:5];"d_Anonymisieren")
If (vbOK)
	READ WRITE:C146([Variablen:5])
	QUERY:C277([Variablen:5];[Variablen:5]Umfrage:3=vUmfrage)
	LOAD RECORD:C52([Variablen:5])
	[Variablen:5]AnonymDurch:42:=Current user:C182
	[Variablen:5]AnonymAm:41:=Current date:C33
	SAVE RECORD:C53([Variablen:5])
	READ ONLY:C145([Variablen:5])
	PRINT SETTINGS:C106
	If (OK=1)
		Print form:C5([Variablen:5];"d_AnonymDrucken")
	End if 
End if 

p_LogDatenAktualisieren ("Startbildschirm";vUmfrage;0;"")
