//%attributes = {}
  //Zieht die Antwort zu einer bestimmten Frage aus AntASCII raus

$lauf:=1
$BrauchIch:=False:C215
$AnzahlSpezialBogen:=Size of array:C274(asSpezialBogen)


While (($lauf<=$AnzahlSpezialBogen) & (Not:C34($BrauchIch)))
	If (Length:C16(LiA (asSpezialBogen{$lauf}))>2)
		$BrauchIch:=True:C214
	End if 
	
	  //$SuchIDStartPos:=Position(asSpezialBogen{$lauf};[TelefonNummer]AntwASCII)
	  //If ($SuchIDStartPos#0)
	  //$AntwortStartPos:=$SuchIDStartPos+Length(asSpezialBogen{$lauf})+1
	  //$RestText:=Substring([TelefonNummer]AntwASCII;$AntwortStartPos)
	  //$TrennerPos:=Position("|";$RestText)
	  //If ($TrennerPos>2)
	  //$BrauchIch:=True
	  //End if 
	  //End if 
	
	$lauf:=$lauf+1
End while 
$0:=$BrauchIch