//%attributes = {}
If (vb_WegInBlobSpeichern)
	C_TEXT:C284($vt_WegSpeicher)
	C_BLOB:C604($vbl_WegSpeicherBlog)
	$vt_WegSpeicher:=String:C10(Current date:C33)+"/"+String:C10(Current time:C178)+Char:C90(13)+vt_AktuellerWeg
	$vbl_WegSpeicherBlog:=[TelefonNummer:4]WegspeicherBLOB:50
	BLOB PROPERTIES:C536($vbl_WegSpeicherBlog;$viCompressed)
	If (Not:C34($viCompressed=Is not compressed:K22:11))
		EXPAND BLOB:C535($vbl_WegSpeicherBlog)
	End if 
	VARIABLE TO BLOB:C532($vt_WegSpeicher;$vbl_WegSpeicherBlog;*)
	COMPRESS BLOB:C534($vbl_WegSpeicherBlog;2)
	[TelefonNummer:4]WegspeicherBLOB:50:=$vbl_WegSpeicherBlog
End if 