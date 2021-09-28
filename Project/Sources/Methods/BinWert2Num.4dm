//%attributes = {}
$Restwert:=$1
If ($Restwert>0)
	$Antwort:=""
	$DummyString:="9876543210XY"
	For ($lauf;11;0;-1)
		If ($Restwert>=(2^$lauf))
			$Antwort:=$Antwort+","+$DummyString[[($lauf+1)]]
			$Restwert:=$Restwert-(2^$lauf)
		End if 
	End for 
	  //Ggf. Führendes Komma eleminieren
	$0:=Substring:C12($Antwort;2)
Else 
	$0:=""
End if 