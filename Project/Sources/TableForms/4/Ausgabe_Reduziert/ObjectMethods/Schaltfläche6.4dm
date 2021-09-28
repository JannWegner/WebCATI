QUERY:C277([TelefonNummer:4];[TelefonNummer:4]Umfrage:30=vUmfrage;*)
QUERY:C277([TelefonNummer:4]; & [TelefonNummer:4]Status:5="Wiedervorlage")
ORDER BY:C49([TelefonNummer:4];[TelefonNummer:4]WiederAm:2;[TelefonNummer:4]WiederUm:3)
UNLOAD RECORD:C212([TelefonNummer:4])