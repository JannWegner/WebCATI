//%attributes = {}
$StartDat:=Date:C102(Request:C163("Start-Datum (einschließlich):";"01.01.2000"))
$StopDat:=Date:C102(Request:C163("Ende-Datum (einschließlich):";String:C10(Current date:C33)))
QUERY SELECTION:C341([TelefonNummer:4];[TelefonNummer:4]Umfrage:30=vUmfrage;*)
QUERY SELECTION:C341([TelefonNummer:4]; & [TelefonNummer:4]Status:5="Komplett";*)
QUERY SELECTION:C341([TelefonNummer:4]; & [TelefonNummer:4]Ende am:25>=$StartDat;*)
QUERY SELECTION:C341([TelefonNummer:4]; & [TelefonNummer:4]Ende am:25<=$StopDat)

CONFIRM:C162("Nur Neue oder alle im Zeitraum drucken?";"Nur Neue";"Alle")
If (OK=1)
	QUERY SELECTION:C341([TelefonNummer:4];[TelefonNummer:4]SpezialDruck:45=!00-00-00!)
End if 

p_SpezialDrucken 
