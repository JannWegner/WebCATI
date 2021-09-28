//%attributes = {}
  // SERVER EXPORT Project Method
  // SERVER EXPORT ( Long ; String ; BLOB ; Int ; Int )
  // SERVER EXPORT ( Tabellennummer ; Ausgabeformular ;  FeldTr ; RecTr )
C_LONGINT:C283($1)
C_TEXT:C284($2)
C_LONGINT:C283($3;$4)
C_LONGINT:C283(spErrCode)

ARRAY LONGINT:C221(alDSNummern;0)
C_BLOB:C604(vbExportDaten)

  // Operation ist noch nicht beendet, setze spErrCode auf 1
spErrCode:=1

Repeat 
	  //Warten bis das DS-Array übergeben wurde
	DELAY PROCESS:C323(Current process:C322;150)
	If (Undefined:C82(spErrCode))
		  // Hinweis: Wurde die Serverprozedur nicht mit der eigenen Instanz
		  // der Variablen spErrCode initialisiert, wird evtl. eine undefinierte
		  // Variable zurückgegeben
		spErrCode:=1
	End if 
Until (spErrCode=2)

$vpTable:=Table:C252($1)
FORM SET OUTPUT:C54($vpTable->;$2)

CREATE SELECTION FROM ARRAY:C640($vpTable->;alDSNummern)

FldDelimit:=$3
RecDelimit:=$4

  //TRACE
$vsDocName:="Export File "+String:C10(1+Random:C100)
USE CHARACTER SET:C205("MacRoman";0)
EXPORT TEXT:C167($vpTable->;$vsDocName)
USE CHARACTER SET:C205(*;0)

DOCUMENT TO BLOB:C525($vsDocName;vbExportDaten)
spErrCode:=3
COMPRESS BLOB:C534(vbExportDaten)

DELETE DOCUMENT:C159($vsDocName)
FldDelimit:=9
RecDelimit:=13

  // Operation ist beendet, setze spErrCode auf -5
spErrCode:=-5

  // Warte bis der anfragende Client das Ergebnis erhalten hat
Repeat 
	DELAY PROCESS:C323(Current process:C322;150)
Until (spErrCode>0)
CLEAR VARIABLE:C89(vbExportDaten)