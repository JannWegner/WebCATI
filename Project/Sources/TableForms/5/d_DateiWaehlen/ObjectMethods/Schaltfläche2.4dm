Case of 
	: (Form event code:C388=On Clicked:K2:4)
		Case of 
			: (vsFilter#"")
				vsDatei:=vsFilter
			: (asDateiListe{asDateiListe}#"")
				vsDatei:=asDateiListe{asDateiListe}
			Else 
				vsDatei:=""
				  //ALERT("Bitte Datei wählen!")
		End case 
		vsDatei:=p_DateiWaehlen_DateiGewaehlt (vsPfad+vsDatei;viLesenSchreiben)
		If (vsDatei#"")
			ACCEPT:C269
		End if 
End case 