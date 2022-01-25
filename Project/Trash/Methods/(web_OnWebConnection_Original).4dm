//%attributes = {}
C_LONGINT:C283($vl_AktSessionNr)
C_TEXT:C284($vt_SessionID; $vt_CheckSessionResult; vt_WebZusatzText; vt_WebUser; vt_WebUmfrage)
ARRAY TEXT:C222(at_FormVarNames; 0)
ARRAY TEXT:C222(at_FormVarValues; 0)

vt_WebZusatzText:=""
$vt_SessionID:=WEB Get current session ID:C1162
WEB GET VARIABLES:C683(at_FormVarNames; at_FormVarValues)


// Headers
If (1=1)
	C_TEXT:C284($0; $1; $headerName_t)
	C_LONGINT:C283($foundat_l)
	
	ARRAY TEXT:C222(web_requestHeaderNames_at; 0)
	ARRAY TEXT:C222(web_requestHeaderValues_at; 0)
	
	WEB GET HTTP HEADER:C697(web_requestHeaderNames_at; web_requestHeaderValues_at)
	
End if 

If (Size of array:C274(at_FormVarValues)>0)
	For ($vl_Lauf; 1; Size of array:C274(at_FormVarValues))
		at_FormVarNames{$vl_Lauf}:=p_Normalize(at_FormVarNames{$vl_Lauf})
		at_FormVarValues{$vl_Lauf}:=p_Normalize(at_FormVarValues{$vl_Lauf})
	End for 
End if 

$vl_AktSessionNr:=p_CheckSession


// Hier steht Status/$vt_CheckSessionResult für das Formular, das als nächstes angezeigt wird

Case of 
	: (<>ao_SessionObject{$vl_AktSessionNr}.State="Logout")  // Das Tschüß-Formular wird angezeigt
		WEB SEND FILE:C619("Ende.shtml")
		p_ResetSession($vt_SessionID)
		
	: (<>ao_SessionObject{$vl_AktSessionNr}.State="Status")  // Der HTML-Status wird angezeigt
		WEB SEND FILE:C619("Status.shtml")
		
	: (<>ao_SessionObject{$vl_AktSessionNr}.State="Login")  // Der Login-Dialog wird angezeigt
		vt_WebZusatzText:=<>ao_SessionObject{$vl_AktSessionNr}.StateAdd
		If (vt_WebZusatzText#"")
			p_ResetSession($vt_SessionID)
		End if 
		WEB SEND FILE:C619("Login.shtml")
		
	: (<>ao_SessionObject{$vl_AktSessionNr}.State="Umfragewahl")  // Der Umfrage-Wahl-Dialog wird angezeigt
		ALL RECORDS:C47([Variablen:5])
		ORDER BY:C49([Variablen:5]; [Variablen:5]EingerichtetAm:40; <)
		WEB SEND FILE:C619("Umfrage.shtml")
		
	: (<>ao_SessionObject{$vl_AktSessionNr}.State="AdressWahl")  // Der Adress-Auswahl-Dialog wird angezeigt
		vt_WebZusatzText:=<>ao_SessionObject{$vl_AktSessionNr}.StateAdd
		vt_WebUser:=<>ao_SessionObject{$vl_AktSessionNr}.User
		vt_WebUmfrage:=<>ao_SessionObject{$vl_AktSessionNr}.Umfrage
		WEB SEND FILE:C619("AdressWahl.shtml")
		
	: (<>ao_SessionObject{$vl_AktSessionNr}.State="Interview")  // Wir haben eine gültige Adresse und sind irgendwo im Interview
		// <>ao_SessionObject{$vl_AktSessionNr}.Formular enthält das aktuell angezeigte Formular, das auszuwerten ist
		p_WebInterview($vl_AktSessionNr)
		// <>ao_SessionObject{$vl_AktSessionNr}.Formular enthält das Formular, das als nächstes angezeigt wird
End case 

ARRAY TEXT:C222(at_FormVarNames; 0)
ARRAY TEXT:C222(at_FormVarValues; 0)
