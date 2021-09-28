//%attributes = {}
C_LONGINT:C283(spErrCode)
spErrCode:=1
$spProcessID:=Execute on server:C373("sp_QuotenAdrAuslesen";32*1024;"Server Quoten Services";vUmfrage)
Repeat 
	DELAY PROCESS:C323(Current process:C322;150)
	GET PROCESS VARIABLE:C371($spProcessID;spErrCode;spErrCode)
	MESSAGE:C88("Prozess wird gestartet ...")
Until (spErrCode=2)

MESSAGE:C88("Variablen zum Server übertragen ...")
VARIABLE TO VARIABLE:C635($spProcessID;aiQuKomplett;aiQuKomplett;aiQuNeu;aiQuNeu;aiQuFix;aiQuFix;aiQuVar;aiQuVar;aiQuAuto;aiQuAuto)
spErrCode:=3
VARIABLE TO VARIABLE:C635($spProcessID;spErrCode;spErrCode)

Repeat 
	DELAY PROCESS:C323(Current process:C322;150)
	GET PROCESS VARIABLE:C371($spProcessID;spErrCode;spErrCode)
	MESSAGE:C88("Adressen werden ausgewertet ...")
Until (spErrCode=4)


MESSAGE:C88("Variablen vom Server holen ...")
C_BLOB:C604(vbArrayBlob)
$viOffset:=0
GET PROCESS VARIABLE:C371($spProcessID;vbArrayBlob;vbArrayBlob)
BLOB PROPERTIES:C536(vbArrayBlob;$viCompressed)
If (Not:C34($viCompressed=Is not compressed:K22:11))
	EXPAND BLOB:C535(vbArrayBlob)
End if 
BLOB TO VARIABLE:C533(vbArrayBlob;aiQuKomplett;$viOffset)
BLOB TO VARIABLE:C533(vbArrayBlob;aiQuNeu;$viOffset)
BLOB TO VARIABLE:C533(vbArrayBlob;aiQuFix;$viOffset)
BLOB TO VARIABLE:C533(vbArrayBlob;aiQuVar;$viOffset)
BLOB TO VARIABLE:C533(vbArrayBlob;aiQuAuto;$viOffset)

spErrCode:=-1
VARIABLE TO VARIABLE:C635($spProcessID;spErrCode;spErrCode)

