//%attributes = {}
  //p_Map_MappingSetzen
  //20151124

  //Arbeitet das gesamte Mapping gemäß Tabelle "Mapping" ab

C_LONGINT:C283($vi_Lauf;$vi_Lauf2)

ARRAY INTEGER:C220($ai_TabNr;0)
ARRAY TEXT:C222($ai_NeuerName;0)

QUERY:C277([Mapping:10];[Mapping:10]Typ:2="t";*)
QUERY:C277([Mapping:10]; & [Mapping:10]NeueNr:4#0)
ORDER BY:C49([Mapping:10];[Mapping:10]NeueNr:4)

  //Tabellen setzen
SELECTION TO ARRAY:C260([Mapping:10]TabNr:7;$ai_TabNr;[Mapping:10]NeuerName:5;$ai_NeuerName)
SET TABLE TITLES:C601($ai_NeuerName;$ai_TabNr)

For ($vi_Lauf;1;Size of array:C274($ai_TabNr))
	ARRAY INTEGER:C220($ai_NrInStrukt;0)
	ARRAY TEXT:C222($ai_NeuerName;0)
	
	QUERY:C277([Mapping:10];[Mapping:10]NeueNr:4#0;*)
	QUERY:C277([Mapping:10]; & [Mapping:10]Typ:2="f";*)
	QUERY:C277([Mapping:10]; & [Mapping:10]NeuerName:5#"";*)
	QUERY:C277([Mapping:10]; & [Mapping:10]TabNr:7=$ai_TabNr{$vi_Lauf})
	ORDER BY:C49([Mapping:10];[Mapping:10]NeueNr:4)
	
	SELECTION TO ARRAY:C260([Mapping:10]NrInStrukt:3;$ai_NrInStrukt;[Mapping:10]NeuerName:5;$ai_NeuerName)
	
	  //Falls gerade die Telefonnummern-Tabelle bearbeite wird (Tabelle 4)
	If ($ai_TabNr{$vi_Lauf}=4)
		For ($vi_Lauf2;17;2;-1)  //AdrFeld01-16 im Array rückwärts abklappern
			If (Field:C253(5;$vi_Lauf2+4)->="")
				DELETE FROM ARRAY:C228($ai_NrInStrukt;$vi_Lauf2)
				DELETE FROM ARRAY:C228($ai_NeuerName;$vi_Lauf2)
			Else 
				$ai_NeuerName{$vi_Lauf2}:=p_ClearFieldName (Field:C253(5;$vi_Lauf2+4)->)
			End if 
		End for 
	End if 
	SET FIELD TITLES:C602(Table:C252($ai_TabNr{$vi_Lauf})->;$ai_NeuerName;$ai_NrInStrukt;*)
	
End for 
