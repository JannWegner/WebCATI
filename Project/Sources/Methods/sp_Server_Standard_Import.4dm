//%attributes = {}
  // SERVER IMPORT Project Method
  // SERVER IMPORT ( Long ; String ; BLOB ; Int ; Int )
  // SERVER IMPORT ( Tabellennummer ; Eingabeformular ; Importdaten ; FeldTr ; RecTr )
C_LONGINT:C283($1)
C_TEXT:C284($2)
C_BLOB:C604($3)
C_LONGINT:C283($4;$5)
C_LONGINT:C283(spErrCode)
  // Operation ist noch nicht beendet, setze spErrCode auf 2
spErrCode:=2

FldDelimit:=$4
RecDelimit:=$5

$vpTable:=Table:C252($1)
FORM SET INPUT:C55($vpTable->;$2)
$vsDocName:="Import File "+String:C10(1+Random:C100)

BLOB PROPERTIES:C536($3;$viCompressed)
If (Not:C34($viCompressed=Is not compressed:K22:11))
	EXPAND BLOB:C535($3)
End if 
spErrCode:=3
BLOB TO DOCUMENT:C526($vsDocName;$3)
USE CHARACTER SET:C205("MacRoman";1)
IMPORT TEXT:C168($vpTable->;$vsDocName)
DELETE DOCUMENT:C159($vsDocName)
FldDelimit:=9
RecDelimit:=13
USE CHARACTER SET:C205(*;1)
  // Operation ist beendet, setze spErrCode auf -5
spErrCode:=-5
  // Warte bis der anfragende Client das Ergebnis erhalten hat
Repeat 
	DELAY PROCESS:C323(Current process:C322;60)
Until (spErrCode>0)
