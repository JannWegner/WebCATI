//%attributes = {}
// web_InfofeldBauen
// Jann Wegner
// 20210930

// Bastelt das Infofeld mit Befragten-Infos
// char(13) werden in "<br>" konvertiert
// muss dann mit 4DHTML aufgerufen werden (Nicht 4DTEXT)

var $1; $e_TelNr; $e_Variable : Object
var $0; $2; $vt_InfoFeld : Text
var $vi_Lauf : Integer

$e_TelNr:=New object:C1471()
$e_TelNr:=$1
$e_Variable:=New object:C1471()
$e_Variable:=ds:C1482.Variablen.query("PKID = :1"; $2).first()

$vt_InfoFeld:=$e_Variable.InfoFeld

For ($vi_Lauf; 1; 16)
	$vt_InfoFeld:=Replace string:C233($vt_InfoFeld; "#f"+String:C10($vi_Lauf; "00"); "<b>"+$e_TelNr["AdrFeld"+String:C10($vi_Lauf; "00")]+"</b>")
End for 

//Einsetzen der Telefonnummer
$vt_InfoFeld:=Replace string:C233($vt_InfoFeld; "#TelNr"; "<b>"+$e_TelNr.Telefon1+"</b>")

//Einsetzen der Fassung
$vt_InfoFeld:=Replace string:C233($vt_InfoFeld; "#Fassung"; "<b>"+$e_TelNr.Fassung+"</b>")

//Einsetzen des Quotentopfs
$vt_InfoFeld:=Replace string:C233($vt_InfoFeld; "#Topf"; "<b>"+String:C10($e_TelNr.QuotenTopf)+"</b>")

//Einsetzen Eingetragen Ja/Nein
$vt_InfoFeld:=Replace string:C233($vt_InfoFeld; "#TB"; "<b>"+Choose:C955($e_TelNr.EingetragenTB; "Ja"; "Nein")+"</b>")

$vt_InfoFeld:=Replace string:C233($vt_InfoFeld; Char:C90(13); "<br>")
$0:=$vt_InfoFeld

