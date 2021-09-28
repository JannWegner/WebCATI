If (Form event code:C388=On Load:K2:1)
	  //Laenge der Original-Antwort testen
	If (Length:C16(vavgtext)<2)
		  //KKA
		  //Vorgelagert in Seitenkontrolle (20.05.2008)
		  //vantw:=""
		  //WeiterButtonGedrueckt ("NoCheck")
		ALERT:C41("Kritischer Fehler in  Formularmethode [Telefonnummer]gen_Spez: Darf gar nicht sei"+"n!!!")
	Else 
		OBJECT SET FILTER:C235(vantw;get_filter )
		vftext:=tSpezFrText{Find in array:C230(tSpezId;[Bogen:6]AvgText:5)}
		vantw:=id2feld (weitermit)
	End if 
	p_TelefonAvgFormatSetzen 
End if 