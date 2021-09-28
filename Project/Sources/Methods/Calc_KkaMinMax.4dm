//%attributes = {}
  //Gesamter Filter als Eingabe
$Eingabe:=Replace string:C233($1;" ";"")

If (Position:C15("F=";[Bogen:6]Filter_Eingabe:9)#0)
	$Eingabe:=Substring:C12($Eingabe;1;Position:C15("F=";$Eingabe)-1)
End if 


$PosMinus:=Position:C15("-";$Eingabe)
$PosSemi:=Position:C15(";";$Eingabe)
If ($PosSemi=0)
	$PosSemi:=Length:C16($Eingabe)+1
End if 

$vMin:=Substring:C12($Eingabe;1;$PosMinus-1)
$vMax:=Substring:C12($Eingabe;$PosMinus+1;$PosSemi-$PosMinus-1)
$vKKA:=Substring:C12($Eingabe;$PosSemi+1)

$0:=$vMin+"**"+$vMax+"**"+$vKKA