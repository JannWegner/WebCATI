//%attributes = {}
// web_WebTime2Time
// Jann Wegner
// 20220119

// Prüft das Zeitformat aus einem Eingabeformular und macht eine 4D-Zeit daraus

var $1; $vt_Zeit : Text
var $0; $vz_Zeit : Time
var $vb_ZeitOK : Boolean

$vt_Zeit:=$1
$vb_ZeitOK:=True:C214

$vb_ZeitOK:=(Num:C11(Substring:C12($vt_Zeit; 1; 2))<24)

$0:=Choose:C955($vb_ZeitOK; Time:C179($vt_Zeit); Time:C179("99:99"))
