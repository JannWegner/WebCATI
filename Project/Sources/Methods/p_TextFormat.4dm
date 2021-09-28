//%attributes = {}
  //Bringt einen in $1 übergebenen String in der Ausrichtung $2 auf die Breite von $3 
C_TEXT:C284($vsText;$1)
C_TEXT:C284($vsAusrichtung;$2)
C_LONGINT:C283($viSollBreite;$3)
$vsText:=$1
$vsAusrichtung:=$2
$viSollBreite:=$3

  //Text ggf. kürzen
If (Length:C16($vsText)>$viSollBreite)
	$vsText:=Substring:C12($vsText;1;$viSollBreite-1)+"&"
End if 

Case of 
	: ($vsAusrichtung="r")
		$0:=(" "*($viSollBreite-Length:C16($vsText)))+$vsText
	: ($vsAusrichtung="l")
		$0:=$vsText+(" "*($viSollBreite-Length:C16($vsText)))
	: ($vsAusrichtung="c")
		$viRestLaenge:=$viSollBreite-Length:C16($vsText)
		$viVorBlank:=$viRestLaenge\2
		$viNachBlank:=$viRestLaenge-$viVorBlank
		$0:=(" "*$viVorBlank)+$vsText+(" "*$viNachBlank)
		  //$0:=""
End case 