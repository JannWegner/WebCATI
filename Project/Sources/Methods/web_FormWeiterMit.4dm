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

var $vt_Formular : Text  // Das Formular, dessen Eingabe ausgewertet wird

var $vl_NummerPos; $vl_APPos; $vl_NeuKommTextPos : Integer

$vt_Formular:=$1

e_AktTelefonNummer:=ds:C1482.TelefonNummer.query("PKID = :1"; Session:C1714.storage.Info.AdrPKID)[0]

Case of 
	: ($vt_Formular="Telefon")
		var $vt_Antwort : Text
		$vt_Antwort:=$2
		$vl_NeuKommTextPos:=$3
		
		Case of 
			: ($vt_Antwort="1")  // Besetzt
				e_AktTelefonNummer.StatusErklärung:="Besetzt"
				web_SessionUpdate(New collection:C1472("LetzteURL"; "Termin"))
				e_AktTelefonNummer.Historie:=String:C10(Current date:C33)+"/"+String:C10(Current time:C178)+" * "+Session:C1714.userName+" * Wiedervorlage/Besetzt"+Char:C90(13)+e_AktTelefonNummer.Historie
			: ($vt_Antwort="2")  // Keine Abnahme
				e_AktTelefonNummer.StatusErklärung:="Keine Abnahme"
				web_SessionUpdate(New collection:C1472("LetzteURL"; "Termin"))
				e_AktTelefonNummer.Historie:=String:C10(Current date:C33)+"/"+String:C10(Current time:C178)+" * "+Session:C1714.userName+" * Wiedervorlage/Keine Abnahme"+Char:C90(13)+e_AktTelefonNummer.Historie
			: ($vt_Antwort="3")  // Kein Anschluss
				e_AktTelefonNummer.StatusErklärung:="Kein Anschluß"
				web_SessionUpdate(New collection:C1472("LetzteURL"; "Abbruch"))
				e_AktTelefonNummer.Historie:=String:C10(Current date:C33)+"/"+String:C10(Current time:C178)+" * "+Session:C1714.userName+" * Abbruch/Kein Anschluß"+Char:C90(13)+e_AktTelefonNummer.Historie
			: ($vt_Antwort="4")  // AB
				e_AktTelefonNummer.StatusErklärung:="Anrufbeantworter"
				web_SessionUpdate(New collection:C1472("LetzteURL"; "Termin"))
				e_AktTelefonNummer.Historie:=String:C10(Current date:C33)+"/"+String:C10(Current time:C178)+" * "+Session:C1714.userName+" * Wiedervorlage/Anrufbeantworter"+Char:C90(13)+e_AktTelefonNummer.Historie
			: ($vt_Antwort="5")  // Fax
				e_AktTelefonNummer.StatusErklärung:="Fax/Modem"
				web_SessionUpdate(New collection:C1472("LetzteURL"; "Abbruch"))
				e_AktTelefonNummer.Historie:=String:C10(Current date:C33)+"/"+String:C10(Current time:C178)+" * "+Session:C1714.userName+" * Abbruch/Fax/Modem"+Char:C90(13)+e_AktTelefonNummer.Historie
			: ($vt_Antwort="6")  // OK
				web_SessionUpdate(New collection:C1472("LetzteURL"; "Abnahme"))
			: ($vt_Antwort="7")  // Problem
				e_AktTelefonNummer.StatusErklärung:="Techn. Probleme"
				web_SessionUpdate(New collection:C1472("LetzteURL"; "Abbruch"))
				e_AktTelefonNummer.Historie:=String:C10(Current date:C33)+"/"+String:C10(Current time:C178)+" * "+Session:C1714.userName+" * Abbruch/Techn. Probleme"+Char:C90(13)+e_AktTelefonNummer.Historie
			: ($vt_Antwort="8")  // Pause
				e_AktTelefonNummer.StatusErklärung:="Pause besetzt"
				web_SessionUpdate(New collection:C1472("LetzteURL"; "Termin"))
				e_AktTelefonNummer.Historie:=String:C10(Current date:C33)+"/"+String:C10(Current time:C178)+" * "+Session:C1714.userName+" * Wiedervorlage/Pause besetzt"+Char:C90(13)+e_AktTelefonNummer.Historie
			: ($vt_Antwort="9")  // Max
				e_AktTelefonNummer.StatusErklärung:="Zu viele Versuche"
				web_SessionUpdate(New collection:C1472("LetzteURL"; "Abbruch"))
		End case 
		e_AktTelefonNummer.Interviewer:=Session:C1714.userName
		
	: ($vt_Formular="Termin")
		var $vd_Datum : Date
		var $vz_Zeit : Time
		var $vb_Fix : Boolean
		
		$vd_Datum:=$2
		$vz_Zeit:=$3
		$vl_NummerPos:=$4
		$vl_APPos:=$5
		$vl_NeuKommTextPos:=$6
		$vb_Fix:=$7
		
		If ($vb_Fix)
			e_AktTelefonNummer.FixTermin:=True:C214
			e_AktTelefonNummer.Historie:=Replace string:C233(e_AktTelefonNummer.Historie; "Wiedervorlage/Termin"; "Wiedervorlage/FIX-Termin"; 1)
		End if 
		
		Case of 
			: ($vd_Datum=Date:C102("31.12.2999"))
				web_SessionUpdate(New collection:C1472("LetzteURL"; "Termin"; "InfoText"; "Bitte gültiges Datum nicht vor heute eingeben!"))
			: ($vz_Zeit=Time:C179("99:99"))
				web_SessionUpdate(New collection:C1472("LetzteURL"; "Termin"; "InfoText"; "Bitte gültige Uhrzeit eingeben!"))
			Else 
				e_AktTelefonNummer.WiederAm:=$vd_Datum
				e_AktTelefonNummer.WiederUm:=Time:C179($vz_Zeit)
				e_AktTelefonNummer.Status:="Wiedervorlage"
				web_SessionUpdate(New collection:C1472("LetzteURL"; "TerminEnde"))
		End case 
	: ($vt_Formular="TerminEnde")
		$vl_NeuKommTextPos:=$2
		web_SessionUpdate(New collection:C1472("LetzteURL"; "Adresse"; "AdrPKID"; ""; "Fassung"; ""; "FbNr"; 0; "LetzteFrage"; ""; "InfoFeld"; ""))
	: ($vt_Formular="Abbruch")
		$vl_NeuKommTextPos:=$2
		e_AktTelefonNummer.Status:="Abbruch"
		web_SessionUpdate(New collection:C1472("LetzteURL"; "Adresse"; "AdrPKID"; ""; "Fassung"; ""; "FbNr"; 0; "LetzteFrage"; ""; "InfoFeld"; ""))
	: ($vt_Formular="Abnahme")
		var $vt_Antwort : Text
		$vt_Antwort:=$2
		$vl_NeuKommTextPos:=$3
		
		Case of 
			: ($vt_Antwort="1")  // Interview
				e_AktTelefonNummer.Status:="Komplett"
				e_AktTelefonNummer.StatusErklärung:="Läuft"
				OB SET:C1220(e_AktTelefonNummer; "Start Am"; Current date:C33)
				OB SET:C1220(e_AktTelefonNummer; "Start um"; Current time:C178)
				web_SessionUpdate(New collection:C1472("LetzteURL"; "Interview"))
				e_AktTelefonNummer.Historie:=String:C10(Current date:C33)+"/"+String:C10(Current time:C178)+" * "+Session:C1714.userName+" * Interview läuft"+Char:C90(13)+e_AktTelefonNummer.Historie
				
			: ($vt_Antwort="2")  // Termin
				e_AktTelefonNummer.StatusErklärung:="Termin"
				web_SessionUpdate(New collection:C1472("LetzteURL"; "Termin"))
				e_AktTelefonNummer.Historie:=String:C10(Current date:C33)+"/"+String:C10(Current time:C178)+" * "+Session:C1714.userName+" * Wiedervorlage/Termin"+Char:C90(13)+e_AktTelefonNummer.Historie
			: ($vt_Antwort="3")  // Ausfall
				e_AktTelefonNummer.StatusErklärung:="Ausfall"
				web_SessionUpdate(New collection:C1472("LetzteURL"; "Abbruch"))
				e_AktTelefonNummer.Historie:=String:C10(Current date:C33)+"/"+String:C10(Current time:C178)+" * "+Session:C1714.userName+" * Abbruch/Ausfall"+Char:C90(13)+e_AktTelefonNummer.Historie
		End case 
	: ($vt_Formular="Interview")
		var $vt_Antwort : Text
		var $vz_Start : Time
		
		$vt_Antwort:=$2
		$vl_NeuKommTextPos:=$3
		
		Case of 
			: ($vt_Antwort="OK")
				e_AktTelefonNummer.StatusErklärung:=""
				OB SET:C1220(e_AktTelefonNummer; "Ende am"; Current date:C33)
				OB SET:C1220(e_AktTelefonNummer; "Ende um"; Current time:C178)
				$vz_Start:=OB Get:C1224(e_AktTelefonNummer; "Start um")
				e_AktTelefonNummer.Dauer:=Round:C94((Current time:C178-$vz_Start)/60; 0)
				e_AktTelefonNummer.Historie:=String:C10(Current date:C33)+"/"+String:C10(Current time:C178)+" * "+Session:C1714.userName+" * Interview beendet"+Char:C90(13)+e_AktTelefonNummer.Historie
				web_SessionUpdate(New collection:C1472("LetzteURL"; "Adresse"; "AdrPKID"; ""; "Fassung"; ""; "FbNr"; 0; "LetzteFrage"; ""; "InfoFeld"; ""))
			: ($vt_Antwort="Abbruch")
				e_AktTelefonNummer.StatusErklärung:="Interview-Abbruch"
				web_SessionUpdate(New collection:C1472("LetzteURL"; "Abbruch"))
				e_AktTelefonNummer.Historie:=String:C10(Current date:C33)+"/"+String:C10(Current time:C178)+" * "+Session:C1714.userName+" * Abbruch/Im Interview"+Char:C90(13)+e_AktTelefonNummer.Historie
		End case 
