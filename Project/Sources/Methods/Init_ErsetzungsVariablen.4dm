//%attributes = {}
  //Erzeugt ein Array mit Variablen für die Ersetzung von Text in Fragen/Antworten

C_TEXT:C284($vt_VariablenQuelle)

If ([Variablen:5]VariablenDefs:35#"")
	If ([TelefonNummer:4]Variablenspeicher:49="")
		$vt_VariablenQuelle:=[Variablen:5]VariablenDefs:35
	Else 
		  //$vt_VariablenQuelle:=[Variablen]VariablenDefs
		$vt_VariablenQuelle:=[TelefonNummer:4]Variablenspeicher:49
	End if 
	$KommaPos:=Position:C15(",";$vt_VariablenQuelle)
	$Anzahl:=Num:C11(Substring:C12($vt_VariablenQuelle;1;$KommaPos-1))
	$RestText:=Substring:C12($vt_VariablenQuelle;$KommaPos+1)
	ARRAY TEXT:C222(atVar;$Anzahl)
	$lauf:=0
	
	While (Position:C15(",";$RestText)#0)
		$lauf:=$lauf+1
		If ($lauf>Size of array:C274(atVar))
			ALERT:C41("Init_Ersetzungsvariablen:"+Char:C90(13)+String:C10($lauf)+" Variablendefinition nicht konsistent!")
			$RestText:=""
		Else 
			$KommaPos:=Position:C15(",";$RestText)
			atVar{$lauf}:=Substring:C12($RestText;1;$KommaPos-1)
			$RestText:=Substring:C12($RestText;$KommaPos+1)
		End if 
	End while 
End if 
