//%attributes = {}
  //Es wurde eine Datei gewaehlt
$vsDatei:=$1
$viLesenSchreiben:=$2

  //Test, ob Datei bereits existiert
$viDateiStatus:=Test path name:C476($vsDatei)

Case of 
	: ($viLesenSchreiben=0)
		  //Wir wollen eine Datei lesen
		Case of 
			: ($viDateiStatus=1)
				  //Alles OK
				$0:=$vsDatei
			: ($viDateiStatus=0)
				  //Ordner gewählt => geht nicht
				ALERT:C41("Sie haben einen Ordner markiert!")
				$0:=""
			: ($viDateiStatus<0)
				  //Datei gibt es nicht
				ALERT:C41("Datei gibt es nicht: "+$vsDatei)
				$0:=""
			Else 
				ALERT:C41("p_DateiWaehlen_DateiGewaehlt:"+Char:C90(13)+"Nicht erlaubter $viDateiStatus "+String:C10($viDateiStatus))
		End case 
	: ($viLesenSchreiben=1)
		  //Wir wollen eine Datei schreiben
		Case of 
			: ((Position:C15("@";$vsDatei)#0) | (Position:C15("*";$vsDatei)#0) | (Position:C15("?";$vsDatei)#0))
				ALERT:C41("Unerlaubtes Zeichen in "+$vsDatei)
				$0:=""
			: ($viDateiStatus=1)
				  //Datei gibt es schon => Nachfragen!
				CONFIRM:C162("Es gibt schon eine Datei "+$vsDatei;"Nochmal wählen";"Überschreiben")
				If (OK=1)
					$0:=""
				Else 
					DELETE DOCUMENT:C159($vsDatei)
					$0:=$vsDatei
				End if 
			: ($viDateiStatus=0)
				  //Ordner gewählt => geht nicht
				ALERT:C41("Sie haben einen Ordner markiert!")
				$0:=""
			: ($viDateiStatus<0)
				$0:=$vsDatei
			Else 
				ALERT:C41("p_DateiWaehlen_DateiGewaehlt:"+Char:C90(13)+"Nicht erlaubter $viDateiStatus "+String:C10($viDateiStatus))
		End case 
	Else 
		ALERT:C41("p_DateiWaehlen_DateiGewaehlt:"+Char:C90(13)+"Nicht erlaubter $viLesenSchreiben "+String:C10($viLesenSchreiben))
End case 