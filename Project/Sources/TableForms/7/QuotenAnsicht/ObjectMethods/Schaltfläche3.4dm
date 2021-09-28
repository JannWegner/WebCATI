$vbEnde:=False:C215
C_BLOB:C604($vxArrayIDs)

Repeat 
	$viTopfNr:=Num:C11(Request:C163("Welche Topfnummer?"))
	If (OK=0)
		$vbEnde:=True:C214
	Else 
		If ($viTopfNr<=Size of array:C274(aiQuFrei))
			aiQuFrei{$viTopfNr}:=Num:C11((aiQuFrei{$viTopfNr}=0))
			  //Matrix neu aufbauen
			p_QuotenMatrixErzeugen 
			REDRAW:C174(vtQuotenMatrix)
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
	$vtFreigabeString:=""
	For ($lauf;1;Size of array:C274(aiQuSoll))
		$vtFreigabeString:=$vtFreigabeString+String:C10(aiQuFrei{$lauf})
	End for 
	UNLOAD RECORD:C212([Quoten:7])
	READ WRITE:C146([Quoten:7])
	LOAD RECORD:C52([Quoten:7])
	If (Locked:C147([Quoten:7]))
		LOCKED BY:C353([Quoten:7];$x1;$x2;$x3;$x4)
		ALERT:C41("[Quoten] gesperrt durch "+$x2+"/"+$x3+Char:C90(13)+"Nocheinmal speichern!")
	Else 
		[Quoten:7]FreigabeString:11:=$vtFreigabeString
		[Quoten:7]FreigabeVersion:12:=[Quoten:7]FreigabeVersion:12+1
		SAVE RECORD:C53([Quoten:7])
		READ ONLY:C145([Quoten:7])
		
		MESSAGE:C88("Freie Datensätze werden zusammengestellt ...")
		CREATE EMPTY SET:C140([TelefonNummer:4];"$FreieAdressen")
		QUERY:C277([TelefonNummer:4];[TelefonNummer:4]Umfrage:30=vUmfrage)
		CREATE SET:C116([TelefonNummer:4];"$AlleAdressen")
		For ($lauf;1;Size of array:C274(aiQuFrei))
			If (aiQuFrei{$lauf}=1)
				USE SET:C118("$AlleAdressen")
				QUERY SELECTION:C341([TelefonNummer:4];[TelefonNummer:4]QuotenTopf:46=$lauf)
				CREATE SET:C116([TelefonNummer:4];"$NeueAdressen")
				UNION:C120("$FreieAdressen";"$NeueAdressen";"$FreieAdressen")
			End if 
		End for 
		USE SET:C118("$FreieAdressen")
		
		LONGINT ARRAY FROM SELECTION:C647([TelefonNummer:4];$alFreieAdressIDs)
		VARIABLE TO BLOB:C532($alFreieAdressIDs;$vxArrayIDs)
		
		READ WRITE:C146([Variablen:5])
		QUERY:C277([Variablen:5];[Variablen:5]Umfrage:3=vUmfrage)
		LOAD RECORD:C52([Variablen:5])
		If (Locked:C147([Variablen:5]))
			LOCKED BY:C353([Variablen:5];$x1;$x2;$x3;$x4)
			ALERT:C41("[Variablen] gesperrt durch "+$x2+"/"+$x3+Char:C90(13)+"Nocheinmal speichern!")
		Else 
			[Variablen:5]QuotenIDBlob:34:=$vxArrayIDs
			[Variablen:5]QuotenVersion:33:=[Quoten:7]FreigabeVersion:12
			SAVE RECORD:C53([Variablen:5])
			READ ONLY:C145([Variablen:5])
		End if 
	End if 
	
End if 
CLEAR SEMAPHORE:C144("QuoteAendern")

  //Freigaben einlesen
p_QuotenFreigabenLesen 

  //Matrix neu aufbauen
p_QuotenMatrixErzeugen 
