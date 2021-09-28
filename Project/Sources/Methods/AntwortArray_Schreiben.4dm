//%attributes = {}
C_LONGINT:C283($NeueLaenge)
[TelefonNummer:4]AntwASCII:41:=""
For ($lauf;1;Size of array:C274(asBogenID))
	$NeueLaenge:=Length:C16([TelefonNummer:4]AntwASCII:41+asBogenID{$lauf}+"|"+atAntworten{$lauf}+"|")
	If ($NeueLaenge>31900)
		[TelefonNummer:4]AntwUeberlauf:40:=[TelefonNummer:4]AntwASCII:41
		[TelefonNummer:4]AntwASCII:41:=""
		ALERT:C41("AntwortArray_Schreiben:"+Char:C90(13)+"ACHTUNG ÜBERLAUF!  -  AdrNr "+String:C10([TelefonNummer:4]AdrFBNr:20)+" an Supervision/EDV melden!  - Es droht DATENVERLUST!")
	End if 
	
	  //Nur schreiben, wenn tatsächlich ne Antwort drin steht
	If (Length:C16(atAntworten{$lauf})>0)
		[TelefonNummer:4]AntwASCII:41:=[TelefonNummer:4]AntwASCII:41+asBogenID{$lauf}+"|"+atAntworten{$lauf}+"|"
	End if 
End for 

  //Weg sichern
[TelefonNummer:4]Wegspeicher:48:=vt_AktuellerWeg

  //Variablen sichern
If ([Variablen:5]VariablenDefs:35#"")
	If (Size of array:C274(atVar)#0)
		[TelefonNummer:4]Variablenspeicher:49:=String:C10(Size of array:C274(atVar))+","
		For ($lauf;1;Size of array:C274(atVar))
			[TelefonNummer:4]Variablenspeicher:49:=[TelefonNummer:4]Variablenspeicher:49+Replace string:C233(atVar{$lauf};",";"/")+","
		End for 
	End if 
End if 

sichere_DS (Table:C252(->[TelefonNummer:4]);DEBUG)
