//%attributes = {}
  //Löscht alle Elemente des Arrays $1 (Zeiger) (entweder auf 0 oder "")
  //Typ in $2
$ptArray:=$1
$vsTyp:=$2

Case of 
	: ($vsTyp="n")
		For ($lauf;1;Size of array:C274($ptArray->))
			$ptArray->{$lauf}:=0
		End for 
	: ($vsTyp="s")
		For ($lauf;1;Size of array:C274($ptArray->))
			$ptArray->{$lauf}:=""
		End for 
	Else 
		ALERT:C41("p_QuotenArrayLeeren:"+Char:C90(13)+"Typ unbekannt!")
End case 