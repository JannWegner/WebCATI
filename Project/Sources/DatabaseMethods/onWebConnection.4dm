// On Web Connection
// Jann Wegner
// 20210928

var $1; $vt_URL; $vt_NextURL : Text
var vt_WebZusatzText : Text

$vt_URL:=$1
$vt_NextURL:=""
vt_WebZusatzText:=""

ARRAY TEXT:C222(at_FormVarNames; 0)
ARRAY TEXT:C222(at_FormVarValues; 0)
WEB GET VARIABLES:C683(at_FormVarNames; at_FormVarValues)

ARRAY TEXT:C222(web_requestHeaderNames_at; 0)
ARRAY TEXT:C222(web_requestHeaderValues_at; 0)
WEB GET HTTP HEADER:C697(web_requestHeaderNames_at; web_requestHeaderValues_at)

Case of 
	: ($vt_URL="/Reset")  // Reset angefordert
		web_SessionReset
		
	: (Session:C1714.isGuest() & ($vt_URL#"/InterviewerLogin"))  // Keine gültige Anforderung
		$vt_NextURL:="404 - Page not found.shtml"
		
		
	: (Not:C34(Session:C1714.isGuest()))  // Wir haben eine laufende Sitzung mit gültigem Nutzer!
		Case of 
			: (Session:C1714.storage.Info.LetzteSeite="Adresse")  // Kommt er von der Adresswahlseite ?
				Case of 
					: ((at_FormVarNames{1}="Aktion") & (at_FormVarValues{1}="Ende"))  // Abbruch angefordert
						web_SessionReset
						
					Else   // Will Adresse haben
						Case of 
							: ((at_FormVarNames{1}="Aktion") & (at_FormVarValues{1}="Zufall"))  // Zufallsadresse angefordert
								web_SessionUpdate(New collection:C1472("FbNr"; 0))
								
							: ((at_FormVarNames{1}="FbNr") & (at_FormVarValues{1}#"0") & (at_FormVarNames{2}="Aktion") & (at_FormVarValues{2}="Nummer"))  // Konkrete Adresse angefordert
								web_SessionUpdate(New collection:C1472("FbNr"; Num:C11(at_FormVarValues{1})))
							Else 
								web_Error
						End case 
						web_AdresseHolen(Session:C1714.storage.Info)
				End case 
				
			: (Session:C1714.storage.Info.LetzteSeite="Umfragewahl")  // Kommt er von der Umfragewahlseite ?
				If ((at_FormVarNames{1}="Umfrage") & (at_FormVarValues{1}#""))  // Tatsächlich Umfrage gewählt?
					web_SessionUpdate(New collection:C1472("Umfrage"; at_FormVarValues{1}; "LetzteSeite"; "Adresse"))
					$vt_NextURL:="AdressWahl.shtml"
				Else   // Nochmal Umfrage wählen
					ALL RECORDS:C47([Variablen:5])
					ORDER BY:C49([Variablen:5]; [Variablen:5]EingerichtetAm:40; <)
					web_SessionUpdate(New collection:C1472("LetzteSeite"; "Umfrage"))
					vt_WebZusatzText:="Bitte Umfrage wählen!"
					$vt_NextURL:="Umfrage.shtml"
				End if 
		End case 
		
	: (Session:C1714.isGuest() & ($vt_URL="/InterviewerLogin") & (Size of array:C274(at_FormVarNames)=2))  // LoginFormular wurde ausgefüllt
		If ((at_FormVarNames{1}="Name") & (at_FormVarNames{2}="Kennwort") & (at_FormVarValues{1}#"") & (at_FormVarValues{2}#""))
			If (p_Authenticate(at_FormVarValues{1}; at_FormVarValues{2}))  // Es ist ein gültiger Nutzer
				var $vo_info : Object
				$vo_info:=New object:C1471("userName"; at_FormVarValues{1})
				Session:C1714.setPrivileges($vo_info)
				Use (Session:C1714.storage)
					Session:C1714.storage.Info:=New shared object:C1526("LetzteSeite"; "Umfragewahl"; "InfoText"; "")
				End use 
				ALL RECORDS:C47([Variablen:5])
				ORDER BY:C49([Variablen:5]; [Variablen:5]EingerichtetAm:40; <)
				$vt_NextURL:="Umfrage.shtml"
			Else   // Ungültige Zugangsdaten
				Use (Session:C1714.storage)
					Session:C1714.storage.Info:=New shared object:C1526("LetzteSeite"; "Login")
				End use 
				vt_WebZusatzText:="    !! Ungültige Zugangsdaten !!"
				$vt_NextURL:="Login.shtml"
			End if 
		Else   // Ungültige Parameter von Login-Seite
			WEB SEND TEXT:C677("falsche Param")
		End if 
		
	: (Session:C1714.isGuest() & ($vt_URL="/InterviewerLogin"))  // Login-Seite wurde korrekt angefordert
		$vt_NextURL:="Login.shtml"
		
End case 

If ($vt_NextURL#"")
	WEB SEND FILE:C619($vt_NextURL)
End if 