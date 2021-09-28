//%attributes = {}
/*
p_WebCheckInput
Jann Wegner
20210429

Prüft, ob die Eingabe in ein Webformular plausibel war

$1: String mit Prüftyp
$2: String mit der Eingabe

$0: True/False
*/

C_OBJECT:C1216($0)
C_TEXT:C284($1;2;$vt_Typ;$vt_EingabeVar;$vt_EingabeWert)
C_LONGINT:C283($vl_VarPos)

$vt_Typ:=$1
$vt_EingabeVar:=$2
$vt_EingabeWert:=""

$0:=New object:C1471("Erfolg";False:C215;"Eingabetext";"")

  // Prüfen, ob die Eingabe einen Wert hat
$vl_VarPos:=Find in array:C230(at_FormVarNames;$vt_EingabeVar)
If ($vl_VarPos#-1)
	$vt_EingabeWert:=at_FormVarValues{$vl_VarPos}
End if 

Case of 
	: ($vt_Typ="RadioSingle")
		$0.Erfolg:=($vt_EingabeWert#"")
		$0.Eingabetext:=$vt_EingabeWert
End case 

