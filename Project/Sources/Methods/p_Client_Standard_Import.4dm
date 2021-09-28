//%attributes = {}
  // Projektmethode CLIENT IMPORT
  // CLIENT IMPORT ( Pointer ; String ; Int ; Int )
  // CLIENT IMPORT ( -> [Table] ; Input form ; FeldTr ; RecTr; FileName)
C_POINTER:C301($1)
C_TEXT:C284($2)
C_TEXT:C284($5)
C_LONGINT:C283($3;$4)
C_TIME:C306($vhDocRef)
C_BLOB:C604($vxData)
C_LONGINT:C283(spErrCode)
spErrCode:=1

$vhDocRef:=Open document:C264($5)
If (OK=1)
	  // Wurde ein Dokument ausgewählt, lasse es nicht offen
	CLOSE DOCUMENT:C267($vhDocRef)
	  // Versuche, es in den Speicher zu laden
	DOCUMENT TO BLOB:C525(Document;$vxData)
	If (OK=1)
		MESSAGE:C88("Daten werden komprimiert ..."+String:C10(Current time:C178))
		COMPRESS BLOB:C534($vxData)
		MESSAGE:C88("Datei wird auf den Server kopiert ..."+String:C10(Current time:C178))
		  // Das Dokument konnte ins BLOB geladen werden,
		  // Starte Serverprozedur, die Daten auf dem Server-Rechner importiert
		$spProcessID:=Execute on server:C373("sp_Server_Standard_Import";32*1024;"Server Import Services";Table:C252($1);$2;$vxData;$3;$4)
		  // Wir benötigen das BLOB nicht länger in diesem Prozeß
		CLEAR VARIABLE:C89($vxData)
		  // Warte bis von Serverprozedur ausgeführte Operation fertig ist.
		Repeat 
			Case of 
				: (spErrCode=2)
					MESSAGE:C88($5+" wird ausgepackt ..."+String:C10(Current time:C178))
				: (spErrCode=3)
					MESSAGE:C88($5+" wird importiert ..."+String:C10(Current time:C178))
			End case 
			DELAY PROCESS:C323(Current process:C322;300)
			GET PROCESS VARIABLE:C371($spProcessID;spErrCode;spErrCode)
			If (Undefined:C82(spErrCode))
				  // Hinweis: Wurde die Serverprozedur nicht mit der eigenen Instanz
				  // der Variablen spErrCode initialisiert, wird evtl. eine undefinierte
				  // Variable zurückgegeben
				spErrCode:=1
			End if 
		Until (spErrCode<0)
		  // Teile der Serverprozedur mit, daß wir bestätigen
		spErrCode:=1
		SET PROCESS VARIABLE:C370($spProcessID;spErrCode;spErrCode)
	Else 
		ALERT:C41("Der Speicher reicht nicht aus zum Laden des Dokuments.")
	End if 
End if 