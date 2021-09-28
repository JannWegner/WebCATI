CONFIRM:C162("GA auf dieser Basis drucken?")
If (OK=1)
	$viAktuelleSeite:=viSeite
	viSeite:=1
	PRINT SETTINGS:C106
	While (((viSeite*2)-1)<=Size of array:C274(atGA))
		Print form:C5([TelefonNummer:4];"GA")
		viSeite:=viSeite+1
	End while 
	PAGE BREAK:C6
	viSeite:=$viAktuelleSeite
End if 