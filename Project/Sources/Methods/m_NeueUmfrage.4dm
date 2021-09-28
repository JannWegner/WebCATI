//%attributes = {}
  //Legt eine neue Umfrage an
p_LogDatenAktualisieren ("Neue Umfrage";vUmfrage;0;"")

$vsUmfrage:=Request:C163("Umfrage-Name (Nr-Text)")
If (OK=1)
	START TRANSACTION:C239
	$vbAllesOK:=True:C214
	CREATE RECORD:C68([Variablen:5])
	[Variablen:5]Umfrage:3:=$vsUmfrage
	[Variablen:5]UmfrageAnzeigeName:38:=$vsUmfrage
	[Variablen:5]ListenFelder:22:="01010101"
	[Variablen:5]EingerichtetAm:40:=Current date:C33
	SAVE RECORD:C53([Variablen:5])
	$vbAllesOK:=($vbAllesOK & (OK=1))
	
	CREATE RECORD:C68([Quoten:7])
	[Quoten:7]Umfrage:1:=$vsUmfrage
	[Quoten:7]AnzItemDim1:2:=1
	[Quoten:7]AnzItemDim2:3:=1
	[Quoten:7]AnzItemDim3:4:=1
	[Quoten:7]AnzItemDim4:5:=1
	[Quoten:7]TextDim1:6:=" |"
	[Quoten:7]TextDim2:7:=" |"
	[Quoten:7]TextDim3:8:=" |"
	[Quoten:7]TextDim4:9:=" |"
	[Quoten:7]SpaltenBreite:13:=13
	SAVE RECORD:C53([Quoten:7])
	$vbAllesOK:=($vbAllesOK & (OK=1))
	
	If ($vbAllesOK)
		VALIDATE TRANSACTION:C240
		p_UmfrageWählen 
	Else 
		CANCEL TRANSACTION:C241
		ALERT:C41("m_NeueUmfrage:"+Char:C90(13)+"Da hat was nicht geklappt!")
	End if 
End if 

p_LogDatenAktualisieren ("Startbildschirm";vUmfrage;0;"")
