COPY NAMED SELECTION:C331([TelefonNummer:4];"$ns_Ausgang")
$vl_Ausgang:=Records in selection:C76([TelefonNummer:4])
QUERY SELECTION:C341([TelefonNummer:4];[TelefonNummer:4]Status:5#"Abbruch";*)
QUERY SELECTION:C341([TelefonNummer:4]; & [TelefonNummer:4]Status:5#"Abgebrochen";*)
QUERY SELECTION:C341([TelefonNummer:4]; & [TelefonNummer:4]Status:5#"In Arbeit";*)
QUERY SELECTION:C341([TelefonNummer:4]; & [TelefonNummer:4]Status:5#"Ausfall";*)
QUERY SELECTION:C341([TelefonNummer:4]; & [TelefonNummer:4]Status:5#"Komplett";*)
QUERY SELECTION:C341([TelefonNummer:4]; & [TelefonNummer:4]Status:5#"ADM@")
CONFIRM:C162(String:C10(Records in selection:C76([TelefonNummer:4]))+" von "+String:C10($vl_Ausgang)+" könnten auf Termin gesetzt werden!";"Termin";"Abbruch")


$vd_Datum:=Date:C102(Request:C163("Wunschdatum?";String:C10(Current date:C33)))
$vt_Zeit:=Time:C179(Request:C163("Wunschzeit?";String:C10(Current time:C178)))
CONFIRM:C162("Als Fixtermin";"Nein danke";"Fixtermin")
If (OK=1)
	$vb_Fix:=False:C215
Else 
	$vb_Fix:=True:C214
End if 

$vt_Text:="Termin wie folgt setzen:"+Char:C90(13)
$vt_Text:=$vt_Text+"Anzahl Adressen: "+String:C10(Records in selection:C76([TelefonNummer:4]))+Char:C90(13)
$vt_Text:=$vt_Text+"Datum: "+String:C10($vd_Datum)+Char:C90(13)
$vt_Text:=$vt_Text+"Zeit: "+String:C10($vt_Zeit)+Char:C90(13)
$vt_Text:=$vt_Text+"Fix: "+(Num:C11($vb_Fix)*"Ja")+(Num:C11(Not:C34($vb_Fix))*"Nein")+Char:C90(13)
CONFIRM:C162($vt_Text;"Termin setzen";"Abbrechen")

If (OK=1)
	$vb_OK:=True:C214
	AdressenLesenSchreiben 
	START TRANSACTION:C239
	
	APPLY TO SELECTION:C70([TelefonNummer:4];[TelefonNummer:4]Status:5:="Wiedervorlage")
	$vb_OK:=$vb_OK & (OK=1)
	APPLY TO SELECTION:C70([TelefonNummer:4];[TelefonNummer:4]StatusErklärung:11:="Termin Manuell")
	$vb_OK:=$vb_OK & (OK=1)
	APPLY TO SELECTION:C70([TelefonNummer:4];[TelefonNummer:4]FixTermin:36:=$vb_Fix)
	$vb_OK:=$vb_OK & (OK=1)
	If ($vb_Fix)
		APPLY TO SELECTION:C70([TelefonNummer:4];[TelefonNummer:4]Historie:4:=String:C10(Current date:C33)+"/"+String:C10(Current time:C178)+" * "+Current user:C182+" * Wiedervorlage/FIX-Termin manuell"+Char:C90(13)+[TelefonNummer:4]Historie:4)
		$vb_OK:=$vb_OK & (OK=1)
	Else 
		APPLY TO SELECTION:C70([TelefonNummer:4];[TelefonNummer:4]Historie:4:=String:C10(Current date:C33)+"/"+String:C10(Current time:C178)+" * "+Current user:C182+" * Wiedervorlage/Termin manuell"+Char:C90(13)+[TelefonNummer:4]Historie:4)
		$vb_OK:=$vb_OK & (OK=1)
	End if 
	APPLY TO SELECTION:C70([TelefonNummer:4];[TelefonNummer:4]WiederAm:2:=$vd_Datum)
	$vb_OK:=$vb_OK & (OK=1)
	APPLY TO SELECTION:C70([TelefonNummer:4];[TelefonNummer:4]WiederUm:3:=$vt_Zeit)
	$vb_OK:=$vb_OK & (OK=1)
	If ($vb_OK)
		VALIDATE TRANSACTION:C240
		ALERT:C41("Adressen geändert!")
	Else 
		CANCEL TRANSACTION:C241
		ALERT:C41("Nichts geändert - da hat was nicht geklappt!")
	End if 
	READ ONLY:C145([TelefonNummer:4])
Else 
	USE NAMED SELECTION:C332("$ns_Ausgang")
End if 

