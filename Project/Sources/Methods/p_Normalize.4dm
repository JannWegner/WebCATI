//%attributes = {}
  // p_Normalize
  // Jann Wegner
  // 20210419

  // Entfernt unerwünsche Zeichen aus Zeichenketten

C_TEXT:C284($0;$1;$vt_TestText;$vt_AusgabeText;$AktZeichen)
C_LONGINT:C283($vl_Lauf)

$vt_TestText:=$1
$vt_AusgabeText:=""

For ($vl_Lauf;1;Length:C16($vt_TestText))
	$AktZeichen:=$vt_TestText[[$vl_Lauf]]
	$AktZeichen:=Choose:C955(($vt_AusgabeText="") & ($AktZeichen=" ");"";$AktZeichen)
	$vt_AusgabeText:=$vt_AusgabeText+Choose:C955(Position:C15($AktZeichen;<>vt_KontrollText)=0;"";$AktZeichen)
End for 

$0:=$vt_AusgabeText