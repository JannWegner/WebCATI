If (Records in set:C195("UserSet")#1)
	ALERT:C41("Bitte genau einen Datensatz markieren!")
Else 
	CONFIRM:C162("Markierten Datensatz wirklich löschen?")
	If (OK=1)
		USE SET:C118("UserSet")
		DELETE SELECTION:C66([TelefonNummer:4])
		ALL RECORDS:C47([TelefonNummer:4])
		QUERY:C277([TelefonNummer:4];[TelefonNummer:4]Umfrage:30=vUmfrage)
	Else 
		ALERT:C41("Nix passiert!")
	End if 
End if 
UNLOAD RECORD:C212([TelefonNummer:4])