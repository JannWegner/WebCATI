C_LONGINT:C283($vl_Offset;$vl_TrennerPos)
C_LONGINT:C283(vi_AktuelleAnzeige)
C_BLOB:C604($vbl_WegSpeicherBlog)
C_TEXT:C284(vt_WegSpeicher;vt_Datum)
ARRAY TEXT:C222(at_WegSpeicher;0)
$vbl_WegSpeicherBlog:=[TelefonNummer:4]WegspeicherBLOB:50
EXPAND BLOB:C535($vbl_WegSpeicherBlog)
$vl_Offset:=0
While ($vl_Offset#BLOB size:C605($vbl_WegSpeicherBlog))
	INSERT IN ARRAY:C227(at_WegSpeicher;Size of array:C274(at_WegSpeicher)+1)
	at_WegSpeicher{Size of array:C274(at_WegSpeicher)}:=""
	BLOB TO VARIABLE:C533($vbl_WegSpeicherBlog;vt_WegSpeicher;$vl_Offset)
	  //Datum/Uhrzeit auslesen 
	$vl_TrennerPos:=Position:C15(Char:C90(13);vt_WegSpeicher)
	vt_Datum:=Substring:C12(vt_WegSpeicher;1;$vl_TrennerPos-1)
	vt_WegSpeicher:=Substring:C12(vt_WegSpeicher;$vl_TrennerPos+1)
	While (Length:C16(vt_WegSpeicher)>0)
		$vl_TrennerPos:=Position:C15(Char:C90(13);vt_WegSpeicher)
		at_WegSpeicher{Size of array:C274(at_WegSpeicher)}:=Substring:C12(vt_WegSpeicher;1;$vl_TrennerPos-1)+Char:C90(13)+at_WegSpeicher{Size of array:C274(at_WegSpeicher)}
		vt_WegSpeicher:=Substring:C12(vt_WegSpeicher;$vl_TrennerPos+1)
	End while 
	at_WegSpeicher{Size of array:C274(at_WegSpeicher)}:=vt_Datum+Char:C90(13)+at_WegSpeicher{Size of array:C274(at_WegSpeicher)}
	
End while 
vi_AktuelleAnzeige:=Size of array:C274(at_WegSpeicher)
vt_WegSpeicher:=at_WegSpeicher{vi_AktuelleAnzeige}