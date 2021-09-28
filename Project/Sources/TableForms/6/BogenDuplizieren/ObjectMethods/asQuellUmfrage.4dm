Case of 
	: (Form event code:C388=On Load:K2:1)
		ALL RECORDS:C47([Variablen:5])
		SELECTION TO ARRAY:C260([Variablen:5]Umfrage:3;asQuellUmfrage)
		SORT ARRAY:C229(asQuellUmfrage)
		asQuellUmfrage:=0
	: (Form event code:C388=On Clicked:K2:4)
		QUERY:C277([Bogen:6];[Bogen:6]Umfrage:20=asQuellUmfrage{asQuellUmfrage})
		ORDER BY:C49([Bogen:6];[Bogen:6]ID:1)
		SELECTION TO ARRAY:C260([Bogen:6]ID:1;asBogenIDQuelle)
		SELECTION TO ARRAY:C260([Bogen:6]FText:3;atFrageText)
		SELECTION TO ARRAY:C260([Bogen:6]Spalte:12;asSpalteQuelle)
		SELECTION TO ARRAY:C260([Bogen:6]nextID:6;asNextIDQuelle)
		ARRAY TEXT:C222(asSpalteZiel;Size of array:C274(asSpalteQuelle))
		ARRAY TEXT:C222(asBogenIDZiel;Size of array:C274(asSpalteQuelle))
		ARRAY TEXT:C222(asNextIDZiel;Size of array:C274(asSpalteQuelle))
End case 