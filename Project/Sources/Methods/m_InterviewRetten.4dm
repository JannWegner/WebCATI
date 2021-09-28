//%attributes = {}
  //Liest das Antwort-Blob ([TelefonNummer]AntwortArrayBlob) einer Adresse aus
  //Bestückt das Antwort-Array und schreibt die Antworten in [TelefonNummer]AntwASCII 

p_LogDatenAktualisieren ("Interview retten";vUmfrage;0;"")

C_LONGINT:C283($viFbNr;$vi_wmProtoLength)
C_LONGINT:C283($vi_Lauf)
C_TEXT:C284($vs_LetzteZeile)

$viFbNr:=Num:C11(Request:C163("Welche FB-Nr retten?"))
If (OK=1)
	QUERY:C277([TelefonNummer:4];[TelefonNummer:4]Umfrage:30=vUmfrage;*)
	QUERY:C277([TelefonNummer:4]; & [TelefonNummer:4]AdrFBNr:20=$viFbNr)
	If (Records in selection:C76([TelefonNummer:4])=1)
		START TRANSACTION:C239
		C_BLOB:C604($vxAntwortBlob)
		$vxAntwortBlob:=[TelefonNummer:4]AntwortArrayBlob:22
		ARRAY TEXT:C222(atVar;0)
		AntwortArray_Init 
		BLOB TO VARIABLE:C533($vxAntwortBlob;atAntworten)
		AntwortArray_Schreiben 
		If (Length:C16([TelefonNummer:4]AntwASCII:41)#0)
			[TelefonNummer:4]Status:5:="Wiedervorlage"
			[TelefonNummer:4]StatusErklärung:11:="Termin"
			[TelefonNummer:4]WiederAm:2:=Date:C102("31.12."+String:C10(Year of:C25(Current date:C33)+1))
			[TelefonNummer:4]WeiterMitFrage:7:=""
			[TelefonNummer:4]Historie:4:=String:C10(Current date:C33)+"/"+String:C10(Current time:C178)+" * "+Current user:C182+" * Interview gerettet"+Char:C90(13)+[TelefonNummer:4]Historie:4
			  //Vorletztes CR in wmproto suchen
			$vi_Lauf:=2
			$vi_wmProtoLength:=Length:C16([TelefonNummer:4]wmProto:37)
			While (Character code:C91([TelefonNummer:4]wmProto:37[[$vi_wmProtoLength-$vi_Lauf]])#13)
				$vi_lauf:=$vi_lauf+1
			End while 
			$vs_LetzteZeile:=Substring:C12([TelefonNummer:4]wmProto:37;$vi_wmProtoLength-$vi_Lauf+1;$vi_wmProtoLength-1)
			[TelefonNummer:4]wmProto:37:=[TelefonNummer:4]wmProto:37+Substring:C12($vs_LetzteZeile;1;20)+"Ende_Gerettet"+Char:C90(13)
			SAVE RECORD:C53([TelefonNummer:4])
			VALIDATE TRANSACTION:C240
			ALERT:C41("Hat geklappt!")
		Else 
			CANCEL TRANSACTION:C241
			ALERT:C41("m_InterviewRetten"+Char:C90(13)+"Das war nicht so erfolgreich "+String:C10($viFbNr))
		End if 
	Else 
		ALERT:C41("m_InterviewRetten"+Char:C90(13)+"Es gibt nicht genau einen Datensatz "+String:C10($viFbNr))
	End if 
	UNLOAD RECORD:C212([TelefonNummer:4])
End if 

p_LogDatenAktualisieren ("Startbildschirm";vUmfrage;0;"")
