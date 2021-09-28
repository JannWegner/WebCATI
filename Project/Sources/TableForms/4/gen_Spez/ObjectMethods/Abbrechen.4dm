CONFIRM:C162("Wollen Sie diesen Spezial-Bogen wirklich abbrechen?";"Nein, weitermachen";"Ja, abbrechen")
If (OK=0)
	EndeNummer:=True:C214
	sichere_DS (Table:C252(->[TelefonNummer:4]);DEBUG)
End if 