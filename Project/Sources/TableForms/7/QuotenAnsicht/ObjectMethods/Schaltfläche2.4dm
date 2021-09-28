If (User in group:C338(Current user:C182;"UmfrAVO"))
	$vbEnde:=False:C215
	Repeat 
		$viTopfNr:=Num:C11(Request:C163("Welche Topfnummer?"))
		If (OK=0)
			$vbEnde:=True:C214
		Else 
			If ($viTopfNr<=Size of array:C274(aiQuSoll))
				$viSoll:=Num:C11(Request:C163("Soll für Topf-Nummer "+String:C10($viTopfNr)+"?"))
				If (OK=1)
					aiQuSoll{$viTopfNr}:=$viSoll
				End if 
			Else 
				ALERT:C41("bSollSetzen"+Char:C90(13)+"Topf-Nummer "+String:C10($viTopfNr)+" nicht vorhanden!")
			End if 
		End if 
	Until ($vbEnde)
	
	CONFIRM:C162("Bisherige Änderungen dauerhaft schreiben?";"Änderungen schreiben";"Abbrechen")
	While (Semaphore:C143("QuoteAendern"))
		MESSAGE:C88("Bitte kurz warten")
		For ($lauf;1;5000)
		End for 
	End while 
	If (OK=1)
		$vtSollString:=""
		For ($lauf;1;Size of array:C274(aiQuSoll))
			$vtSollString:=$vtSollString+String:C10(aiQuSoll{$lauf})+","
		End for 
		UNLOAD RECORD:C212([Quoten:7])
		READ WRITE:C146([Quoten:7])
		LOAD RECORD:C52([Quoten:7])
		[Quoten:7]SollString:10:=$vtSollString
		SAVE RECORD:C53([Quoten:7])
		READ ONLY:C145([Quoten:7])
	End if 
	CLEAR SEMAPHORE:C144("QuoteAendern")
	
	  //Sollzahlen auslesen
	p_QuotenSollZahlenLesen 
	
	  //Matrix neu aufbauen
	p_QuotenMatrixErzeugen 
	
Else 
	ALERT:C41("Sie haben nicht die nötigen Rechte für diese Funktion")
End if 