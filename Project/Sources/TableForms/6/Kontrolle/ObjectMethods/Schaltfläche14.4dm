QUERY:C277([Bogen:6];[Bogen:6]Umfrage:20=vUmfrage;*)
QUERY:C277([Bogen:6]; & [Bogen:6]FormNam:8="gen_@")
APPLY TO SELECTION:C70([Bogen:6];[Bogen:6]Sprungziel:11:=True:C214)

QUERY:C277([Bogen:6];[Bogen:6]Umfrage:20=vUmfrage;*)
QUERY:C277([Bogen:6]; & [Bogen:6]FormNam:8#"gen_@")
APPLY TO SELECTION:C70([Bogen:6];[Bogen:6]Sprungziel:11:=False:C215)


QUERY:C277([Bogen:6];[Bogen:6]Umfrage:20=vUmfrage)
ORDER BY:C49([Bogen:6]ID:1)

ALERT:C41("Fertig!")