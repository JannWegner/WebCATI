//%attributes = {"publishedWeb":true}
p_LogDatenAktualisieren ("Interview zeigen";vUmfrage;0;"")
$AdrFbNR:=Num:C11(Request:C163("Bitte Adress-/Fragebogen-Nummer eingeben!"))
If (($AdrFbNR>0) & (OK=1))
	QUERY:C277([TelefonNummer:4];[TelefonNummer:4]Umfrage:30=vUmfrage;*)
	QUERY:C277([TelefonNummer:4]; & [TelefonNummer:4]AdrFBNr:20=$AdrFbNR)
	Case of 
		: (Records in selection:C76([TelefonNummer:4])=0)
			ALERT:C41("Die AdrFb-Nummer "+String:C10($AdrFbNR)+" gibt es nicht!")
		: (Records in selection:C76([TelefonNummer:4])>1)
			ALERT:C41("Die AdrFb-Nummer "+String:C10($AdrFbNR)+" gibt es mehrfach!!")
		: ([TelefonNummer:4]AntwASCII:41="")
			ALERT:C41("Bei AdrFb-Nummer "+String:C10($AdrFbNR)+" sind noch keine Antworten drin!")
		Else 
			FORM SET INPUT:C55([TelefonNummer:4];"AntwortAnsicht")
			DISPLAY SELECTION:C59([TelefonNummer:4])
	End case 
End if 
p_LogDatenAktualisieren ("Startbildschirm";vUmfrage;0;"")
