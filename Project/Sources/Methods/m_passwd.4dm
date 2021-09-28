//%attributes = {"publishedWeb":true}
CONFIRM:C162("Wollen Sie Ihr Password ändern?")
If (OK=1)
	ALERT:C41("Geben Sie erneut Ihr altes Password ein!")
	CHANGE CURRENT USER:C289
	If (OK=1)
		$pw1:=Request:C163("Neues Password: (mind. 6 Zeichen)")
		If ((OK=1) & ($pw1#"") & (Length:C16($pw1)>5))
			$pw2:=Request:C163("Wiederholen Sie Ihr neues Password:")
			If ((OK=1) & ($pw1=$pw2))
				CHANGE PASSWORD:C186($pw2)
				ALERT:C41("Die Datenbank wird nun beendet -"+Char:C90(13)+"Melden Sie sich bitte unter mit neuen Kennwort an!")
				QUIT 4D:C291
			End if 
		Else 
			ALERT:C41("Eingabe nicht identisch bzw. zu kurz!")
		End if 
	End if 
End if 
