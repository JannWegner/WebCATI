//%attributes = {}
QUERY:C277([Bogen:6];[Bogen:6]Umfrage:20=vUmfrage;*)
QUERY:C277([Bogen:6]; & [Bogen:6]nextID:6#"")
SELECTION TO ARRAY:C260([Bogen:6]nextID:6;asZielIDs)
QUERY:C277([Variablen:5];[Variablen:5]Umfrage:3=vUmfrage)
INSERT IN ARRAY:C227(asZielIDs;1)
asZielIDs{1}:=[Variablen:5]ErsteFrage:23

QUERY:C277([Bogen:6];[Bogen:6]Umfrage:20=vUmfrage)
ORDER BY:C49([Bogen:6]ID:1)
ARRAY TEXT:C222($tMarken;0)
SELECTION TO ARRAY:C260([Bogen:6]ID:1;$tMarken)

C_TEXT:C284(vt_FehlerAnzeige)
vt_FehlerAnzeige:=""
FIRST RECORD:C50([Bogen:6])
While (Not:C34(End selection:C36([Bogen:6])))
	MESSAGE:C88([Bogen:6]ID:1)
	  //NextIDs pruefen
	If ([Bogen:6]nextID:6#"")
		If ((Find in array:C230($tMarken;[Bogen:6]nextID:6)=-1) & ([Bogen:6]nextID:6#"Ende@"))
			vt_FehlerAnzeige:=vt_FehlerAnzeige+[Bogen:6]ID:1+": Ziel-ID (nextID) "+[Bogen:6]nextID:6+" gibt es nicht!"+Char:C90(13)
		End if 
	End if 
	
	If ([Bogen:6]Bedingung:10="ex_res@")
		
		  //id2feld's prüfen
		$vtBedingung:=[Bogen:6]Bedingung:10
		While (Position:C15("id2feld";$vtBedingung)#0)
			$vtBedingung:=Substring:C12($vtBedingung;Position:C15("id2feld";$vtBedingung)+9)
			If (Find in array:C230($tMarken;Substring:C12($vtBedingung;1;Position:C15(Char:C90(34);$vtBedingung)-1))=-1)
				vt_FehlerAnzeige:=vt_FehlerAnzeige+[Bogen:6]ID:1+": die ID (Bedingung) "+Substring:C12($vtBedingung;1;Position:C15(Char:C90(34);$vtBedingung)-1)+" gibt es nicht!"+Char:C90(13)
			End if 
			$vtBedingung:=Substring:C12($vtBedingung;Position:C15(Char:C90(34);$vtBedingung)+1)
		End while 
		
		  //contains prüfen
		$vtBedingung:=[Bogen:6]Bedingung:10
		While (Position:C15("contains";$vtBedingung)#0)
			$vtBedingung:=Substring:C12($vtBedingung;Position:C15("contains";$vtBedingung)+10)
			If (Find in array:C230($tMarken;Substring:C12($vtBedingung;1;Position:C15(Char:C90(34);$vtBedingung)-1))=-1)
				vt_FehlerAnzeige:=vt_FehlerAnzeige+[Bogen:6]ID:1+": die ID (Bedingung) "+Substring:C12($vtBedingung;1;Position:C15(Char:C90(34);$vtBedingung)-1)+" gibt es nicht!"+Char:C90(13)
			End if 
			$vtBedingung:=Substring:C12($vtBedingung;Position:C15(Char:C90(34);$vtBedingung)+1)
		End while 
		
		  //Sprungziele von id2felds pruefen
		$vtBedingung:=[Bogen:6]Bedingung:10
		  //contains-Klammern entfernen
		While (Position:C15("contains";$vtBedingung)#0)
			$vtBedingung:=Substring:C12($vtBedingung;1;Position:C15("contains";$vtBedingung)-1)+Substring:C12($vtBedingung;Position:C15(Char:C90(41);Substring:C12($vtBedingung;Position:C15("contains";$vtBedingung)))+Position:C15("contains";$vtBedingung))
		End while 
		While (Position:C15(";"+Char:C90(34);$vtBedingung)#0)
			$vtBedingung:=Substring:C12($vtBedingung;Position:C15(";"+Char:C90(34);$vtBedingung)+2)
			If (Find in array:C230($tMarken;Substring:C12($vtBedingung;1;Position:C15(Char:C90(34);$vtBedingung)-1))=-1)
				vt_FehlerAnzeige:=vt_FehlerAnzeige+[Bogen:6]ID:1+": die ID (Bedingung) "+Substring:C12($vtBedingung;1;Position:C15(Char:C90(34);$vtBedingung)-1)+" gibt es nicht!"+Char:C90(13)
			End if 
			INSERT IN ARRAY:C227(asZielIDs;1)
			asZielIDs{1}:=Substring:C12($vtBedingung;1;Position:C15(Char:C90(34);$vtBedingung)-1)
			$vtBedingung:=Substring:C12($vtBedingung;Position:C15(Char:C90(34);$vtBedingung)+1)
		End while 
	End if 
	NEXT RECORD:C51([Bogen:6])
	
End while 

  //Auf Ueberfluessige Bogen testen
For ($lauf;1;Size of array:C274($tMarken))
	If (Find in array:C230(asZielIDs;$tMarken{$lauf})=-1)
		vt_FehlerAnzeige:=vt_FehlerAnzeige+"Das Formular "+$tMarken{$lauf}+" wird von nirgendwo her aufgerufen!"+Char:C90(13)
	End if 
End for 

If (vt_FehlerAnzeige#"")
	$FensterNr:=Open window:C153(100;100;1000;1000;"Fehlerliste")
	SET WINDOW TITLE:C213("Fehlerliste "+vUmfrage)
	DIALOG:C40([Bogen:6];"d_Fehleranzeige")
Else 
	ALERT:C41("Keine Fehler gefunden!")
End if 
