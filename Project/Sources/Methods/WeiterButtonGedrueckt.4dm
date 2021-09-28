//%attributes = {}
  //Wird durch den Weiter-Button in den Interview-Formularen aufgerufen
  //$1 = Aufrufendes Formular oder"NoCheck"

$AufrufForm:=$1

If ($AufrufForm#"gen_OffenText")
	vantw:=EingabeSaeubern (vAntw)
End if 
If (EingabePruefen (vantw;$AufrufForm;[Bogen:6]Filter_generiert:14;[Bogen:6]ErlaubteWerte:15;[Bogen:6]MaxAnzEingabe:13;[Bogen:6]Solo:19;[Bogen:6]MaxWert:17;[Bogen:6]MinWert:16;[Bogen:6]KKA:18;[Bogen:6]Halboffen:26;[Bogen:6]AvgText:5))
	EingabeSchreiben 
	ACCEPT:C269
Else 
	GOTO OBJECT:C206(vantw)
End if 