Case of 
	: (Form event code:C388=On Display Detail:K2:22)
		If ([LogDaten:1]PCNutzer:6#"")
			$vlTimeDelay:=((Current date:C33-[LogDaten:1]AktDatum:12)*86400)+(Current time:C178-[LogDaten:1]AktZeit:13+0)
			Case of 
				: ($vlTimeDelay>300)
					$Farbe:=3
				: ($vlTimeDelay>120)
					$Farbe:=9
				Else 
					$Farbe:=15
			End case 
			_O_OBJECT SET COLOR:C271([LogDaten:1]DBNutzer:1;-$Farbe)
			_O_OBJECT SET COLOR:C271([LogDaten:1]PCNutzer:6;-$Farbe)
			_O_OBJECT SET COLOR:C271([LogDaten:1]Station:7;-$Farbe)
			_O_OBJECT SET COLOR:C271([LogDaten:1]Start Datum:2;-$Farbe)
			_O_OBJECT SET COLOR:C271([LogDaten:1]Start Zeit:3;-$Farbe)
			_O_OBJECT SET COLOR:C271([LogDaten:1]AktDatum:12;-$Farbe)
			_O_OBJECT SET COLOR:C271([LogDaten:1]AktZeit:13;-$Farbe)
			_O_OBJECT SET COLOR:C271([LogDaten:1]Modul:8;-$Farbe)
			_O_OBJECT SET COLOR:C271([LogDaten:1]Umfrage:11;-$Farbe)
			_O_OBJECT SET COLOR:C271([LogDaten:1]FbNr:9;-$Farbe)
			_O_OBJECT SET COLOR:C271([LogDaten:1]Frage:10;-$Farbe)
		End if 
End case 