C_TEXT:C284($vtBefehl;$vtSuchbegriff)
$vtSuchbegriff:=Request:C163("Suchformel eingeben (4D-Syntax):";"[TelefonNummer]xx")
$vtBefehl:=Replace string:C233("QUERY SELECTION BY FORMULA([TelefonNummer];xx)";"xx";$vtSuchbegriff)
EXECUTE FORMULA:C63($vtBefehl)
UNLOAD RECORD:C212([TelefonNummer:4])