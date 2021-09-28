//%attributes = {}
  //Berechnet die Fassung anhand der vorhanden Bögen "komplett" und in "Arbeit"
  //SET QUERY DESTINATION(Into current selection )

C_LONGINT:C283($viAnzRecords)

QUERY:C277([TelefonNummer:4];[TelefonNummer:4]Umfrage:30=vUmfrage)
QUERY SELECTION:C341([TelefonNummer:4];[TelefonNummer:4]Status:5="In Arbeit";*)
QUERY SELECTION:C341([TelefonNummer:4]; | [TelefonNummer:4]Status:5="Komplett")
CREATE SET:C116([TelefonNummer:4];"$mFürFassung")
SET QUERY DESTINATION:C396(Into variable:K19:4;$viAnzRecords)
ARRAY INTEGER:C220(aiFassAnz;Size of array:C274(atFassung))

For ($lauf;1;Size of array:C274(atFassung))
	USE SET:C118("$mFürFassung")
	QUERY SELECTION:C341([TelefonNummer:4];[TelefonNummer:4]Fassung:39=atFassung{$lauf})
	aiFassAnz{$lauf}:=$viAnzRecords
End for 

SET QUERY DESTINATION:C396(Into current selection:K19:1)
SORT ARRAY:C229(aiFassAnz;atFassung)

If (aiFassAnz{1}=aiFassAnz{2})
	viFassung:=atFassung{Random:C100%2+1}
Else 
	viFassung:=atFassung{1}
End if 
