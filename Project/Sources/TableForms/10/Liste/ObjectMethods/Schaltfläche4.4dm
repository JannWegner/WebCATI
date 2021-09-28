  //Tabelle Neu nummerieren
  //20151123

C_LONGINT:C283($vi_TabNr;$vi_Lauf)

$vi_TabNr:=Num:C11(Request:C163("Tabellennummer (1-"+String:C10(Get last table number:C254)+")"))
If ((OK=0) | ($vi_TabNr<1) | ($vi_TabNr>(Get last table number:C254)))
	ALERT:C41("Ungültige Tabellennummer")
Else 
	QUERY:C277([Mapping:10];[Mapping:10]Typ:2="f";*)
	QUERY:C277([Mapping:10]; & [Mapping:10]NeueNr:4#0;*)
	QUERY:C277([Mapping:10]; & [Mapping:10]Typ:2="f";*)
	QUERY:C277([Mapping:10]; & [Mapping:10]NeuerName:5#"";*)
	QUERY:C277([Mapping:10]; & [Mapping:10]TabNr:7=$vi_TabNr)
	ORDER BY:C49([Mapping:10];[Mapping:10]NeueNr:4)
	
	FIRST RECORD:C50([Mapping:10])
	$vi_Lauf:=1
	While (Not:C34(End selection:C36([Mapping:10])))
		[Mapping:10]NeueNr:4:=$vi_Lauf
		SAVE RECORD:C53([Mapping:10])
		$vi_Lauf:=$vi_Lauf+1
		NEXT RECORD:C51([Mapping:10])
	End while 
	
	
End if 
