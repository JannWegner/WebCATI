//%attributes = {}
  //Standardlänge und Werte für Bogen setzen
  //Feld verlängern
C_LONGINT:C283($viDG_Spalte)
C_TEXT:C284($KKZ)
$Ziel:=$1

$Ziel->:=Char:C90(0)*([Variablen:5]AnzahlKarten:28*160)

  //Karten und UmfrageKZ setzen
For ($Karte;1;[Variablen:5]AnzahlKarten:28)
	If ($Karte=1)
		$Buchstabe:=""
	Else 
		$Buchstabe:=Char:C90(63+$Karte)
	End if 
	  //FbNr
	For ($FbNrPos;1;[Variablen:5]LaengeFbNr:25)
		$viDG_Spalte:=sp2off ("C"+$Buchstabe+String:C10($FbNrPos;"00"))
		BinaerSchreiben ($Ziel;Substring:C12(String:C10([TelefonNummer:4]AdrFBNr:20;("0"*[Variablen:5]LaengeFbNr:25));$FbNrPos;1);$viDG_Spalte)
	End for 
	  //UmfrageKZ
	$viDG_Spalte:=sp2off ("C"+$Buchstabe+String:C10([Variablen:5]PosUmfrKZ:26;"00"))
	BinaerSchreiben ($Ziel;String:C10([Variablen:5]UmfrKZ:29);$viDG_Spalte)
	
	  //KKZ
	$viDG_Spalte:=sp2off ("C"+$Buchstabe+String:C10([Variablen:5]PosKKZ:27;"00"))
	Case of 
		: ($Karte<=9)
			$KKZ:=String:C10($Karte)
		: ($Karte=10)
			$KKZ:="0"
		: ($Karte=11)
			$KKZ:="X"
		: ($Karte=12)
			$KKZ:="Y"
		Else 
			ALERT:C41("Sie wollen auf Karte "+String:C10($Karte)+" schreiben - Ich kann aber nur 12 Karten :-((")
	End case 
	BinaerSchreiben ($Ziel;$KKZ;$viDG_Spalte)
End for 

