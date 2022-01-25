//%attributes = {}
// p_CheckSession
// Jann Wegner
// 20210419

// Blackbox: Checkt die aktuelle Session-ID gegen was auch immer.
// Falls neu: Wird neu angelegt
// Falls vorhanden: Es wird ein Kontext zurückgegeben

C_TEXT:C284($vt_SessionID; $vt_Status)
C_OBJECT:C1216($vo_Result)
$vt_SessionID:=WEB Get current session ID:C1162
$vl_AktSessionNr:=Find in array:C230(<>at_SessionID; $vt_SessionID)

// Hier ist Status das, wo wir herkommen
// Neue Session-ID?
If ($vl_AktSessionNr=-1)
	While (Semaphore:C143("sema_NeueSession"; 600))
		IDLE:C311
	End while 
	C_OBJECT:C1216($vo_SessionObject)
	C_LONGINT:C283($vl_FindPos)
	$vo_SessionObject:=New object:C1471("User"; ""; "Created"; p_timestampD; "LastAccess"; p_timestampD; "State"; "Login"; "StateAdd"; ""; "Umfrage"; ""; "FbNr"; 0; "AdrPKID"; ""; "Formular"; "")
	
	$vl_FindPos:=Find in array:C230(<>at_SessionID; "")
	If ($vl_FindPos=-1)
		APPEND TO ARRAY:C911(<>at_SessionID; $vt_SessionID)
		APPEND TO ARRAY:C911(<>ao_SessionObject; $vo_SessionObject)
		$vl_AktSessionNr:=Size of array:C274(<>at_SessionID)
	Else 
		<>at_SessionID{$vl_FindPos}:=$vt_SessionID
		<>ao_SessionObject{$vl_FindPos}:=$vo_SessionObject
		$vl_AktSessionNr:=S$vl_FindPos
	End if 
	CLEAR SEMAPHORE:C144("sema_NeueSession")
End if 


