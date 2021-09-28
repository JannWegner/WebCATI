vantw:=Replace string:C233(vantw;"_";"")
vantw:=Replace string:C233(vantw;"^";"")

If (vantw="")
	ALERT:C41("Ich bitte um ein Eingabe!")
	GOTO OBJECT:C206(vantw)
Else 
	EinsZurueck:=weitermit
	
	Case of 
		: (Position:C15(","+vantw+",";",92,93,94,95,96,")=0)
			ALERT:C41("Eingabe: "+vantw+" nicht erlaubt!")
			GOTO OBJECT:C206(vantw)
			ABORT:C156
		Else 
			[TelefonNummer:4]StatusErklärung:11:="Ausfallgrund: "+vantw
			
			[TelefonNummer:4]Status:5:="Ausfall"
			var2feld (".vs3_Ausfall";vantw;"")
			var2feld (".vs4_AusfallSonst";"";"")
			sichere_DS (Table:C252(->[TelefonNummer:4]);DEBUG)
			EinsZurueck:=weitermit
			weitermit:=weitermit_neu ("Ende")
			ACCEPT:C269
	End case 
End if 