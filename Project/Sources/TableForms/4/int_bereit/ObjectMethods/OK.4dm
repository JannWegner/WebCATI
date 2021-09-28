vantw:=Replace string:C233(vantw;"_";"")
vantw:=Replace string:C233(vantw;"^";"")
EinsZurueck:=weitermit

If (vantw="")
	ALERT:C41("Ich bitte um ein Eingabe!")
Else 
	
	If (vakt_AP#[TelefonNummer:4]aktAnsprechp:38)
		[TelefonNummer:4]Kommentar:6:=String:C10(Current date:C33)+" "+String:C10(Current time:C178)+"   "+Current user:C182+Char:C90(13)+" Alter AP '"+[TelefonNummer:4]aktAnsprechp:38+"' geändert!"+Char:C90(13)+"______________________________________"+Char:C90(13)+[TelefonNummer:4]Kommentar:6
		[TelefonNummer:4]aktAnsprechp:38:=vakt_AP
	End if 
	
	If (vakt_Teln#[TelefonNummer:4]Telefon1:19)
		[TelefonNummer:4]Kommentar:6:=String:C10(Current date:C33)+" "+String:C10(Current time:C178)+"   "+Current user:C182+Char:C90(13)+" Alte TelNr. "+[TelefonNummer:4]Telefon1:19+" geändert!"+Char:C90(13)+"______________________________________"+Char:C90(13)+[TelefonNummer:4]Kommentar:6
		[TelefonNummer:4]Telefon1:19:=vakt_Teln
	End if 
	
	  //Antwortdaten schon mal schreiben
	var2feld (".vs2_IntBereit";vantw;"")
	
	  //Wie gehts weiter?
	Case of 
		: ((vantw="1") | (vantw="2") | (vantw="3"))
			[TelefonNummer:4]wmProto:37:=[TelefonNummer:4]wmProto:37+String:C10(Current time:C178;HH MM SS:K7:1)+";"+String:C10(Current date:C33;Internal date short:K1:7)+";Start"+Char:C90(13)
			p_AktuellerWegBlobSchreiben 
			If ([TelefonNummer:4]WeiterMitFrage:7="")
				weitermit:=weitermit_neu ([Variablen:5]ErsteFrage:23)
			Else 
				weitermit:=weitermit_neu ([TelefonNummer:4]WeiterMitFrage:7)
			End if 
			If ((User in group:C338(Current user:C182;"UmfrAVO")) & ([Variablen:5]ErsteFrageWartung:46#""))
				CONFIRM:C162("Weiter mit: 'Wartung' ("+[Variablen:5]ErsteFrageWartung:46+") oder "+weitermit;[Variablen:5]ErsteFrageWartung:46;weitermit)
				If (OK=1)
					weitermit:=weitermit_neu ([Variablen:5]ErsteFrageWartung:46)
				End if 
			End if 
			[TelefonNummer:4]Start Am:23:=Current date:C33
			[TelefonNummer:4]Start um:24:=Current time:C178
		: (vantw="4")
			[TelefonNummer:4]StatusErklärung:11:="Termin"
			weitermit:=weitermit_neu ("Später")
			[TelefonNummer:4]Historie:4:=String:C10(Current date:C33)+"/"+String:C10(Current time:C178)+" * "+vName+" * Wiedervorlage/Termin"+Char:C90(13)+[TelefonNummer:4]Historie:4
		: (vantw="5")
			weitermit:=weitermit_neu ("Ausfall")
	End case 
	sichere_DS (Table:C252(->[TelefonNummer:4]);DEBUG)
	ACCEPT:C269
End if 