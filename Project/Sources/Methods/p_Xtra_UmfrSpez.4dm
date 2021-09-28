//%attributes = {}
  //Setzt was Umfragespezifisches

Case of 
	: (vUmfrage="9611@")
		  //Prozente bei Fragen 36 ergänzen
		If (id2feld ("vi36")#"00")
			$0:=String:C10(100-Num:C11(id2feld ("vi36"));"000")
		Else 
			$0:="   "
		End if 
		
		
	: (vUmfrage="4289@")
		
		  //Geschlecht setzen
		If (id2feld ("vds01")="1")
			[TelefonNummer:4]AdrFeld10:21:="1"
		Else 
			[TelefonNummer:4]AdrFeld10:21:="2"
		End if 
		
		  //Alter setzen
		$viAlter:=Num:C11(id2feld ("vds02"))
		Case of 
			: ($viAlter=0)
				[TelefonNummer:4]AdrFeld11:27:="9"
			: ($viAlter<=29)
				[TelefonNummer:4]AdrFeld11:27:="1"
			: ($viAlter<=44)
				[TelefonNummer:4]AdrFeld11:27:="2"
			: ($viAlter<=59)
				[TelefonNummer:4]AdrFeld11:27:="3"
			Else 
				[TelefonNummer:4]AdrFeld11:27:="4"
		End case 
		
		  //Ab hier nur für gezogene Adressen
		If ([TelefonNummer:4]AdrFeld09:17="0")
			  //Frage 11a Land
			  //Test ob kkA
			If (id2feld ("vds11a")="00")
				  //Wert aus Adressen setzen
				var2feld ("vds11a";[TelefonNummer:4]AdrFeld12:28;"")
			End if 
			
			  //Land in Adressen setzen
			
			
			  //Nielsen setzen
			$viLand:=Num:C11(id2feld ("vds11a"))
			Case of 
				: ($viLand<=4)
					[TelefonNummer:4]AdrFeld15:43:="1"
				: ($viLand=5)
					[TelefonNummer:4]AdrFeld15:43:="2"
				: (($viLand=6) | ($viLand=7) | ($viLand=10))
					[TelefonNummer:4]AdrFeld15:43:="3"
				: ($viLand=8)
					[TelefonNummer:4]AdrFeld15:43:="4"
				: ($viLand=9)
					[TelefonNummer:4]AdrFeld15:43:="5"
				: (($viLand=11) | ($viLand=12))
					[TelefonNummer:4]AdrFeld15:43:="6"
				: (($viLand=13) | ($viLand=14) | ($viLand=16))
					[TelefonNummer:4]AdrFeld15:43:="7"
				: (($viLand=15) | ($viLand=17))
					[TelefonNummer:4]AdrFeld15:43:="8"
			End case 
			
			  //Frage 12b Einwohner
			  //Test ob kkA
			If (id2feld ("vds11b")="9")
				  //Wert aus Adressen OGK_8 setzen
				var2feld ("vds11b";[TelefonNummer:4]AdrFeld14:42;"")
			End if 
			
			  //OGK 8 setzen
			[TelefonNummer:4]AdrFeld14:42:=id2feld ("vds11b")
			
			  //OGK 5 setzen
			$viOGK:=Num:C11(id2feld ("vds11b"))
			Case of 
				: ($viOGK<=2)
					[TelefonNummer:4]AdrFeld13:31:="1"
				: ($viOGK<=4)
					[TelefonNummer:4]AdrFeld13:31:="2"
				: ($viOGK<=6)
					[TelefonNummer:4]AdrFeld13:31:="3"
				: ($viOGK=7)
					[TelefonNummer:4]AdrFeld13:31:="4"
				: ($viOGK=8)
					[TelefonNummer:4]AdrFeld13:31:="5"
			End case 
		Else 
			var2feld ("vds11a";[TelefonNummer:4]AdrFeld12:28;"")
			var2feld ("vds11b";[TelefonNummer:4]AdrFeld14:42;"")
		End if 
		
		
End case 
p_QuotenArraysErzeugen 
p_QuotenSuchArrayBauen 
p_QuotenToepfeInAdrSetzen 
