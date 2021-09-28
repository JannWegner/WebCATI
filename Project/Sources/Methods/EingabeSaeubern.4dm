//%attributes = {}
  //$1 = Eingabe

$Eingabe:=$1

$Eingabe:=Replace string:C233($Eingabe;"_";"")
$Eingabe:=Replace string:C233($Eingabe;"^";"")

  //Doppelkommas entfernen
$Eingabe:=Replace string:C233(Replace string:C233(Replace string:C233($Eingabe;",,";",");",,";",");",,";",")

If ($Eingabe#"")
	  //Führendes und abschließendes Komma entfernen
	While ($Eingabe[[1]]=",")
		$Eingabe:=Substring:C12($Eingabe;2)
	End while 
	While ($Eingabe[[Length:C16($Eingabe)]]=",")
		$Eingabe:=Substring:C12($Eingabe;1;Length:C16($Eingabe)-1)
	End while 
	
	  // "|" ist Trenner in AntwortenASCII => durch "*" ersetzen
	$Eingabe:=Replace string:C233($Eingabe;"|";"*")
End if 

$0:=$Eingabe