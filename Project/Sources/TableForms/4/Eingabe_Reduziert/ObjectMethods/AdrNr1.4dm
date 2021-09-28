Case of 
	: (Form event code:C388=On Data Change:K2:15)
		If (Old:C35([TelefonNummer:4]Telefon1:19)#[TelefonNummer:4]Telefon1:19)
			[TelefonNummer:4]Kommentar:6:=String:C10(Current date:C33)+"/"+String:C10(Current time:C178)+" * "+Current user:C182+" * Erst-Telefon geändert - war: "+Old:C35([TelefonNummer:4]Telefon1:19)+Char:C90(13)+[TelefonNummer:4]Kommentar:6
		End if 
End case 