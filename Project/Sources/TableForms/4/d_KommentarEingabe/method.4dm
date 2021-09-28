Case of 
	: (Form event code:C388=On Load:K2:1)
		C_TEXT:C284(vt_AktuellerKommentar)
		C_BOOLEAN:C305(vb_Editieren)
		vt_AktuellerKommentar:=""
		vb_Editieren:=False:C215
		OBJECT SET VISIBLE:C603(*;"t_Warntext";False:C215)
		If (vt_KommentarSpeicher="")
			OBJECT SET VISIBLE:C603(*;"b_editieren";False:C215)
		Else 
			OBJECT SET VISIBLE:C603(*;"b_editieren";True:C214)
		End if 
End case 