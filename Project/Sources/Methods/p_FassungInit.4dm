//%attributes = {}
  //Fassung setzen
ARRAY TEXT:C222(atFassung;0)
$vsRestText:=[Variablen:5]Fasssung:24
While (Length:C16($vsRestText)>0)
	$viFassTrenner:=Position:C15("|";$vsRestText)
	INSERT IN ARRAY:C227(atFassung;1;1)
	atFassung{1}:=Substring:C12($vsRestText;1;$viFassTrenner-1)
	$vsRestText:=Substring:C12($vsRestText;$viFassTrenner+1)
End while 

