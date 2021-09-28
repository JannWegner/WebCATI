//%attributes = {}
  //Baut eine Tabelle für das Nachziehen von konkrete Angaben bei Spezial-Fragen für den Export

MESSAGE:C88("Spezial-Konverter bauen ...")

QUERY:C277([Bogen:6];[Bogen:6]Umfrage:20=vUmfrage;*)
QUERY:C277([Bogen:6]; & [Bogen:6]Filter_Eingabe:9="@K@")

ARRAY TEXT:C222(tBogenID;0)
ARRAY TEXT:C222(tKonvWert;0)

FIRST RECORD:C50([Bogen:6])
While (Not:C34(End selection:C36([Bogen:6])))
	  //Blank ergänzen, damit das Ende sicher gefunden wird
	$Text:=[Bogen:6]Filter_Eingabe:9+" "
	While (Position:C15("K";$Text)#0)
		INSERT IN ARRAY:C227(tBogenID;1)
		INSERT IN ARRAY:C227(tKonvWert;1)
		
		$Text:=Substring:C12($Text;Position:C15("K";$Text)+2)
		tBogenID{1}:=[Bogen:6]ID:1+"#"+Substring:C12($Text;1;Position:C15(",";$Text)-1)
		$Text:=Substring:C12($Text;Position:C15(",";$Text)+1)
		tKonvWert{1}:=Substring:C12($Text;1;Position:C15(" ";$Text)-1)
		$Text:=Substring:C12($Text;Position:C15(" ";$Text)+1)
	End while 
	NEXT RECORD:C51([Bogen:6])
End while 


