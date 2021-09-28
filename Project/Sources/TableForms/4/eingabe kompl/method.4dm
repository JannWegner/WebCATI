Case of 
	: (Form event code:C388=On Validate:K2:3)
		If (Current user:C182="Wegner Jann")
			CONFIRM:C162("Änderungseintrag dokumentieren?";"Ja";"Nein")
			If (OK=1)
				[TelefonNummer:4]Historie:4:=String:C10(Current date:C33)+"/"+String:C10(Current time:C178)+" * "+Current user:C182+" * Manuell geändert"+Char:C90(13)+[TelefonNummer:4]Historie:4
			End if 
		Else 
			[TelefonNummer:4]Historie:4:=String:C10(Current date:C33)+"/"+String:C10(Current time:C178)+" * "+Current user:C182+" * Manuell geändert"+Char:C90(13)+[TelefonNummer:4]Historie:4
		End if 
End case 