//%attributes = {}
  // Projektmethode CLIENT EXPORT
  // CLIENT EXPORT ( Pointer ; String ; Int ; Int )
  // CLIENT EXPORT ( -> [Table] ; Output form ; FeldTr ; RecTr; FileName)
C_POINTER:C301($1)
C_TEXT:C284($2)
C_TEXT:C284($5)
C_LONGINT:C283($3;$4)
C_TIME:C306($vhDocRef)
C_BLOB:C604($vxData)
C_LONGINT:C283(spErrCode)
spErrCode:=1

  //Wähle das zu exportierende Dokument
$vhDocRef:=Create document:C266($5)
If (OK=1)
	  // Wurde ein Dokument ausgewählt, lasse es nicht offen
	CLOSE DOCUMENT:C267($vhDocRef)
	If (OK=1)
		$spProcessID:=Execute on server:C373("sp_Server_Standard_Export";32*1024;"Server Export Services";Table:C252($1);$2;$3;$4)
		
		LONGINT ARRAY FROM SELECTION:C647($1->;$alDSNummern)
		VARIABLE TO VARIABLE:C635($spProcessID;alDSNummern;$alDSNummern)
		spErrCode:=2
		SET PROCESS VARIABLE:C370($spProcessID;spErrCode;spErrCode)
		
		Repeat 
			Case of 
				: (spErrCode=2)
					MESSAGE:C88($5+" wird exportiert ..."+String:C10(Current time:C178))
				: (spErrCode=3)
					MESSAGE:C88($5+" wird komprimiert ..."+String:C10(Current time:C178))
			End case 
			DELAY PROCESS:C323(Current process:C322;150)
			GET PROCESS VARIABLE:C371($spProcessID;spErrCode;spErrCode)
			If (Undefined:C82(spErrCode))
				  // Hinweis: Wurde die Serverprozedur nicht mit der eigenen Instanz
				  // der Variablen spErrCode initialisiert, wird evtl. eine undefinierte
				  // Variable zurückgegeben
				spErrCode:=1
			End if 
		Until (spErrCode<0)
		
		MESSAGE:C88("Datei wird vom Server kopiert ..."+String:C10(Current time:C178))
		GET PROCESS VARIABLE:C371($spProcessID;vbExportDaten;$vxData)
		
		MESSAGE:C88("Daten werden ausgepackt ..."+String:C10(Current time:C178))
		
		BLOB PROPERTIES:C536($vxData;$viCompressed)
		If (Not:C34($viCompressed=Is not compressed:K22:11))
			EXPAND BLOB:C535($vxData)
		End if 
		
		BLOB TO DOCUMENT:C526(Document;$vxData)
		
		CLEAR VARIABLE:C89($alDSNummern)
		CLEAR VARIABLE:C89($vxData)
		spErrCode:=1
		SET PROCESS VARIABLE:C370($spProcessID;spErrCode;spErrCode)
	Else 
		ALERT:C41("Der Speicher reicht nicht aus zum Laden des Dokuments.")
	End if 
End if 

