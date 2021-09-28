//%attributes = {}
  //Liest die Namen aller Felder der Datei Telefonnummer aus und legt sie
  //im Array asFeldNamenTelNr ab

$viAnzahlFelder:=Get last field number:C255(6)
ARRAY TEXT:C222(asFeldNamenTelNr;$viAnzahlFelder)
For ($lauf;1;$viAnzahlFelder)
	asFeldNamenTelNr{$lauf}:=Field name:C257(6;$lauf)
End for 