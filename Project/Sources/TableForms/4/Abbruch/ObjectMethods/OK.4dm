  //[TelefonNummer];"Abbruch".b_OK
  //20140610

vantw:=Replace string:C233(vantw;"_";"")

If (vantw="")
	ALERT:C41("Ich bitte um ein Eingabe!")
Else 
	Case of 
		: (vantw="1")
			[TelefonNummer:4]StatusErklärung:11:="Keine Zeit mehr"
		: (vantw="2")
			[TelefonNummer:4]StatusErklärung:11:="Keine Lust mehr, da zu lang"
		: (vantw="3")
			[TelefonNummer:4]StatusErklärung:11:="Keine Lust mehr, da uninteressant"
		: (vantw="4")
			[TelefonNummer:4]StatusErklärung:11:="Einfach aufgelegt"
		: (vantw="5")
			[TelefonNummer:4]StatusErklärung:11:="Quote voll"
		: (vantw="6")
			[TelefonNummer:4]StatusErklärung:11:="Interviewer-Abbruch"
		: (vantw="7")
			[TelefonNummer:4]StatusErklärung:11:="Bogen-Abbruch"
	End case 
	[TelefonNummer:4]Status:5:="Abgebrochen"
	[TelefonNummer:4]Historie:4:=String:C10(Current date:C33)+"/"+String:C10(Current time:C178)+" * "+vName+" * Abgebrochen/"+[TelefonNummer:4]StatusErklärung:11+Char:C90(13)+[TelefonNummer:4]Historie:4
	var2feld (".vs5_Abbruch";vantw;"")
	sichere_DS (Table:C252(->[TelefonNummer:4]);DEBUG)
	EinsZurueck:=weitermit
	weitermit:=weitermit_neu ("Ende")
	ACCEPT:C269
End if 
