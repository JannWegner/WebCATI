QUERY:C277([TelefonNummer:4];[TelefonNummer:4]Status:5="adm@";*)
QUERY SELECTION:C341([TelefonNummer:4]; & [TelefonNummer:4]Umfrage:30=vUmfrage)
UNLOAD RECORD:C212([TelefonNummer:4])
ORDER BY:C49([TelefonNummer:4];[TelefonNummer:4]Status:5;<)