If (Records in set:C195("UserSet")#1)
	ALERT:C41("Bitte genau einen Datensatz markieren!")
Else 
	CONFIRM:C162("Markierten Datensatz wirklich löschen?")
	If (OK=1)
		USE SET:C118("UserSet")
		DELETE SELECTION:C66([Bogen:6])
		ALL RECORDS:C47([Bogen:6])
		QUERY:C277([Bogen:6];[Bogen:6]Umfrage:20=vUmfrage)
		ORDER BY:C49([Bogen:6]ID:1)
	Else 
		ALERT:C41("Nix passiert!")
	End if 
End if 