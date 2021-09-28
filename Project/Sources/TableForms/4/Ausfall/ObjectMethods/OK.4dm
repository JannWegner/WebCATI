vantw:=Replace string:C233(vantw;"_";"")
vantw:=Replace string:C233(vantw;"^";"")

If (vantw="")
	ALERT:C41("Ich bitte um ein Eingabe!")
	GOTO OBJECT:C206(vantw)
Else 
	EinsZurueck:=weitermit
	
	Case of 
		: (Position:C15(","+vantw+",";",1,2,3,4,5,6,9,11,12,13,14,15,16,19,21,22,23,29,31,32,33,34,35,36,37,39,")=0)
			ALERT:C41("Eingabe: "+vantw+" nicht erlaubt!")
			GOTO OBJECT:C206(vantw)
			ABORT:C156
		: ((vantw_offen="") & ((vantw="9") | (vantw="19") | (vantw="29") | (vantw="34") | (vantw="35") | (vantw="39")))
			ALERT:C41("Bei dieser Antwort muß auch 'Sonstiges' angegeben werden!")
			GOTO OBJECT:C206(vantw_offen)
			ABORT:C156
		: ((vantw_offen#"") & (vantw#"9") & (vantw#"19") & (vantw#"29") & (vantw#"34") & (vantw#"35") & (vantw#"39"))
			ALERT:C41("Bei dieser Antwort muß 'Sonstiges' leer sein!")
			GOTO OBJECT:C206(vantw_offen)
			ABORT:C156
		Else 
			[TelefonNummer:4]StatusErklärung:11:="Ausfallgrund: "+vantw
			
			[TelefonNummer:4]Status:5:="Ausfall"
			var2feld (".vs3_Ausfall";vantw;"")
			var2feld (".vs4_AusfallSonst";vantw_Offen;"")
			sichere_DS (Table:C252(->[TelefonNummer:4]);DEBUG)
			EinsZurueck:=weitermit
			weitermit:=weitermit_neu ("Ende")
			ACCEPT:C269
	End case 
End if 