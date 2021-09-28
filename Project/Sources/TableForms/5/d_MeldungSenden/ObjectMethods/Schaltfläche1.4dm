GET REGISTERED CLIENTS:C650(as_ClientList;$ListeCharge)
Case of 
	: (vs_Text="")
		ALERT:C41("Kein Meldungstext!")
	: ((Find in array:C230(as_ClientList;vs_Empfaenger)=-1) & (vs_Empfaenger#Char:C90(64)))
		ALERT:C41("'"+vs_Empfaenger+"' ist nicht angemeldet!")
	Else 
		$vi_PID:=Execute on server:C373("sp_SendMessage";16000;"Mess_"+vs_Empfaenger+"_"+String:C10(vd_EndeDatum)+String:C10(vz_EndeZeit);vs_Empfaenger;vs_Text;vd_EndeDatum;vz_EndeZeit)
		CANCEL:C270
End case 