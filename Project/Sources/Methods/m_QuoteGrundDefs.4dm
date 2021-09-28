//%attributes = {}
p_LogDatenAktualisieren ("Quoten";vUmfrage;0;"")

READ WRITE:C146([Quoten:7])
QUERY:C277([Quoten:7];[Quoten:7]Umfrage:1=vUmfrage)
If (Records in selection:C76([Quoten:7])=0)
	CREATE RECORD:C68([Quoten:7])
	[Quoten:7]Umfrage:1:=vUmfrage
	SAVE RECORD:C53([Quoten:7])
End if 
FORM SET INPUT:C55([Quoten:7];"Eingabe")
MODIFY RECORD:C57([Quoten:7])

If ([Quoten:7]FreigabeString:11="")
	[Quoten:7]FreigabeString:11:="0"*([Quoten:7]AnzItemDim1:2*[Quoten:7]AnzItemDim2:3*[Quoten:7]AnzItemDim3:4*[Quoten:7]AnzItemDim4:5)
	SAVE RECORD:C53([Quoten:7])
End if 
If ([Quoten:7]SollString:10="")
	[Quoten:7]SollString:10:="0,"*([Quoten:7]AnzItemDim1:2*[Quoten:7]AnzItemDim2:3*[Quoten:7]AnzItemDim3:4*[Quoten:7]AnzItemDim4:5)
	SAVE RECORD:C53([Quoten:7])
End if 

READ ONLY:C145([Quoten:7])
UNLOAD RECORD:C212([Quoten:7])
QUERY:C277([Quoten:7];[Quoten:7]Umfrage:1=vUmfrage)

p_LogDatenAktualisieren ("Startbildschirm";vUmfrage;0;"")
