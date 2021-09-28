If (Form event code:C388=On Load:K2:1)
	If ([TelefonNummer:4]WeiterMitFrage:7="")
		If ([TelefonNummer:4]aktAnsprechp:38="")
			veröff:="Erstkontakt, ZP unbekannt"+Char:C90(13)+Char:C90(13)+"Guten Tag, mein Name ist .... Ich rufe Sie vom Institut für Demoskopie Allens"+"bach ..."
		Else 
			veröff:="Erstkontakt, bekannte ZP"+Char:C90(13)+Char:C90(13)+"Guten Tag, mein Name ist .... Ich rufe Sie vom Institut für Demoskopie Allens"+"bach ..."
		End if 
	Else 
		veröff:="Wiederanruf:"+Char:C90(13)+Char:C90(13)+"weitermit = "+[TelefonNummer:4]WeiterMitFrage:7
	End if 
	vakt_Teln:=[TelefonNummer:4]Telefon1:19
	vakt_AP:=[TelefonNummer:4]aktAnsprechp:38
	
	vantw:=id2feld (".vs2_IntBereit")
	GOTO OBJECT:C206(vantw)
	
End if 