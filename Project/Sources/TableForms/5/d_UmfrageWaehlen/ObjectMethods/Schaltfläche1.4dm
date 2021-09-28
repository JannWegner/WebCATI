If (taUmfragenAnzeige<1)
	ALERT:C41("Bitte eine Umfrage auswählen")
Else 
	vUmfrage:=taUmfragen{taUmfragenAnzeige}
	ACCEPT:C269
End if 