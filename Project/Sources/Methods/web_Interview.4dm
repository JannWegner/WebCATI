//%attributes = {}
// web_Interview
// Jann Wegner
// 20220113-20210930

// Kontrolliert den Ablauf eines Interviews

var e_AktTelefonNummer : Object

e_AktTelefonNummer:=ds:C1482.TelefonNummer.query("PKID = :1"; Session:C1714.storage.Info.AdrPKID)[0]
QUERY:C277([TelefonNummer:4]; [TelefonNummer:4]PKID:53=e_AktTelefonNummer.PKID)
QUERY:C277([Variablen:5]; [Variablen:5]PKID:45=Session:C1714.storage.Info.UmfragePKID)
p_Hist4HTML
p_Komm4HTML


Case of 
	: (Session:C1714.storage.Info.LetzteURL="Interview")  // Wir sind neu hier ...
		web_SessionUpdate(New collection:C1472("InfoFeld"; web_InfofeldBauen(e_AktTelefonNummer; Session:C1714.storage.Info.UmfragePKID)))
		Case of 
			: (Session:C1714.storage.Info.LetzteFrage="")  // Es ist eine neue Adresse
				// Fassung initialisieren
				// Randomreihenfolge initialisieren
			Else   // Es ist ein bereits angefangenes Interview
		End case 
		web_SessionUpdate(New collection:C1472("LetzteURL"; "Telefon"))
End case 

