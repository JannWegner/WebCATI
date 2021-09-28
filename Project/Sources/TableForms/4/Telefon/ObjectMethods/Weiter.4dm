[TelefonNummer:4]WiederAm:2:=Current date:C33
[TelefonNummer:4]WiederUm:3:=Current time:C178-Current time:C178
[TelefonNummer:4]FixTermin:36:=False:C215

vantw:=Replace string:C233(vantw;"_";"")
If (vantw="")
	ALERT:C41("Ich bitte um ein Eingabe!")
Else 
	EinsZurueck:="Telefon"
	Case of 
		: (vantw="1")
			[TelefonNummer:4]StatusErklärung:11:="Besetzt"
			weitermit:=weitermit_neu ("Später")
			[TelefonNummer:4]Historie:4:=String:C10(Current date:C33)+"/"+String:C10(Current time:C178)+" * "+vName+" * Wiedervorlage/Besetzt"+Char:C90(13)+[TelefonNummer:4]Historie:4
		: (vantw="2")
			[TelefonNummer:4]StatusErklärung:11:="Keine Abnahme"
			weitermit:=weitermit_neu ("Später")
			[TelefonNummer:4]Historie:4:=String:C10(Current date:C33)+"/"+String:C10(Current time:C178)+" * "+vName+" * Wiedervorlage/Keine Abnahme"+Char:C90(13)+[TelefonNummer:4]Historie:4
		: (vantw="3")
			[TelefonNummer:4]Status:5:="Abbruch"
			[TelefonNummer:4]StatusErklärung:11:="Kein Anschluß"
			EndeNummer:=True:C214
			[TelefonNummer:4]Historie:4:=String:C10(Current date:C33)+"/"+String:C10(Current time:C178)+" * "+vName+" * Abbruch/Kein Anschluß"+Char:C90(13)+[TelefonNummer:4]Historie:4
		: (vantw="4")
			[TelefonNummer:4]StatusErklärung:11:="Anrufbeantworter"
			weitermit:=weitermit_neu ("Später")
			[TelefonNummer:4]Historie:4:=String:C10(Current date:C33)+"/"+String:C10(Current time:C178)+" * "+vName+" * Wiedervorlage/Anrufbeantworter"+Char:C90(13)+[TelefonNummer:4]Historie:4
		: (vantw="5")
			[TelefonNummer:4]Status:5:="Abbruch"
			[TelefonNummer:4]StatusErklärung:11:="Fax/Modem"
			EndeNummer:=True:C214
			[TelefonNummer:4]Historie:4:=String:C10(Current date:C33)+"/"+String:C10(Current time:C178)+" * "+vName+" * Abbruch/Fax/Modem"+Char:C90(13)+[TelefonNummer:4]Historie:4
		: (vantw="6")
			If (([TelefonNummer:4]Umfrage:30="5225_Raucher") | ([TelefonNummer:4]Umfrage:30="5258_RauchII") | ([TelefonNummer:4]Umfrage:30="6217_Rauch_III"))
				weitermit:=weitermit_neu ("int_bereit_5225")
			Else 
				weitermit:=weitermit_neu ("int_bereit")
			End if 
		: (vantw="7")
			[TelefonNummer:4]Status:5:="Abbruch"
			[TelefonNummer:4]StatusErklärung:11:="Techn. Probleme"
			EndeNummer:=True:C214
			[TelefonNummer:4]Historie:4:=String:C10(Current date:C33)+"/"+String:C10(Current time:C178)+" * "+vName+" * Abbruch/Techn. Probleme"+Char:C90(13)+[TelefonNummer:4]Historie:4
		: (vantw="8")
			[TelefonNummer:4]StatusErklärung:11:="Pause besetzt"
			weitermit:=weitermit_neu ("Später")
			[TelefonNummer:4]Historie:4:=String:C10(Current date:C33)+"/"+String:C10(Current time:C178)+" * "+vName+" * Wiedervorlage/Pause besetzt"+Char:C90(13)+[TelefonNummer:4]Historie:4
		: (vantw="9")
			weitermit:=weitermit_neu ("Ausfall")
	End case 
	var2feld (".vs1_Telefon";vantw;"")
	sichere_DS (Table:C252(->[TelefonNummer:4]);DEBUG)
	ACCEPT:C269
End if 