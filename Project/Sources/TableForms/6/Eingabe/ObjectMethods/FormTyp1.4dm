Case of 
	: (Form event code:C388=On Data Change:K2:15)
		Case of 
			: ([Bogen:6]FormNam:8="gen_@")
				[Bogen:6]FormTyp:7:="gen"
		End case 
		Case of 
			: ([Bogen:6]FormNam:8="gen_OffenText")
				[Bogen:6]AvgText:5:="Keine Angabe ... 9"
				[Bogen:6]Filter_Eingabe:9:="9"
				
				  //-- Code obsolet / Ersetzt durch gen_Multi / Nur für Rückwärtskompatibilität / 08.05.2007
			: ([Bogen:6]FormNam:8="gen_WoMo@")
				[Bogen:6]AvgText:5:="Bei 'Keine Angabe':"+Char:C90(13)+"Wochen = 9"
			: ([Bogen:6]FormNam:8="gen_MoJa")
				[Bogen:6]AvgText:5:="Bei 'Keine Angabe':"+Char:C90(13)+"Monate = 99"
				  // -- Ende Code obslolet / Ersetzt durch gen_Multi / 08.05.2007
		End case 
		
		If ([Bogen:6]FormNam:8="gen_Multi")
			OBJECT SET VISIBLE:C603(*;[Bogen:6]Halboffen:26;True:C214)
			OBJECT SET VISIBLE:C603(*;"THalboffen";True:C214)
		Else 
			OBJECT SET VISIBLE:C603(*;[Bogen:6]Halboffen:26;False:C215)
			OBJECT SET VISIBLE:C603(*;"THalboffen";False:C215)
		End if 
		p_BogenAvgFormatSetzen 
		p_BogenEingabeFelderSichtbar 
End case 
