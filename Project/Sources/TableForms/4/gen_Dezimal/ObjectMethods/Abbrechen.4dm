CONFIRM:C162("Wollen Sie das Interview wirklich abbrechen?";"Nein, weitermachen";"Ja, abbrechen")
If (OK=0)
	weitermit:=weitermit_neu ("Abbruch")
	sichere_DS (Table:C252(->[TelefonNummer:4]);DEBUG)
End if 