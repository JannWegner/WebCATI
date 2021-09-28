//%attributes = {}
  //Fuellt das Array asDateiListe mit Werten
$vsPfad:=$1
$vsFilter:=$2

DOCUMENT LIST:C474($vsPfad;asDateiListe)
FOLDER LIST:C473($vsPfad;$asOrdnerListe)
VOLUME LIST:C471($asVolumes)

  //Dateien und Ordner mit "." am Anfang rausschmeissen
  //Rueckwaertszaehlen wegen Ast absaegen
For ($lauf;Size of array:C274(asDateiListe);1;-1)
	If (asDateiListe{$lauf}=".@")
		DELETE FROM ARRAY:C228(asDateiListe;$lauf)
	End if 
End for 
For ($lauf;Size of array:C274($asOrdnerListe);1;-1)
	If ($asOrdnerListe{$lauf}=".@")
		DELETE FROM ARRAY:C228($asOrdnerListe;$lauf)
	End if 
End for 


SORT ARRAY:C229($asOrdnerListe;<)
If (($vsFilter#"") & ($vsFilter="@"))
	  //Liste bereinigen
	For ($lauf;Size of array:C274(asDateiListe);1;-1)
		If (asDateiListe{$lauf}#$vsFilter)
			DELETE FROM ARRAY:C228(asDateiListe;$lauf)
		End if 
	End for 
End if 
SORT ARRAY:C229(asDateiListe)
  //Ordern und Dateien anfügen 
For ($lauf;1;Size of array:C274($asOrdnerListe))
	INSERT IN ARRAY:C227(asDateiListe;1;1)
	asDateiListe{1}:="d_"+$asOrdnerListe{$lauf}
End for 

  //Wenn wir nicht im Hauptverzeichnis sind "...." einfügen
  //If (Position(":";Substring($vsPfad;1;Length($vsPfad)-1))#0)
If (Length:C16($vsPfad)=0)
	COPY ARRAY:C226($asVolumes;asDateiListe)
	For ($lauf;1;Size of array:C274(asDateiListe))
		asDateiListe{$lauf}:="v_"+asDateiListe{$lauf}
	End for 
Else 
	INSERT IN ARRAY:C227(asDateiListe;1;1)
	asDateiListe{1}:="...."
End if 
