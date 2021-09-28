//%attributes = {}
  //Saeubert eine Telefonnummer von Sonderzeichen und bringt Sie auf Format
$vsNummerOrg:=$1
$vsNummerSauber:=""
For ($lauf;1;Length:C16($vsNummerOrg))
	If (($vsNummerOrg[[$lauf]]>="0") & ($vsNummerOrg[[$lauf]]<="9"))
		$vsNummerSauber:=$vsNummerSauber+$vsNummerOrg[[$lauf]]
	End if 
End for 
$0:=$vsNummerSauber