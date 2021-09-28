//%attributes = {}
ALL RECORDS:C47([Variablen:5])
FIRST RECORD:C50([Variablen:5])
While (Not:C34(End selection:C36([Variablen:5])))
	$vt_DatName:="Mac HD Wegner:Users:wegner:Documents:CATI-Projekte:CATI_FBs:"+[Variablen:5]Umfrage:3+"_CATI_FB_OhneSpez_"+String:C10([Variablen:5]EingerichtetAm:40)+".pdf"
	SET PRINT OPTION:C733(Destination option:K47:7;3;$vt_DatName)
	
	QUERY:C277([Bogen:6];[Bogen:6]Umfrage:20=[Variablen:5]Umfrage:3;*)
	QUERY:C277([Bogen:6]; & [Bogen:6]ID:1#"@Spez@")
	ORDER BY:C49([Bogen:6];[Bogen:6]ID:1)
	FORM SET OUTPUT:C54([Bogen:6];"Drucken_komplett")
	C_TEXT:C284(vt_Text)
	C_LONGINT:C283(vi_Seite)
	vi_Seite:=0
	vUmfrDat:=[Variablen:5]Umfrage:3+" (ohne Spezial) /  "+String:C10([Variablen:5]EingerichtetAm:40)
	PRINT SELECTION:C60([Bogen:6];*)
	
	$vt_DatName:="Mac HD Wegner:Users:wegner:Documents:CATI-Projekte:CATI_FBs:"+[Variablen:5]Umfrage:3+"_CATI_FB_MitSpez_"+String:C10([Variablen:5]EingerichtetAm:40)+".pdf"
	SET PRINT OPTION:C733(Destination option:K47:7;3;$vt_DatName)
	
	QUERY:C277([Bogen:6];[Bogen:6]Umfrage:20=[Variablen:5]Umfrage:3;*)
	QUERY:C277([Bogen:6]; & [Bogen:6]ID:1="@Spez@")
	ORDER BY:C49([Bogen:6];[Bogen:6]ID:1)
	FORM SET OUTPUT:C54([Bogen:6];"Drucken_komplett")
	C_TEXT:C284(vt_Text)
	C_LONGINT:C283(vi_Seite)
	vi_Seite:=0
	vUmfrDat:=[Variablen:5]Umfrage:3+" (nur Spezial) /  "+String:C10([Variablen:5]EingerichtetAm:40)
	PRINT SELECTION:C60([Bogen:6];*)
	
	NEXT RECORD:C51([Variablen:5])
End while 
