//%attributes = {}
  //p_Map_OrgFeldEinlesen
  //Legt  ein 1:1-Mapping der für dieses Datenbank relevanten Felder für die aktuelle Umfrage an
  //20151120

C_TEXT:C284($vs_RelTabellen)
C_LONGINT:C283($vi_AktTabelle;$vi_lauf;$vi_TabellenZaehler)
C_BOOLEAN:C305($vb_Weiter)

  //$vs_RelTabellen muss eine Liste der relevanten Tabellen enthalten, immer mit ";" getrennt, auch die letzte am Ende!
  //Tabellennummern lassen sich im Zweifelsfall in einem Stukturausdruck durchzaehlen
$vs_RelTabellen:="4;6;"

$vb_Weiter:=True:C214
ALL RECORDS:C47([Mapping:10])
If (Records in selection:C76([Mapping:10])#0)
	CONFIRM:C162("Es gibt bereits ein Mapping - alles wird ohne weitere Nachfrage gelöscht!")
	If (OK=1)
		DELETE SELECTION:C66([Mapping:10])
	Else 
		$vb_Weiter:=False:C215
	End if 
End if 

If ($vb_Weiter)
	  //Tabellennamen und Felder in [Mapping] ablegen
	$vi_TabellenZaehler:=1
	While (Position:C15(";";$vs_RelTabellen)#0)
		$vi_AktTabelle:=Num:C11(Substring:C12($vs_RelTabellen;1;Position:C15(";";$vs_RelTabellen)-1))
		CREATE RECORD:C68([Mapping:10])
		[Mapping:10]Typ:2:="t"
		[Mapping:10]TabNr:7:=$vi_AktTabelle
		[Mapping:10]NrInStrukt:3:=$vi_AktTabelle
		[Mapping:10]NameInStrukt:6:=Table name:C256($vi_AktTabelle)
		[Mapping:10]NeueNr:4:=$vi_TabellenZaehler
		[Mapping:10]NeuerName:5:=Table name:C256($vi_AktTabelle)
		SAVE RECORD:C53([Mapping:10])
		For ($vi_lauf;1;Get last field number:C255($vi_AktTabelle))
			CREATE RECORD:C68([Mapping:10])
			[Mapping:10]Typ:2:="f"
			[Mapping:10]TabNr:7:=$vi_AktTabelle
			[Mapping:10]NrInStrukt:3:=$vi_lauf
			[Mapping:10]NameInStrukt:6:=Field name:C257($vi_AktTabelle;$vi_lauf)
			[Mapping:10]NeueNr:4:=$vi_lauf
			[Mapping:10]NeuerName:5:=Field name:C257($vi_AktTabelle;$vi_lauf)
			SAVE RECORD:C53([Mapping:10])
		End for 
		$vs_RelTabellen:=Substring:C12($vs_RelTabellen;Position:C15(";";$vs_RelTabellen)+1)
		$vi_TabellenZaehler:=$vi_TabellenZaehler+1
	End while 
	ALL RECORDS:C47([Mapping:10])
	ORDER BY:C49([Mapping:10];[Mapping:10]TabNr:7;[Mapping:10]Typ:2;<;[Mapping:10]NeueNr:4;[Mapping:10]NrInStrukt:3)
End if 