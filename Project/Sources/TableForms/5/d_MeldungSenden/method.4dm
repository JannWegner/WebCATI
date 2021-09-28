Case of 
	: (Form event code:C388=On Load:K2:1)
		SET WINDOW RECT:C444(100;100;650;330)
		C_TEXT:C284(vs_Empfaenger;vs_Text)
		C_DATE:C307(vd_EndeDatum)
		C_TIME:C306(vz_EndeZeit)
		C_POINTER:C301($vp_Array)
		C_LONGINT:C283($vi_ArrayPos;$vi_PID)
		ARRAY TEXT:C222(as_ClientList;80)
		
		GET REGISTERED CLIENTS:C650(as_ClientList;$ListeCharge)
		
		vs_Empfaenger:=""
		vs_Text:=""
		vd_EndeDatum:=Current date:C33
		vz_EndeZeit:=Current time:C178
	: (Form event code:C388=On Drop:K2:12)
		_O_DRAG AND DROP PROPERTIES:C607($vp_Array;$vi_ArrayPos;$vi_PID)
		If (($vi_ArrayPos<=Size of array:C274($vp_Array->)) & ($vi_ArrayPos>0))
			vs_Empfaenger:=$vp_Array->{$vi_ArrayPos}
		End if 
End case 