End case   // Formularwahl

If ($vl_APPos>0)
	If (at_FormVarValues{$vl_APPos}#"")
		e_AktTelefonNummer.Kommentar:=String:C10(Current date:C33)+" "+String:C10(Current time:C178)+"   "+Session:C1714.userName+Char:C90(13)+" Alter AP '"+e_AktTelefonNummer.aktAnsprechp+"' geändert!"+Char:C90(13)+"______________________________________"+Char:C90(13)+e_AktTelefonNummer.Kommentar
		e_AktTelefonNummer.aktAnsprechp:=at_FormVarValues{$vl_APPos}
	End if 
End if 

If ($vl_NummerPos>0)
	If (at_FormVarValues{$vl_NummerPos}#"")
		e_AktTelefonNummer.Kommentar:=String:C10(Current date:C33)+" "+String:C10(Current time:C178)+"   "+Session:C1714.userName+Char:C90(13)+" Alte TelNr. '"+e_AktTelefonNummer.Telefon1+"' geändert!"+Char:C90(13)+"______________________________________"+Char:C90(13)+e_AktTelefonNummer.Kommentar
		e_AktTelefonNummer.Telefon1:=at_FormVarValues{$vl_NummerPos}
	End if 
End if 

If ($vl_NeuKommTextPos>0)
	If (at_FormVarValues{$vl_NeuKommTextPos}#"")
		e_AktTelefonNummer.Kommentar:=String:C10(Current date:C33)+" "+String:C10(Current time:C178)+"   "+Session:C1714.userName+Char:C90(13)+at_FormVarValues{$vl_NeuKommTextPos}+Char:C90(13)+"______________________________________"+Char:C90(13)+e_AktTelefonNummer.Kommentar
	End if 
End if 


e_AktTelefonNummer.save()
