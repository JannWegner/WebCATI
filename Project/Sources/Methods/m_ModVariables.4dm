//%attributes = {}
p_LogDatenAktualisieren ("Variablen";vUmfrage;0;"")

QUERY:C277([Variablen:5];[Variablen:5]Umfrage:3=vUmfrage)
FORM SET INPUT:C55([Variablen:5];"Eingabe")
READ WRITE:C146([Variablen:5])
MODIFY RECORD:C57([Variablen:5])
READ ONLY:C145([Variablen:5])
UNLOAD RECORD:C212([Variablen:5])
QUERY:C277([Variablen:5];[Variablen:5]Umfrage:3=vUmfrage)

p_LogDatenAktualisieren ("Startbildschirm";vUmfrage;0;"")

