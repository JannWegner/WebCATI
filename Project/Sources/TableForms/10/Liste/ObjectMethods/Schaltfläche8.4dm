  //Tabelle wählen
  //Jann Wegner
  //20151123

C_LONGINT:C283($vi_TabNr)
$vi_TabNr:=Num:C11(Request:C163("Tabellennummer (1-"+String:C10(Get last table number:C254)+")"))
If ((OK=0) | ($vi_TabNr<1) | ($vi_TabNr>(Get last table number:C254)))
	ALERT:C41("Ungültige Tabellennummer")
Else 
	QUERY:C277([Mapping:10];[Mapping:10]TabNr:7=$vi_TabNr)
	ORDER BY:C49([Mapping:10];[Mapping:10]TabNr:7;[Mapping:10]Typ:2;<;[Mapping:10]NeueNr:4;[Mapping:10]NrInStrukt:3)
End if 

