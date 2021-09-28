//%attributes = {}
  //Rechnet einen ZeitSTRING im format "hh:mm:ss" in Sekunden um
  //$1 muß Format STRING sein!

C_TEXT:C284($vs_ZeitString;$1)

$vs_ZeitString:=$1

$0:=(Num:C11(Substring:C12($vs_ZeitString;1;2))*3600)+(Num:C11(Substring:C12($vs_ZeitString;4;2))*60)+Num:C11(Substring:C12($vs_ZeitString;7;2))