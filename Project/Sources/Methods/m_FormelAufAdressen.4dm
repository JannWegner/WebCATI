//%attributes = {}
  // Wendet Formel auf Adressen (Telefonnummern) an

CONFIRM:C162("'Formel anwenden ...' für letzte Auswahl (n="+String:C10(Records in selection:C76([TelefonNummer:4]))+") oder alle Adressen?";"Alle";"Auswahl")
If (OK=1)
	QUERY:C277([TelefonNummer:4];[TelefonNummer:4]Umfrage:30=vUmfrage)
End if 

$Formel:=Request:C163("Formel eingeben: ";"[TelefonNummer]xxx")
If (OK=1)
	CONFIRM:C162("Formel ' "+$Formel+" ' wird angewendet auf "+String:C10(Records in selection:C76([TelefonNummer:4]))+" Adressen!";"Anwenden";"Abbrechen")
	If (OK=1)
		AdressenLesenSchreiben 
		APPLY TO SELECTION:C70([TelefonNummer:4];EXECUTE FORMULA:C63($Formel))
		ALERT:C41("Alles erledigt!")
	End if 
End if 