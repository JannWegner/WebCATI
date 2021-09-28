//%attributes = {}
  //Schreibt die Werte aus $2 nach Codespalte $3 im Textfeld $1
  //Codespalte ist schon in Nummer umgerechnet!

$Ziel:=$1
$vAntwort:=$2
$viDG_Spalte:=$3

  //Spalten berechnen
$HighByte:=$viDG_Spalte*2
$LowByte:=$HighByte-1


If ($HighByte>=32000)
	ALERT:C41("Spalte "+String:C10($viDG_Spalte)+" ergibt Position "+String:C10($HighByte)+" => zu groß!")
Else 
	
	$vAntwort:=$vAntwort+","
	$BinaerWert:=0x0000
	
	While (Length:C16($vAntwort)>1)
		$KommaPos:=Position:C15(",";$vAntwort)
		$vsSchreibwert:=Substring:C12($vAntwort;1;$KommaPos-1)
		$loc:=Num2BinWert ($vsSchreibwert)
		$BinaerWert:=$BinaerWert ?+ $loc
		$vAntwort:=Substring:C12($vAntwort;$KommaPos+1)
	End while 
	
	$HighByteWert:=$BinaerWert & 0x00FF
	$LowByteWert:=$BinaerWert >> 8
	
	$Ziel->[[$LowByte]]:=Char:C90($LowByteWert)
	$Ziel->[[$HighByte]]:=Char:C90($HighByteWert)
	
	  //ALERT("Ges: "+Binaer2Bitmuster ($BinaerWert)+"  "+String($BinaerWert)+Char(13)+"LB:  "+Binaer2Bitmuster ($LowByteWert)+"  "+String($LowByteWert)+Char(13)+"HB:  "+Binaer2Bitmuster ($HighByteWert)+"  "+String($HighByteWert))
	
End if 