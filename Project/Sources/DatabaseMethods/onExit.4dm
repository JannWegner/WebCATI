  //Benutzer im Logbuch abmelden


GOTO RECORD:C242([LogDaten:1];<>BenutzerNr)
[LogDaten:1]Stop Datum:4:=Current date:C33
[LogDaten:1]Stop Zeit:5:=Current time:C178
[LogDaten:1]Modul:8:=""
SAVE RECORD:C53([LogDaten:1])