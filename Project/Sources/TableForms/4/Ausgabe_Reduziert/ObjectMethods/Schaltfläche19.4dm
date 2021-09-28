CONFIRM:C162("Aktuelle Auswahl freigeben (n="+String:C10(Records in selection:C76([TelefonNummer:4]))+")";"Freigeben";"Abbrechen")
If (OK=1)
	QUERY SELECTION:C341([TelefonNummer:4];[TelefonNummer:4]Status:5#"Abbruch";*)
	QUERY SELECTION:C341([TelefonNummer:4]; & [TelefonNummer:4]Status:5#"Abgebrochen";*)
	QUERY SELECTION:C341([TelefonNummer:4]; & [TelefonNummer:4]Status:5#"In Arbeit";*)
	QUERY SELECTION:C341([TelefonNummer:4]; & [TelefonNummer:4]Status:5#"Ausfall";*)
	QUERY SELECTION:C341([TelefonNummer:4]; & [TelefonNummer:4]Status:5#"Komplett";*)
	QUERY SELECTION:C341([TelefonNummer:4]; & [TelefonNummer:4]Status:5#"Neu";*)
	QUERY SELECTION:C341([TelefonNummer:4]; & [TelefonNummer:4]Status:5#"ADM@";*)
	QUERY SELECTION:C341([TelefonNummer:4]; & [TelefonNummer:4]Status:5#"Wiedervorlage")
	$vi_Aenderfaehig:=Records in selection:C76([TelefonNummer:4])
	START TRANSACTION:C239
	APPLY TO SELECTION:C70([TelefonNummer:4];[TelefonNummer:4]Status:5:="Neu")
	If (Records in set:C195("LockedSet")=0)
		CONFIRM:C162(String:C10($vi_Aenderfaehig)+" Adressen hatten einen änderungsfähigen Status, alle davon könnten auf 'Neu' gese"+"tzt werden.";"'Neu' setzen";"Abbrechen")
		If (OK=1)
			VALIDATE TRANSACTION:C240
			ALERT:C41("Adressen geändert!")
		Else 
			CANCEL TRANSACTION:C241
			ALERT:C41("Nichts geändert!")
		End if 
	Else 
		CANCEL TRANSACTION:C241
		USE SET:C118("LockedSet")
		ALERT:C41("Die angezeigten Adressen waren gesperrt! - Nichts geändert")
	End if 
Else 
	ALERT:C41("Nichts geändert!")
End if 