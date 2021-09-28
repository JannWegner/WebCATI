//%attributes = {}
p_LogDatenAktualisieren ("Adressen rücksetzen";vUmfrage;0;"")

CONFIRM:C162("Adressen rücksetzen für letzte Auswahl (n="+String:C10(Records in selection:C76([TelefonNummer:4]))+") oder alle Adressen?";"Alle";"Auswahl")
If (OK=1)
	QUERY:C277([TelefonNummer:4];[TelefonNummer:4]Umfrage:30=vUmfrage)
End if 

CONFIRM:C162("Wirklich alle Interview-Daten zurücksetzen?";"Nein";"Rücksetzen")
If (OK=0)
	MESSAGE:C88("Setze Adressen zurück ...")
	
	READ WRITE:C146([TelefonNummer:4])
	If (Read only state:C362([TelefonNummer:4]))
		ALERT:C41("[TelefonNummer] im 'Nur-Lesen-Modus!' - Abbruch")
	Else 
		vs_KommentarNeu:=""
		vs_HistNeu:=""
		MESSAGES OFF:C175
		START TRANSACTION:C239
		APPLY TO SELECTION:C70([TelefonNummer:4];p_Adr_jungfr_setzen_Formel )
		If (OK=1)
			VALIDATE TRANSACTION:C240
		Else 
			ALERT:C41("Da hat was nicht geklappt - es wird nichts geändert!")
			CANCEL TRANSACTION:C241
		End if 
		MESSAGES ON:C181
		
	End if 
	READ ONLY:C145([TelefonNummer:4])
End if 

p_LogDatenAktualisieren ("Startbildschirm";vUmfrage;0;"")
