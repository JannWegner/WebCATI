  //Umfragedaten in Cache laden
ALL RECORDS:C47([Variablen:5])
ORDER BY:C49([Variablen:5];[Variablen:5]EingerichtetAm:40;<)
SELECTION TO ARRAY:C260([Variablen:5]Umfrage:3;$taUmfragen;[Variablen:5]EingerichtetAm:40;$tdEingerichtet;[Variablen:5]AnonymDurch:42;$taAnonymDurch;[Variablen:5]AnonymAm:41;$tdAnonymAm;[Variablen:5]Umfrage:3;$taUmfragenAnzeige)
ARRAY LONGINT:C221($tiAnzahlAdr;Size of array:C274($taUmfragen))
ARRAY LONGINT:C221($tiAnzahlKomplett;Size of array:C274($taUmfragen))
For ($lauf;1;Size of array:C274($taUmfragen))
	QUERY:C277([TelefonNummer:4];[TelefonNummer:4]Umfrage:30=$taUmfragen{$lauf})
	$tiAnzahlAdr{$lauf}:=Records in selection:C76([TelefonNummer:4])
	QUERY SELECTION:C341([TelefonNummer:4];[TelefonNummer:4]Status:5="Komplett")
	$tiAnzahlKomplett{$lauf}:=Records in selection:C76([TelefonNummer:4])
End for 
