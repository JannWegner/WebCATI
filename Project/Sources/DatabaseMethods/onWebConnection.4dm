// On Web Connection
// Jann Wegner
// 20220125-20210928

var $1; $3; vt_URL; vt_IP : Text
var vt_WebZusatzText : Text
var e_AktTelefonNummer : Object
var $vl_DatPos; $vl_ZeitPos; $vl_SendenPos; $vl_AbbruchPos; $vl_NummerPos; $vl_APPos; $vl_NeuKommTextPos; $vl_TelefonPos; $vl_EndePos : Integer

vt_URL:=$1
vt_IP:=$3
vt_WebZusatzText:=""

ARRAY TEXT:C222(at_FormVarNames; 0)
ARRAY TEXT:C222(at_FormVarValues; 0)
WEB GET VARIABLES:C683(at_FormVarNames; at_FormVarValues)

ARRAY TEXT:C222(web_requestHeaderNames_at; 0)
ARRAY TEXT:C222(web_requestHeaderValues_at; 0)
WEB GET HTTP HEADER:C697(web_requestHeaderNames_at; web_requestHeaderValues_at)

// Variablen auslesen
$vl_DatPos:=Find in array:C230(at_FormVarNames; "NeuesDatum")
$vl_ZeitPos:=Find in array:C230(at_FormVarNames; "NeueZeit")
$vl_SendenPos:=Find in array:C230(at_FormVarNames; "Senden")
$vl_AbbruchPos:=Find in array:C230(at_FormVarNames; "Abbruch")
$vl_NummerPos:=Find in array:C230(at_FormVarNames; "NeueTelNummer")
$vl_APPos:=Find in array:C230(at_FormVarNames; "NeuerAP")
$vl_NeuKommTextPos:=Find in array:C230(at_FormVarNames; "NeuKommText")
$vl_TelefonPos:=Find in array:C230(at_FormVarNames; "Telefon")
$vl_EndePos:=Find in array:C230(at_FormVarNames; "Ende")

