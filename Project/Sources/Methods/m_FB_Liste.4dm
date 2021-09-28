//%attributes = {}
SET MENU BAR:C67(1)
vUmfrage:=$1
SET WINDOW RECT:C444(100;100;1000;900)
READ ONLY:C145([Variablen:5])
READ ONLY:C145([Quoten:7])
QUERY:C277([Variablen:5];[Variablen:5]Umfrage:3=vUmfrage)
FORM SET OUTPUT:C54([Bogen:6];"Kontrolle")
FORM SET INPUT:C55([Bogen:6];"Eingabe")
QUERY:C277([Bogen:6];[Bogen:6]Umfrage:20=vUmfrage)
READ WRITE:C146([Bogen:6])
ORDER BY:C49([Bogen:6];[Bogen:6]ID:1)
MODIFY SELECTION:C204([Bogen:6];*)
READ ONLY:C145([Bogen:6])