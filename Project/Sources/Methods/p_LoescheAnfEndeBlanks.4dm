//%attributes = {}
  //Löscht in einem als $1 übergebenen String führende und schließende Blanks
  //und gibt das Ergebnis als $0 zurück
$vtRestText:=$1

If ($vtRestText#"")
	  //Am Ende
	While ($vtRestText[[Length:C16($vtRestText)]])=" "
		$vtRestText:=Substring:C12($vtRestText;1;Length:C16($vtRestText)-1)
	End while 
	
	  //Am Anfang
	While ($vtRestText[[1]])=" "
		$vtRestText:=Substring:C12($vtRestText;2)
	End while 
End if 

$0:=$vtRestText
