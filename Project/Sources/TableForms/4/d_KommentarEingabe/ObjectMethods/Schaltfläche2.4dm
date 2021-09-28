If (vt_AktuellerKommentar="")
	ALERT:C41("Was wollen Sie speichern? - Ist ja gar nix drin!")
Else 
	If (Length:C16([TelefonNummer:4]Kommentar:6)>31000)
		[TelefonNummer:4]Kommentar:6:=Substring:C12([TelefonNummer:4]Kommentar:6;1;31000)
		ALERT:C41("Kommentarfeld würde zu lang - es wurde gekürzt auf 31.000 Zeichen!")
	End if 
	vt_AktuellerKommentar:=String:C10(Current date:C33)+" "+String:C10(Current time:C178)+"   "+Current user:C182+Char:C90(13)+vt_AktuellerKommentar+Char:C90(13)+"______________________________________"+Char:C90(13)
	If (vb_Editieren)
		[TelefonNummer:4]Kommentar:6:=Replace string:C233([TelefonNummer:4]Kommentar:6;vt_KommentarSpeicher;vt_AktuellerKommentar)
	Else 
		[TelefonNummer:4]Kommentar:6:=vt_AktuellerKommentar+[TelefonNummer:4]Kommentar:6
	End if 
	vt_KommentarSpeicher:=vt_AktuellerKommentar
	CANCEL:C270
End if 