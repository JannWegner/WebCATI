If (Records in set:C195("UserSet")=1)
	CONFIRM:C162("Diese Adresse wirklich zurücksetzen? "+Char:C90(13)+"Es wird der komplette Fragebogen gelöscht, Termine verworfen und der Status zurüc"+"kgesetzt!";"Abbrechen";"Rücksetzen")
	If (OK=0)
		CONFIRM:C162("Es wird wirklich unwiderruflich gelöscht!";"Abbrechen";"Rücksetzen")
		If (OK=0)
			START TRANSACTION:C239
			COPY NAMED SELECTION:C331([TelefonNummer:4];"$nsAdr")
			USE SET:C118("UserSet")
			vs_KommentarNeu:=String:C10(Current date:C33)+" "+String:C10(Current time:C178)+"   "+Current user:C182+Char:C90(13)+"ADRESSE ZURÜCKGESETZT"+Char:C90(13)+"______________________________________"+Char:C90(13)+[TelefonNummer:4]Kommentar:6
			vs_HistNeu:=String:C10(Current date:C33)+"/"+String:C10(Current time:C178)+" * "+[LogDaten:1]DBNutzer:1+" * ADRESSE ZURÜCKGESETZT"+Char:C90(13)+[TelefonNummer:4]Historie:4
			APPLY TO SELECTION:C70([TelefonNummer:4];p_Adr_jungfr_setzen_Formel )
			VALIDATE TRANSACTION:C240
			USE NAMED SELECTION:C332("$nsAdr")
		Else 
			ALERT:C41("Nix passiert!")
		End if 
	Else 
		ALERT:C41("Nix passiert!")
	End if 
Else 
	ALERT:C41("Bitte genau eine Adresse markieren!")
End if 
UNLOAD RECORD:C212([TelefonNummer:4])