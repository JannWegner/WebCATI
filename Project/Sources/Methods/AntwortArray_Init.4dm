//%attributes = {}
  //Initialisiert das Array mit den Antworten des aktuelllen Bogens

  //1. Array aufbauen anhand der Bogen-Datensätze
ARRAY TEXT:C222(asBogenID;0)
ARRAY TEXT:C222(atAntworten;0)

  //QUERY([Bogen];[Bogen]Umfrage="Universell!!";*)
  //QUERY([Bogen]; | [Bogen]Umfrage=vUmfrage;*)
  //QUERY([Bogen]; & [Bogen]ID#"@-bed")
QUERY:C277([Bogen:6];[Bogen:6]Umfrage:20="Universell!!";*)
QUERY:C277([Bogen:6]; | [Bogen:6]Umfrage:20=vUmfrage)
SELECTION TO ARRAY:C260([Bogen:6]ID:1;asBogenID)
INSERT IN ARRAY:C227(asBogenID;1;5)
asBogenID{1}:=".vs1_Telefon"
asBogenID{2}:=".vs2_IntBereit"
asBogenID{3}:=".vs3_Ausfall"
asBogenID{4}:=".vs4_AusfallSonst"
asBogenID{5}:=".vs5_Abbruch"

  //2. Platz für teiloffene Fragen (gen_Halboffen und gen_1b...) vorsehen
QUERY:C277([Bogen:6];[Bogen:6]Umfrage:20=vUmfrage)
QUERY SELECTION:C341([Bogen:6];[Bogen:6]FormNam:8="gen_1b@";*)
QUERY SELECTION:C341([Bogen:6]; | [Bogen:6]FormNam:8="gen_Halboffen")
While (Not:C34(End selection:C36([Bogen:6])))
	INSERT IN ARRAY:C227(asBogenID;1)
	asBogenID{1}:=[Bogen:6]ID:1+"Offen"
	NEXT RECORD:C51([Bogen:6])
End while 

  //3. Platz für in p_Xtra_UmfrSpez generierte Antworten vorsehen
QUERY:C277([Bogen:6];[Bogen:6]Umfrage:20=vUmfrage;*)
QUERY:C277([Bogen:6];[Bogen:6]Bedingung:10="p_Xtra_UmfrSpez-w")
While (Not:C34(End selection:C36([Bogen:6])))
	INSERT IN ARRAY:C227(asBogenID;1)
	asBogenID{1}:=[Bogen:6]ID:1
	NEXT RECORD:C51([Bogen:6])
End while 

SORT ARRAY:C229(asBogenID)

  //3.  Leeres Array für die Antworten bauen
ARRAY TEXT:C222(atAntworten;Size of array:C274(asBogenID))

