If (Current user:C182="Designer")
	CONFIRM:C162("Trace-Modus?";"Normal weiter";"Trace")
	If (OK=0)
		TRACE:C157
	End if 
End if 

  //ON EVENT CALL("KeyCheck")
SET DEFAULT CENTURY:C392(20)

REGISTER CLIENT:C648(Substring:C12(Current user:C182+"/"+Current machine:C483;1;30);15)

READ ONLY:C145([Variablen:5])
READ ONLY:C145([Quoten:7])

DEBUG:=True:C214
vb_WegInBlobSpeichern:=True:C214

  //Test, ob es noch tote Eintraege dieses Rechners von einem Absturz gibt
QUERY:C277([LogDaten:1];[LogDaten:1]Station:7=Current machine:C483;*)
QUERY:C277([LogDaten:1]; & [LogDaten:1]Stop Datum:4="00.00.00";*)
QUERY:C277([LogDaten:1]; & [LogDaten:1]Gestorben:14=False:C215)
APPLY TO SELECTION:C70([LogDaten:1];[LogDaten:1]Gestorben:14:=True:C214)

  //LogDaten eintragen bei Benutzeranmeldung
CREATE RECORD:C68([LogDaten:1])
[LogDaten:1]DBNutzer:1:=Current user:C182
[LogDaten:1]Start Datum:2:=Current date:C33
[LogDaten:1]Start Zeit:3:=Current time:C178
[LogDaten:1]Modul:8:="Startbildschirm"
[LogDaten:1]PCNutzer:6:=Current system user:C484
[LogDaten:1]Station:7:=Current machine:C483

SAVE RECORD:C53([LogDaten:1])
LOAD RECORD:C52([LogDaten:1])
LOCKED BY:C353([LogDaten:1];ProzNr;AnwNam;ArbStat;ProzNam)
sichere_DS (Table:C252(->[LogDaten:1]);DEBUG)

<>BenutzerNr:=Record number:C243([LogDaten:1])

If (Current user:C182="Administrator")
	EDIT ACCESS:C281
	QUIT 4D:C291
Else 
	C_TEXT:C284(vUmfrage)
	vUmfrage:=""
	p_UmfrageWählen 
	p_FensterAnpassen (600;400)
	
	  //Fuer den Dateiöffnen-Dialog
	vsPfad:=""
End if 

UNLOAD RECORD:C212([TelefonNummer:4])

  // Fuer WebCATI
C_COLLECTION:C1488(<>col_WebSession)



ARRAY TEXT:C222(<>at_SessionID;0)
ARRAY OBJECT:C1221(<>ao_SessionObject;0)

<>vt_KontrollText:="ABCDEFGHIJKLMNOPQRSTUVWXYZ"  // Kleinbuchstaben sind auch gleich mit drin
<>vt_KontrollText:=<>vt_KontrollText+"0123456789!$%&/()_-!"+Char:C90(13)


