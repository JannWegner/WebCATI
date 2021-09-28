Case of 
	: (Form event code:C388=On Load:K2:1)
		C_TEXT:C284(vText;$DummyText;$Antwort)
		vText:=""
		$Trennlinie:=("-"*60)+Char:C90(13)
		$Tablaenge:=20
		$DummyText:=Replace string:C233([TelefonNummer:4]AntwASCII:41;Char:C90(13);Char:C90(13)+(" "*($Tablaenge-1)))
		While (Position:C15("|";$DummyText)#0)
			$TrennerPos:=Position:C15("|";$DummyText)
			$ID:=Substring:C12($DummyText;1;$TrennerPos-1)+(" "*($Tablaenge-$TrennerPos))
			$DummyText:=Substring:C12($DummyText;$TrennerPos+1)
			$TrennerPos:=Position:C15("|";$DummyText)
			$Antwort:=Substring:C12($DummyText;1;$TrennerPos-1)
			$DummyText:=Substring:C12($DummyText;$TrennerPos+1)
			vText:=vText+$ID+$Antwort+Char:C90(13)+$Trennlinie
		End while 
		
		FORM SET INPUT:C55([TelefonNummer:4];"Eingabe_Reduziert")
End case 