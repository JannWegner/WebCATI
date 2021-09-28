//%attributes = {}
  //Liest aus einer Codespalte $1 den Wert und gibt die Antwortkombination in $0 zurueck
$vsDG_Spalte:=$1

  //Spalten berechnen
$HighByte:=sp2off ($vsDG_Spalte)*2
$LowByte:=$HighByte-1

$HighByteWert:=Character code:C91([TelefonNummer:4]BinaerText:32[[$HighByte]])
$LowByteWert:=Character code:C91([TelefonNummer:4]BinaerText:32[[$LowByte]])

$BinaerWert:=($LowByteWert << 8)+$HighByteWert

  //ALERT("Ges: "+Binaer2Bitmuster ($BinaerWert)+"  "+String($BinaerWert)+Char(13)+"LB:  "+Binaer2Bitmuster ($LowByteWert)+"  "+String($LowByteWert)+Char(13)+"HB:  "+Binaer2Bitmuster ($HighByteWert)+"  "+String($HighByteWert))

$0:=BinWert2Num ($BinaerWert)