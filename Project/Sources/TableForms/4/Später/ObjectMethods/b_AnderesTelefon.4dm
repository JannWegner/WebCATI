$NeueNr:=Request:C163("Wollen Sie die Telefonnummer ändern?";[TelefonNummer:4]Telefon1:19)
If (OK=1)
	[TelefonNummer:4]Kommentar:6:=String:C10(Current date:C33)+" "+String:C10(Current time:C178)+"   "+Current user:C182+Char:C90(13)+" Alte TelNr. "+[TelefonNummer:4]Telefon1:19+" geändert!"+Char:C90(13)+"______________________________________"+Char:C90(13)+[TelefonNummer:4]Kommentar:6
	[TelefonNummer:4]Telefon1:19:=$NeueNr
Else 
	ALERT:C41("Nix passiert")
End if 
