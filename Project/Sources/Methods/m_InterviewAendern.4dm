//%attributes = {}
p_LogDatenAktualisieren ("Interview ändern";vUmfrage;0;"")
AdressenLesenSchreiben 
$AdrFbNR:=Num:C11(Request:C163("Interview ÄNDERN: FB-Nr eingeben!"))
If (($AdrFbNR>0) & (OK=1))
	QUERY:C277([TelefonNummer:4];[TelefonNummer:4]Umfrage:30=vUmfrage;*)
	QUERY:C277([TelefonNummer:4]; & [TelefonNummer:4]AdrFBNr:20=$AdrFbNR)
	Case of 
		: (Records in selection:C76([TelefonNummer:4])=0)
			ALERT:C41("Die AdrFb-Nummer "+String:C10($AdrFbNR)+" gibt es nicht!")
		: (Records in selection:C76([TelefonNummer:4])>1)
			ALERT:C41("Die AdrFb-Nummer "+String:C10($AdrFbNR)+" gibt es mehrfach!!")
		Else 
			If ([TelefonNummer:4]AntwASCII:41="")
				ALERT:C41("Bei AdrFb-Nummer "+String:C10($AdrFbNR)+" sind noch keine Antworten drin!")
			End if 
			FORM SET INPUT:C55([TelefonNummer:4];"eingabe kompl")
			MODIFY RECORD:C57([TelefonNummer:4])
	End case 
	UNLOAD RECORD:C212([TelefonNummer:4])
End if 
p_LogDatenAktualisieren ("Startbildschirm";vUmfrage;0;"")
