//%attributes = {}
  //Erwartet ein Datum zb "cuuent date" als $1 und gibt Textstring mit Wochentag zurück
Case of 
	: (Day number:C114($1)=1)
		$0:="Sonntag"
	: (Day number:C114($1)=2)
		$0:="Montag"
	: (Day number:C114($1)=3)
		$0:="Dienstag"
	: (Day number:C114($1)=4)
		$0:="Mittwoch"
	: (Day number:C114($1)=5)
		$0:="Donnerstag"
	: (Day number:C114($1)=6)
		$0:="Freitag"
	: (Day number:C114($1)=7)
		$0:="Samstag"
End case 