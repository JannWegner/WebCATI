If (vi_ZeitProFrageAktSeite>1)
	vi_ZeitProFrageAktSeite:=vi_ZeitProFrageAktSeite-1
	p_ZeitProFrage_Seitenanzeige (vi_ZeitProFrageAktSeite)
Else 
	ALERT:C41("Wir sind am Ende")
End if 