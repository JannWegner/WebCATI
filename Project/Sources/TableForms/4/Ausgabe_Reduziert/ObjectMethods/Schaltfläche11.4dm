CONFIRM:C162("In Allen oder in der Auswahl suchen?";"In Allen";"Auswahl")
If (OK=1)
	QUERY:C277([TelefonNummer:4];[TelefonNummer:4]Umfrage:30=vUmfrage)
End if 
CREATE SET:C116([TelefonNummer:4];"mAktuelleAuswahl")
p_FreieAdressenEinlesen 
INTERSECTION:C121("mAktuelleAuswahl";"FreieAdressen";"mAktuelleAuswahl")
USE SET:C118("mAktuelleAuswahl")
QUERY SELECTION:C341([TelefonNummer:4];[TelefonNummer:4]Status:5="Neu")
UNLOAD RECORD:C212([TelefonNummer:4])