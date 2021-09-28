//%attributes = {}
SET WINDOW RECT:C444(100;100;1100;600)
SET WINDOW TITLE:C213("Interviewer-Status")
FORM SET OUTPUT:C54([LogDaten:1];"d_IntStatus")
vbAktualisieren:=True:C214
While (vbAktualisieren)
	QUERY:C277([LogDaten:1];[LogDaten:1]Stop Datum:4="00.00.00";*)
	QUERY:C277([LogDaten:1]; & [LogDaten:1]Gestorben:14=False:C215)
	ORDER BY:C49([LogDaten:1];[LogDaten:1]DBNutzer:1)
	MODIFY SELECTION:C204([LogDaten:1];*)
	  //DISPLAY SELECTION([LogDaten];*)
End while 
