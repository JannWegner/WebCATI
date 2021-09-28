//%attributes = {}
QUERY:C277([Bogen:6];[Bogen:6]Umfrage:20=vUmfrage;*)
QUERY:C277([Bogen:6];[Bogen:6]Spezial_Eingabe:22=True:C214)
ORDER BY:C49([Bogen:6];[Bogen:6]ID:1;<)

FIRST RECORD:C50([Bogen:6])
$vWeiterMit:="Ende_Spez"
While (Not:C34(End selection:C36([Bogen:6])))
	MESSAGE:C88("Bearbeiten von "+[Bogen:6]ID:1)
	[Bogen:6]nextID:6:=$vWeiterMit
	SAVE RECORD:C53([Bogen:6])
	$vWeiterMit:=[Bogen:6]ID:1
	NEXT RECORD:C51([Bogen:6])
End while 