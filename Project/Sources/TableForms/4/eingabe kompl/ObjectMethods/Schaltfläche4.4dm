If (vi_AktuelleAnzeige<Size of array:C274(at_WegSpeicher))
	vi_AktuelleAnzeige:=vi_AktuelleAnzeige+1
	vt_WegSpeicher:=at_WegSpeicher{vi_AktuelleAnzeige}
Else 
	ALERT:C41("Am Ende!")
End if 