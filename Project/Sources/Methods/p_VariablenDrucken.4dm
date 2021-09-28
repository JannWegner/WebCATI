//%attributes = {}
  //Druckt das Variablen-Formular
$vUmfrage:=$1

QUERY:C277([Variablen:5];[Variablen:5]Umfrage:3=$vUmfrage)
If (Records in selection:C76([Variablen:5])=1)
	FORM SET OUTPUT:C54([Variablen:5];"Eingabe")
	PRINT RECORD:C71([Variablen:5])
Else 
	ALERT:C41("p_VariablenDrucken: "+$vUmfrage+Char:C90(13)+"Nicht genau einen Datensatz gefunden")
End if 

