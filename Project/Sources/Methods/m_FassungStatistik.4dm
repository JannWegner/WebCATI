//%attributes = {}
C_LONGINT:C283($viAnzahl)

p_LogDatenAktualisieren ("Fassungs-Statistik";vUmfrage;0;"")
If ([Variablen:5]Fasssung:24#"")
	C_TEXT:C284(vtStatistikMatrix)
	C_LONGINT:C283($viAnzahl)
	
	p_FassungInit 
	SORT ARRAY:C229(atFassung)
	
	QUERY:C277([TelefonNummer:4];[TelefonNummer:4]Umfrage:30=vUmfrage;*)
	QUERY:C277([TelefonNummer:4]; & [TelefonNummer:4]Status:5="Komplett")
	CREATE SET:C116([TelefonNummer:4];"$mFertige")
	
	vtStatistikMatrix:="Fassungen auszählen"+Char:C90(13)+"Standard ist: A=8, B=9, '=6, ''=7"+Char:C90(13)+Char:C90(13)
	SET QUERY DESTINATION:C396(Into variable:K19:4;$viAnzahl)
	
	For ($lauf;1;Size of array:C274(atFassung))
		USE SET:C118("$mFertige")
		QUERY SELECTION:C341([TelefonNummer:4];[TelefonNummer:4]Fassung:39=atFassung{$lauf})
		vtStatistikMatrix:=vtStatistikMatrix+Char:C90(13)+"Fassung  "+p_TextFormat (atFassung{$lauf};"l";8)+p_TextFormat (String:C10($viAnzahl);"r";4)
	End for 
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	DIALOG:C40([Variablen:5];"d_StatistikMatrix")
	
Else 
	ALERT:C41("Fassung nicht definiert für diese Umfrage!")
End if 