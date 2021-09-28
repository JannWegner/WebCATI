If ([TelefonNummer:4]AntwASCII:41#"")
	p_FensterAnpassen (1070;850)
	FORM SET INPUT:C55([TelefonNummer:4];"AntwortAnsicht")
	DIALOG:C40([TelefonNummer:4];"AntwortAnsicht")
Else 
	ALERT:C41("Noch keine Antworten eingegeben!")
End if 