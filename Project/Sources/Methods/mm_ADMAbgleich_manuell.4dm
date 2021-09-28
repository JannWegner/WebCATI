//%attributes = {}
CONFIRM:C162("ADM-Abgleich starten (Akt. 'sperrnummern.csv' ist auf dem Server?)")
If (OK=1)
	$spProcessID:=New process:C317("m_ADMAbgleich_manuell";3*16000;"Warten auf ADM-Abgleich-Ende")
End if 