Case of 
	: (vt_URL="/favicon.ico")  // Einfach ignorieren (wird von Chrome angesprochen)
		//
		
	: (vt_URL="/Reset")  // Reset angefordert
		web_SessionReset
		
	: (Session:C1714.isGuest() & (vt_URL#"/InterviewerLogin"))  // Keine gültige Anforderung
		Use (Session:C1714.storage)
			Session:C1714.storage.Info:=New shared object:C1526("LetzteURL"; "404")
			web_NewLog("404")
		End use 
		
	: (Not:C34(Session:C1714.isGuest()))  // Wir haben eine laufende Sitzung mit gültigem Nutzer!
		Case of 
			: (Session:C1714.storage.Info.LetzteURL="Interview")  // Kommt er von der Interview-Seite ?
				web_FormWeiterMit("Interview"; Choose:C955($vl_SendenPos#-1; "OK"; "Abbruch"); $vl_NeuKommTextPos)
				
			: (Session:C1714.storage.Info.LetzteURL="Abnahme")  // Kommt er von der Abbruch-Seite ?
				web_FormWeiterMit("Abnahme"; at_FormVarValues{$vl_TelefonPos}; $vl_NeuKommTextPos)
				
			: (Session:C1714.storage.Info.LetzteURL="Abbruch")  // Kommt er von der Abbruch-Seite ?
				web_FormWeiterMit("Abbruch"; $vl_NeuKommTextPos)
				
			: (Session:C1714.storage.Info.LetzteURL="TerminEnde")  // Kommt er von der Termin-Ende-Seite ?
				web_FormWeiterMit("TerminEnde"; $vl_NeuKommTextPos)
				
			: (Session:C1714.storage.Info.LetzteURL="Termin")  // Kommt er von der Termin-Seite ?
				web_FormWeiterMit("Termin"; web_Webdate2Date(at_FormVarValues{$vl_DatPos}); web_WebTime2Time(at_FormVarValues{$vl_ZeitPos}); $vl_NummerPos; $vl_APPos; $vl_NeuKommTextPos)
				
			: (Session:C1714.storage.Info.LetzteURL="Telefon")  // Kommt er von der Telefon-Seite ?
				Case of 
					: (($vl_SendenPos#-1) & ($vl_TelefonPos#-1))  // Es gibt eine Eingabe
						web_FormWeiterMit("Telefon"; at_FormVarValues{$vl_TelefonPos}; $vl_NeuKommTextPos)
					: (($vl_EndePos#-1) & ($vl_TelefonPos#-1))  // Sitzungsende
						web_SessionReset
						web_SessionUpdate(New collection:C1472("LetzteURL"; "Ende"))
					Else 
						web_NewLog("Undefined"; Session:C1714.userName; "")
						ALERT:C41("Undefinierter Zustand!")
				End case 
			: (Session:C1714.storage.Info.LetzteURL="Adresse")  // Kommt er von der Adresswahlseite ?
				Case of 
					: ((at_FormVarNames{1}="Aktion") & (at_FormVarValues{1}="Ende"))  // Abbruch angefordert
						web_SessionReset
						web_SessionUpdate(New collection:C1472("LetzteURL"; "Ende"))
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
							e_AktTelefonNummer:=ds:C1482.TelefonNummer.query("PKID = :1"; Session:C1714.storage.Info.AdrPKID)[0]
							web_SessionUpdate(New collection:C1472("LetzteURL"; "Telefon"))
						End if 
				End case 
				
			: (Session:C1714.storage.Info.LetzteURL="Umfrage")  // Kommt er von der Umfragewahlseite ?
				Case of 
					: (at_FormVarNames{1}="Ende")
						web_SessionReset
						web_SessionUpdate(New collection:C1472("LetzteURL"; "Ende"))
					: ((at_FormVarNames{1}="Umfrage") & (at_FormVarValues{1}#""))  // Tatsächlich Umfrage gewählt?
						web_SessionUpdate(New collection:C1472("Umfrage"; at_FormVarValues{1}; "UmfragePKID"; ds:C1482.Variablen.query("UmfrageAnzeigeName = :1"; at_FormVarValues{1}).first().PKID; "LetzteURL"; "Adresse"))
					Else   // Nochmal Umfrage wählen
						ALL RECORDS:C47([Variablen:5])
						ORDER BY:C49([Variablen:5]; [Variablen:5]EingerichtetAm:40; <)
						web_SessionUpdate(New collection:C1472("LetzteURL"; "Umfrage"))
						vt_WebZusatzText:="Bitte Umfrage wählen!"
				End case 
		End case 
		
	: (Session:C1714.isGuest() & (vt_URL="/InterviewerLogin") & (Size of array:C274(at_FormVarNames)=2))  // LoginFormular wurde ausgefüllt
		If ((at_FormVarNames{1}="Name") & (at_FormVarNames{2}="Kennwort") & (at_FormVarValues{1}#"") & (at_FormVarValues{2}#""))
			If (web_Authenticate(at_FormVarValues{1}; at_FormVarValues{2}))  // Es ist ein gültiger Nutzer
				var $vo_info : Object
				$vo_info:=New object:C1471("userName"; at_FormVarValues{1})
				Session:C1714.setPrivileges($vo_info)
				web_SessionUpdate(New collection:C1472("LetzteURL"; "Umfrage"; "InfoText"; ""))
				ALL RECORDS:C47([Variablen:5])
				ORDER BY:C49([Variablen:5]; [Variablen:5]EingerichtetAm:40; <)
			Else   // Ungültige Zugangsdaten
				web_SessionUpdate(New collection:C1472("LetzteURL"; "Login"))
				vt_WebZusatzText:="    !! Ungültige Zugangsdaten - ab drei Fehlversuchen wird die Wartezeit verlängert!!"
			End if 
		Else   // Ungültige Parameter von Login-Seite
			WEB SEND TEXT:C677("falsche Param")
		End if 
		
	: (Session:C1714.isGuest() & (vt_URL="/InterviewerLogin"))  // Login-Seite wurde korrekt angefordert
		Use (Session:C1714.storage)
			Session:C1714.storage.Info:=New shared object:C1526("LetzteURL"; "Login"; "InfoText"; "")
			Session:C1714.storage.History:=New shared collection:C1527("Login")
		End use 
		
End case 

If (Session:C1714.storage.Info.LetzteURL#"")
	If (e_AktTelefonNummer#Null:C1517)
		web_SessionUpdate(New collection:C1472("InfoFeld"; web_InfofeldBauen(e_AktTelefonNummer; Session:C1714.storage.Info.UmfragePKID)))
		QUERY:C277([TelefonNummer:4]; [TelefonNummer:4]PKID:53=e_AktTelefonNummer.PKID)
		QUERY:C277([Variablen:5]; [Variablen:5]PKID:45=Session:C1714.storage.Info.UmfragePKID)
		p_Hist4HTML
		p_Komm4HTML
	End if 
	WEB SEND FILE:C619(Session:C1714.storage.Info.LetzteURL+".shtml")
	web_SessionUpdate(New collection:C1472("InfoText"; ""))
	
	//DELAY PROCESS(Current process; 30)
End if 
