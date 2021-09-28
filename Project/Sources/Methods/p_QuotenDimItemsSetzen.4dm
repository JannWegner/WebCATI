//%attributes = {}
  //Besetzt ein Array mit den Elementen aus [Quoten]TextDimX
  //$1 = Zeiger auf das ZielArray asQuItemDimX
  //$2 =Inhalt des passende Feldes [Quoten]TextDimX

$ptArray:=$1
$TextDim:=$2

For ($lauf;1;Size of array:C274($ptArray->))
	$GruppenTrennerPos:=Position:C15("|";$TextDim)
	$ptArray->{$lauf}:=Substring:C12($TextDim;1;$GruppenTrennerPos-1)
	$TextDim:=Substring:C12($TextDim;$GruppenTrennerPos+1)
End for 