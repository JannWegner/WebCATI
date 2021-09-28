CONFIRM:C162("Suchen mit FB-Nummer aus ASCI-Datei?";"Ja";"Abbrechen")
If (OK=1)
	C_TIME:C306($vhDokRef)
	C_TEXT:C284($vs_LeseNr)
	C_TEXT:C284($vs_NotFound)
	C_LONGINT:C283($vl_Zaehler)
	ARRAY LONGINT:C221($al_SuchFBs;0)
	
	$vl_Zaehler:=0
	$vs_NotFound:=""
	$vhDokRef:=Open document:C264("";"TEXT")
	CREATE EMPTY SET:C140([TelefonNummer:4];"$m_SuchMenge")
	If (OK=1)  // Wurde das Dokument geöffnet
		Repeat   // Durchlaufe bis keine Daten mehr da sind
			$vl_Zaehler:=$vl_Zaehler+1
			RECEIVE PACKET:C104($vhDokRef;$vs_LeseNr;Char:C90(Carriage return:K15:38))  // Lies eine Zeile
			If ((OK=1) | ($vs_LeseNr#""))  //Sind wir schon am Ende?
				If ($vl_Zaehler%20=0)
					MESSAGE:C88("Anz. FBs gelesen: "+String:C10($vl_Zaehler)+" | Akt. FB-Nummer: "+$vs_LeseNr)
				End if 
				INSERT IN ARRAY:C227($al_SuchFBs;1)
				$al_SuchFBs{1}:=Num:C11($vs_LeseNr)
			End if 
		Until ((OK=0))
		CLOSE DOCUMENT:C267($vhDokRef)
		
		MESSAGE:C88("Auswahl wird gebildet ...")
		QUERY WITH ARRAY:C644([TelefonNummer:4]AdrFBNr:20;$al_SuchFBs)
		QUERY SELECTION:C341([TelefonNummer:4];[TelefonNummer:4]Umfrage:30=vUmfrage)
		ALERT:C41("Sätze gesucht: "+String:C10(Size of array:C274($al_SuchFBs))+" / "+String:C10(Records in selection:C76([TelefonNummer:4]))+" gefunden")
		
	End if 
End if 
