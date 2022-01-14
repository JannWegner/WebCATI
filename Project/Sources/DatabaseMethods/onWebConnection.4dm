// On Web Connection
// Jann Wegner
// 20210928

var $1; $vt_URL : Text
var vt_WebZusatzText : Text

$vt_URL:=$1
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
		Use (Session:C1714.storage)
			Session:C1714.storage.Info:=New shared object:C1526("LetzteURL"; "404")
		End use 
		
		
	: (Not:C34(Session:C1714.isGuest()))  // Wir haben eine laufende Sitzung mit gültigem Nutzer!
		Case of 
			: (Session:C1714.storage.Info.LetzteURL="Telefon")  // Kommt er von der Telefon-Seite ?
				var $vl_TelefonPos; $vl_SendenPos; $vl_NeuKommTextPos : Integer
				$vl_TelefonPos:=Find in array:C230(at_FormVarNames; "Telefon")
				$vl_SendenPos:=Find in array:C230(at_FormVarNames; "Senden")
				$vl_NeuKommTextPos:=Find in array:C230(at_FormVarNames; "NeuKommText")
				Case of 
					: (($vl_SendenPos#-1) & ($vl_TelefonPos=-1))  // Keine Eingabe
						web_SessionUpdate(New collection:C1472("InfoText"; "Keine Auswahl getroffen"))
					: (($vl_SendenPos#-1) & ($vl_TelefonPos#-1))  // Es gibt eine Eingabe
						web_FormWeiterMit("Telefon"; at_FormVarValues{$vl_TelefonPos})
				End case 
			: (Session:C1714.storage.Info.LetzteURL="Adresse")  // Kommt er von der Adresswahlseite ?
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
						If (Session:C1714.storage.Info.FbNr=0)  // Keine Adresse gefunden
							web_SessionUpdate(New collection:C1472("LetzteURL"; "Adresse"))
						Else 
							web_SessionUpdate(New collection:C1472("LetzteURL"; "Interview"))
							web_Interview
						End if 
				End case 
				
			: (Session:C1714.storage.Info.LetzteURL="Umfrage")  // Kommt er von der Umfragewahlseite ?
				If ((at_FormVarNames{1}="Umfrage") & (at_FormVarValues{1}#""))  // Tatsächlich Umfrage gewählt?
					web_SessionUpdate(New collection:C1472("Umfrage"; at_FormVarValues{1}; "UmfragePKID"; ds:C1482.Variablen.query("UmfrageAnzeigeName = :1"; at_FormVarValues{1}).first().PKID; "LetzteURL"; "Adresse"))
				Else   // Nochmal Umfrage wählen
					ALL RECORDS:C47([Variablen:5])
					ORDER BY:C49([Variablen:5]; [Variablen:5]EingerichtetAm:40; <)
					web_SessionUpdate(New collection:C1472("LetzteURL"; "Umfrage"))
					vt_WebZusatzText:="Bitte Umfrage wählen!"
				End if 
		End case 
		
	: (Session:C1714.isGuest() & ($vt_URL="/InterviewerLogin") & (Size of array:C274(at_FormVarNames)=2))  // LoginFormular wurde ausgefüllt
		If ((at_FormVarNames{1}="Name") & (at_FormVarNames{2}="Kennwort") & (at_FormVarValues{1}#"") & (at_FormVarValues{2}#""))
			If (p_Authenticate(at_FormVarValues{1}; at_FormVarValues{2}))  // Es ist ein gültiger Nutzer
				var $vo_info : Object
				$vo_info:=New object:C1471("userName"; at_FormVarValues{1})
				Session:C1714.setPrivileges($vo_info)
				web_SessionUpdate(New collection:C1472("LetzteURL"; "Umfrage"; "InfoText"; ""))
				ALL RECORDS:C47([Variablen:5])
				ORDER BY:C49([Variablen:5]; [Variablen:5]EingerichtetAm:40; <)
			Else   // Ungültige Zugangsdaten
				web_SessionUpdate(New collection:C1472("LetzteURL"; "Login"))
				vt_WebZusatzText:="    !! Ungültige Zugangsdaten !!"
			End if 
		Else   // Ungültige Parameter von Login-Seite
			WEB SEND TEXT:C677("falsche Param")
		End if 
		
	: (Session:C1714.isGuest() & ($vt_URL="/InterviewerLogin"))  // Login-Seite wurde korrekt angefordert
		Use (Session:C1714.storage)
			Session:C1714.storage.Info:=New shared object:C1526("LetzteURL"; "Login"; "InfoText"; "")
		End use 
		
End case 

If (Session:C1714.storage.Info.LetzteURL#"")
	WEB SEND FILE:C619(Session:C1714.storage.Info.LetzteURL+".shtml")
	web_SessionUpdate(New collection:C1472("InfoText"; ""))
End if 