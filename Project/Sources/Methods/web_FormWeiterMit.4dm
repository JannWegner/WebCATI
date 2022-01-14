//%attributes = {}
/*
web_FormWeiterMit
Jann Wegner
20220113

Checkt die Eingaben in folgenden Formularen:
Telefon

$1: Name des aufrufenden Formulars
$2-x: Formularspezifische Parameter
*/

var $vt_Formular : Text
var $e_AktTelefonNummer : Object

$vt_Formular:=$1

$e_AktTelefonNummer:=ds:C1482.TelefonNummer.query("PKID = :1"; Session:C1714.storage.Info.AdrPKID)[0]

Case of 
	: ($vt_Formular="Telefon")
		var $vt_Antwort : Text
		$vt_Antwort:=$2
		Case of 
			: ($vt_Antwort="1")  // Besetzt
				$e_AktTelefonNummer.StatusErklärung:="Besetzt"
				web_SessionUpdate(New collection:C1472("LetzteURL"; "Später"))
				$e_AktTelefonNummer.Historie:=String:C10(Current date:C33)+"/"+String:C10(Current time:C178)+" * "+Current user:C182+" * Wiedervorlage/Besetzt"+Char:C90(13)+$e_AktTelefonNummer.Historie
			: ($vt_Antwort="2")  // Keine Abnahme
				$e_AktTelefonNummer.StatusErklärung:="Keine Abnahme"
				web_SessionUpdate(New collection:C1472("LetzteURL"; "Später"))
				$e_AktTelefonNummer.Historie:=String:C10(Current date:C33)+"/"+String:C10(Current time:C178)+" * "+Current user:C182+" * Wiedervorlage/Keine Abnahme"+Char:C90(13)+$e_AktTelefonNummer.Historie
			: ($vt_Antwort="3")  // Kein Anschluss
				$e_AktTelefonNummer.Status:="Abbruch"
				$e_AktTelefonNummer.StatusErklärung:="Kein Anschluß"
				web_SessionUpdate(New collection:C1472("LetzteURL"; "ENDE"))
				$e_AktTelefonNummer.Historie:=String:C10(Current date:C33)+"/"+String:C10(Current time:C178)+" * "+Current user:C182+" * Abbruch/Kein Anschluß"+Char:C90(13)+$e_AktTelefonNummer.Historie
			: ($vt_Antwort="4")  // AB
				$e_AktTelefonNummer.StatusErklärung:="Anrufbeantworter"
				web_SessionUpdate(New collection:C1472("LetzteURL"; "Später"))
				$e_AktTelefonNummer.Historie:=String:C10(Current date:C33)+"/"+String:C10(Current time:C178)+" * "+Current user:C182+" * Wiedervorlage/Anrufbeantworter"+Char:C90(13)+$e_AktTelefonNummer.Historie
			: ($vt_Antwort="5")  // Fax
				$e_AktTelefonNummer.Status:="Abbruch"
				$e_AktTelefonNummer.StatusErklärung:="Fax/Modem"
				web_SessionUpdate(New collection:C1472("LetzteURL"; "ENDE"))
				$e_AktTelefonNummer.Historie:=String:C10(Current date:C33)+"/"+String:C10(Current time:C178)+" * "+Current user:C182+" * Abbruch/Fax/Modem"+Char:C90(13)+$e_AktTelefonNummer.Historie
			: ($vt_Antwort="6")  // OK
				web_SessionUpdate(New collection:C1472("LetzteURL"; "Int_Bereit"))
			: ($vt_Antwort="7")  // Problem
				$e_AktTelefonNummer.Status:="Abbruch"
				$e_AktTelefonNummer.StatusErklärung:="Techn. Probleme"
				web_SessionUpdate(New collection:C1472("LetzteURL"; "ENDE"))
				$e_AktTelefonNummer.Historie:=String:C10(Current date:C33)+"/"+String:C10(Current time:C178)+" * "+Current user:C182+" * Abbruch/Techn. Probleme"+Char:C90(13)+$e_AktTelefonNummer.Historie
			: ($vt_Antwort="8")  // Pause
				$e_AktTelefonNummer.StatusErklärung:="Pause besetzt"
				web_SessionUpdate(New collection:C1472("LetzteURL"; "Später"))
				$e_AktTelefonNummer.Historie:=String:C10(Current date:C33)+"/"+String:C10(Current time:C178)+" * "+Current user:C182+" * Wiedervorlage/Pause besetzt"+Char:C90(13)+$e_AktTelefonNummer.Historie
			: ($vt_Antwort="9")  // Max
				web_SessionUpdate(New collection:C1472("LetzteURL"; "Ausfall"))
		End case 
		
		$e_AktTelefonNummer.save()
End case   // Formularwahl