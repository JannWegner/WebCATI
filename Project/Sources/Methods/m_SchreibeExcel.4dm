//%attributes = {}
QUERY:C277([TelefonNummer:4];[TelefonNummer:4]Umfrage:30=vUmfrage;*)
QUERY:C277([TelefonNummer:4]; & [TelefonNummer:4]Status:5="Komplett")

CONFIRM:C162("Wirklich Excel für "+String:C10(Records in selection:C76([TelefonNummer:4]))+" Sätze schreiben?";"Excel";"Nein")
If (OK=1)
	p_SchreibeExcel 
End if 
