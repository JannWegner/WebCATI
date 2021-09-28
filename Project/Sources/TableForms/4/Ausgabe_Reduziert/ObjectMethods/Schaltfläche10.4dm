QUERY:C277([TelefonNummer:4];[TelefonNummer:4]Status:5="Komplett";*)
QUERY SELECTION:C341([TelefonNummer:4]; & [TelefonNummer:4]Umfrage:30=vUmfrage)
UNLOAD RECORD:C212([TelefonNummer:4])