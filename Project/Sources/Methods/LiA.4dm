//%attributes = {}
  //liest ein bestimmte Antwort aus [TelefonNummer]AntwASCII aus 
  //$1 Feld

$vsFeld:=$1
$0:=""
$vsAntwort:=""

$viFeldNamePos:=Position:C15(("|"+$vsFeld+"|");"|"+[TelefonNummer:4]AntwASCII:41)
If ($viFeldNamePos#0)
	  //Das gesuchte Feld wurde im Datensatz  benutzt => schon mal gut
	$viAntwortStartPos:=$viFeldNamePos+Length:C16($vsFeld)+2
	$vsAntwort:=Substring:C12("|"+[TelefonNummer:4]AntwASCII:41;$viAntwortStartPos)
	$vsAntwort:=Substring:C12($vsAntwort;1;Position:C15("|";$vsAntwort)-1)
End if 

$0:=$vsAntwort