//%attributes = {}
  //Liest die Quoten-Sollzahlen in ein Array ein

$vtRestText:=[Quoten:7]SollString:10
For ($lauf;1;Size of array:C274(aiQuSoll))
	$viKommaPos:=Position:C15(",";$vtRestText)
	aiQuSoll{$lauf}:=Num:C11(Substring:C12($vtRestText;1;$viKommaPos-1))
	$vtRestText:=Substring:C12($vtRestText;$viKommaPos+1)
End for 
