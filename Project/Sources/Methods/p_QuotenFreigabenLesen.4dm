//%attributes = {}
  //Liest die QuotenFreigaben in ein Array ein
  //1  = Topf ist frei
  //0 = Topf ist gesperrt

  //Freigaben auslesen
If (Length:C16([Quoten:7]FreigabeString:11)=Size of array:C274(aiQuFrei))
	For ($lauf;1;Size of array:C274(aiQuFrei))
		aiQuFrei{$lauf}:=Num:C11([Quoten:7]FreigabeString:11[[$lauf]])
	End for 
Else 
	ALERT:C41("p_QuotenArraysErzeugen:"+Char:C90(13)+"Länge von [Quoten]FreigabeString stimmt nicht  -> Freigaben nicht bearbeitet!")
End if 
