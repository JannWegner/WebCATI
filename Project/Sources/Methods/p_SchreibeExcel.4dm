//%attributes = {}
  //Speichert die Daten als Excel
$RefNr:=Create document:C266("")
If (OK=1)
	COPY NAMED SELECTION:C331([Bogen:6];"$_ns_Bogen")
	MESSAGE:C88("Suche passende Formulare raus ...")
	  //Formualre bereinigen
	CREATE SET:C116([Bogen:6];"$m_AlleBogen")
	QUERY SELECTION:C341([Bogen:6];[Bogen:6]ID:1="@-bed")
	CREATE SET:C116([Bogen:6];"$m_WegBogen")
	USE SET:C118("$m_AlleBogen")
	QUERY SELECTION:C341([Bogen:6];[Bogen:6]ID:1="@-do")
	QUERY SELECTION:C341([Bogen:6];[Bogen:6]Bedingung:10#"Fassung";*)
	QUERY SELECTION:C341([Bogen:6]; & [Bogen:6]Bedingung:10#"Datum";*)
	QUERY SELECTION:C341([Bogen:6]; & [Bogen:6]Bedingung:10#"Wochentag";*)
	QUERY SELECTION:C341([Bogen:6]; & [Bogen:6]Bedingung:10#"Dauer";*)
	QUERY SELECTION:C341([Bogen:6]; & [Bogen:6]Bedingung:10#"write(@")
	ADD TO SET:C119([Bogen:6];"$m_WegBogen")
	DIFFERENCE:C122("$m_AlleBogen";"$m_WegBogen";"$m_AlleBogen")
	
	USE SET:C118("$m_AlleBogen")
	SELECTION TO ARRAY:C260([Bogen:6]ID:1;$as_BogenID)
	  //Halboffene auch noch dazu ...
	QUERY SELECTION:C341([Bogen:6];[Bogen:6]FormNam:8="gen_HalbOffen")
	FIRST RECORD:C50([Bogen:6])
	While (Not:C34(End selection:C36([Bogen:6])))
		INSERT IN ARRAY:C227($as_BogenID;1)
		$as_BogenID{1}:=[Bogen:6]ID:1+"Offen"
		NEXT RECORD:C51([Bogen:6])
	End while 
	SORT ARRAY:C229($as_BogenID)
	
	SEND PACKET:C103($RefNr;"FrID")
	For ($vi_lauf;1;Size of array:C274($as_BogenID))
		SEND PACKET:C103($RefNr;Char:C90(9)+$as_BogenID{$vi_lauf})
	End for 
	SEND PACKET:C103($RefNr;Char:C90(13))
	
	MESSAGE:C88("Schreibe Datensätze ...")
	$vi_lauf2:=1
	FIRST RECORD:C50([TelefonNummer:4])
	While (Not:C34(End selection:C36([TelefonNummer:4])))
		If ($vi_lauf2%100=0)
			MESSAGE:C88("Schreibe Satz "+String:C10($vi_lauf2)+" von "+String:C10(Records in selection:C76([TelefonNummer:4]))+" ...")
		End if 
		SEND PACKET:C103($RefNr;String:C10([TelefonNummer:4]AdrFBNr:20))
		For ($vi_lauf;1;Size of array:C274($as_BogenID))
			Case of 
				: (Position:C15($as_BogenID{$vi_lauf}+Char:C90(13);[TelefonNummer:4]Wegspeicher:48)#0)
					SEND PACKET:C103($RefNr;Char:C90(9)+Replace string:C233(LiA ($as_BogenID{$vi_lauf});Char:C90(13);"  **  "))
				: ($as_BogenID{$vi_lauf}="@Offen")
					$vs_IdOhneOffen:=Replace string:C233($as_BogenID{$vi_lauf};"Offen";"")  //"Offen" aus der ID entfernen
					If (Position:C15($vs_IdOhneOffen+Char:C90(13);[TelefonNummer:4]Wegspeicher:48)#0)  //Gibt es die ID ohne "Offen" im Wegspeicher => Halboffene Frage
						$vs_ID:="|"+$as_BogenID{$vi_lauf}+"|"
						If (Position:C15($vs_ID;[TelefonNummer:4]AntwASCII:41)#0)  //Es gibt auch tatsächlich eine Antwort
							SEND PACKET:C103($RefNr;Char:C90(9)+Replace string:C233(LiA ($as_BogenID{$vi_lauf});Char:C90(13);"  **  "))
						Else 
							SEND PACKET:C103($RefNr;Char:C90(9))
						End if 
					Else 
						SEND PACKET:C103($RefNr;Char:C90(9))
					End if 
				Else 
					SEND PACKET:C103($RefNr;Char:C90(9))
			End case 
		End for 
		SEND PACKET:C103($RefNr;Char:C90(13))
		$vi_lauf2:=$vi_lauf2+1
		NEXT RECORD:C51([TelefonNummer:4])
	End while 
	
	CLOSE DOCUMENT:C267($RefNr)
	USE NAMED SELECTION:C332("$_ns_Bogen")
	
End if 