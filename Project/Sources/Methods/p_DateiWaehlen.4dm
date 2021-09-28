//%attributes = {}
  //Stellt einen Datei oeffnen bzw. Speichern unter Dialog zur Verfügung
  //Aufruf mit p_DateiWaehlen(LesenSchreiben;Startpfad;Filter)
  //mit LesenSchreiben=0 = Lesen, 1= Schreiben
  //Gibt eine Datei mit Pfad zurück oder leer

C_LONGINT:C283($1)
C_TEXT:C284($2;3)

viLesenSchreiben:=$1
vsPfad:=$2
vsFilter:=$3
If (viLesenSchreiben=0)
	vsText:="Bitte Datei wählen ..."
Else 
	vsText:="Speichern unter ..."
End if 

vsDatei:=""
DIALOG:C40([Variablen:5];"d_DateiWaehlen")
$0:=vsDatei