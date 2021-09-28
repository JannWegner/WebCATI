//%attributes = {}
  //Setzt Fenster auf eine Mindestgroesse
  //Aufruf: p_FensterAnpassen(Breite;Hoehe)

$viBreite:=$1
$viHoehe:=$2

GET WINDOW RECT:C443($vlWinLinks;$vlWinOben;$vlWinRechts;$vlWinUnten)
If (($vlWinUnten-$vlWinOben)<$viHoehe)
	$vlWinUnten:=$vlWinOben+$viHoehe
End if 
If (($vlWinRechts-$vlWinLinks)<$viBreite)
	$vlWinRechts:=$vlWinLinks+$viBreite
End if 
SET WINDOW RECT:C444($vlWinLinks;$vlWinOben;$vlWinRechts;$vlWinUnten)