Case of 
	: ((Find in array:C230(at_FormVarNames; "Action")=1) & (Find in array:C230(at_FormVarValues; "Status")=1))  // In der URl wurde "?action=status" mitgegeben
		<>ao_SessionObject{$vl_AktSessionNr}.State:="Status"
		
	: (Find in array:C230(at_FormVarNames; "Ende")=1)  // Es wurde in einem beliebigen Formular der Beenden-Button geklickt
		<>ao_SessionObject{$vl_AktSessionNr}.State:="Logout"
		
	: (<>ao_SessionObject{$vl_AktSessionNr}.State="Interview")
		// Wir machen hier nix - das Interview geht weiter ...
		
	: ((<>ao_SessionObject{$vl_AktSessionNr}.State="Login") & (Find in array:C230(at_FormVarNames; "Name")=1) & (Find in array:C230(at_FormVarNames; "Kennwort")=2))  // Es war der Login-Dialog
		<>ao_SessionObject{$vl_AktSessionNr}.State:=Choose:C955(web_Authenticate(at_FormVarValues{1}; at_FormVarValues{2}); "Umfragewahl"; "Login")
		If (<>ao_SessionObject{$vl_AktSessionNr}.State="Login")  // Falsche Anmeldedaten -> nocheinmal
			<>ao_SessionObject{$vl_AktSessionNr}.StateAdd:="Mit diesem Nutzernamen/Kennwort ist leider keine Anmeldung möglich!"
		Else 
			<>ao_SessionObject{$vl_AktSessionNr}.User:=at_FormVarValues{Find in array:C230(at_FormVarNames; "Name")}
		End if 
		
	: ((<>ao_SessionObject{$vl_AktSessionNr}.State="Umfragewahl") & (Find in array:C230(at_FormVarNames; "Umfrage")=1) & (Find in array:C230(at_FormVarNames; "Umfragewahl")=2))  // Es war der Umfrage-Dialog mit Antwort
		If (ds:C1482.Variablen.query("UmfrageAnzeigeName = :1"; at_FormVarValues{1}).length=1)
			<>ao_SessionObject{$vl_AktSessionNr}.Umfrage:=at_FormVarValues{1}
			<>ao_SessionObject{$vl_AktSessionNr}.State:="AdressWahl"
		Else 
			WEB SEND TEXT:C677("UmfrageWahl: Da stimmt was nicht!")
		End if 
		
	: ((<>ao_SessionObject{$vl_AktSessionNr}.State="Umfragewahl") & (Find in array:C230(at_FormVarNames; "Umfragewahl")=1))  // Es war der Umfrage-Dialog ohne Antwort
		<>ao_SessionObject{$vl_AktSessionNr}.State:="Umfragewahl"
		
	: (<>ao_SessionObject{$vl_AktSessionNr}.State="AdressWahl")  // Es war der Adress-Wahl-Dialog
		$vo_Result:=New object:C1471("AdrFbNr"; 0; "AdrPKID"; ""; "Text"; "")
		Case of 
			: (Find in array:C230(at_FormVarNames; "ButtonZufall")=1)  // Zufalls-Adresse soll gezogen werden
				$vo_Result:=p_WebAdresseHolen(<>ao_SessionObject{$vl_AktSessionNr})
				If ($vo_Result.AdrFbNr=0)
					<>ao_SessionObject{$vl_AktSessionNr}.State:="AdressWahl"
					<>ao_SessionObject{$vl_AktSessionNr}.StateAdd:="Keine Adressen mehr verfügbar!"
				Else 
					<>ao_SessionObject{$vl_AktSessionNr}.State:="Interview"
					<>ao_SessionObject{$vl_AktSessionNr}.StateAdd:=""
				End if 
				
			: ((Find in array:C230(at_FormVarNames; "ButtonFbNr")=2) & (Find in array:C230(at_FormVarNames; "FbNr")=1))  // Es wurde (ev.) eine Adress-Nummer eingegeben
				If (Num:C11(at_FormVarValues{1})>0)  // Es wurde eine FbNr eingegeben
					<>ao_SessionObject{$vl_AktSessionNr}.FbNr:=Num:C11(at_FormVarValues{1})  // Für Übergabe an p_WebAdresseHolen
					$vo_Result:=p_WebAdresseHolen(<>ao_SessionObject{$vl_AktSessionNr})
					<>ao_SessionObject{$vl_AktSessionNr}.StateAdd:=$vo_Result.Text
					<>ao_SessionObject{$vl_AktSessionNr}.FbNr:=$vo_Result.AdrFbNr
				Else   // Keine FB-Nr eingegeben
					<>ao_SessionObject{$vl_AktSessionNr}.StateAdd:="Keine Fb-Nr. eingegeben!"
				End if 
				<>ao_SessionObject{$vl_AktSessionNr}.State:=Choose:C955(<>ao_SessionObject{$vl_AktSessionNr}.FbNr=0; "AdressWahl"; "Interview")
			Else 
				WEB SEND TEXT:C677("AdressWahl: Da stimmt was nicht!")
		End case 
		
		Case of 
			: ($vo_Result.AdrFbNr#0)
				<>ao_SessionObject{$vl_AktSessionNr}.FbNr:=$vo_Result.AdrFbNr
				<>ao_SessionObject{$vl_AktSessionNr}.State:="Interview"
				<>ao_SessionObject{$vl_AktSessionNr}.Formular:=""
				<>ao_SessionObject{$vl_AktSessionNr}.AdrPKID:=$vo_Result.AdrPKID
		End case 
		
End case 

//<>ao_SessionObject{$vl_AktSessionNr}.LastAccess:=Choose($vl_AktSessionNr#-1;p_timestampD ;"")
$0:=$vl_AktSessionNr

// Hier steht Status für das Formular, das als nächstes angezeigt wird
