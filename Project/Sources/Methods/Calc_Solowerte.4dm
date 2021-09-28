//%attributes = {}
$Eingabe:=$1
$KPos:=Position:C15("K=";$Eingabe)
If ($KPos=0)
	$KPos:=Length:C16($Eingabe)+2
End if 

$0:=Substring:C12($Eingabe;Position:C15("S=";$Eingabe)+2;$KPos-Position:C15("S=";$Eingabe)-3)