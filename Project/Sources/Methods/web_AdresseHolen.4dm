//%attributes = {}
/*
web_AdresseHolen
Jann Wegner
20220127-20220124-20211001-20210929-20210423

Holt für das Web-Interface eine Adresse

$1=0: Eine Adresse zufälllig ziehen und vorbereiten
Sonst: Adresse prüfen und vorbereiten
*/

C_LONGINT:C283($vl_Zufall; $vl_Lauf)
C_BOOLEAN:C305($vb_AdressOK; $vb_TerminHolen)
C_TIME:C306($vz_Suchzeit)
C_BLOB:C604($vblob_QuotenIDs)
C_OBJECT:C1216($0; $1; $es_NeueFreieAdressen; $e_FreieAdresse; $vo_SessionObject; $es_TerminAdressen; $e_TerminAdresse)
ARRAY LONGINT:C221($al_FreieToepfe; 0)

// $0:=New object("AdrFbNr"; 0; "AdrPKID"; ""; "Text"; "") // 20220113: Obsolet??

$vo_SessionObject:=$1

$vb_AdressOK:=False:C215
$vb_TerminHolen:=False:C215

While (Semaphore:C143("sema_HoleAdresse"; 600))
	IDLE:C311
End while 

If ($vo_SessionObject.FbNr=0)  // Wir wählen eine zufällige Adrese aus
	$vz_Suchzeit:=Time:C179(Time string:C180(Current time:C178+([Variablen:5]Vorschau:2*60)))
	QUERY:C277([TelefonNummer:4];  & [TelefonNummer:4]Umfrage:30=$vo_SessionObject.Umfrage; *)
	QUERY:C277([TelefonNummer:4];  & [TelefonNummer:4]Status:5="Wiedervorlage"; *)
	QUERY:C277([TelefonNummer:4];  & [TelefonNummer:4]StatusErklärung:11="Termin@"; *)
	QUERY:C277([TelefonNummer:4];  & [TelefonNummer:4]WiederAm:2<Current date:C33)
	CREATE SET:C116([TelefonNummer:4]; "$mDatum")
	QUERY:C277([TelefonNummer:4];  & [TelefonNummer:4]Umfrage:30=$vo_SessionObject.Umfrage; *)
	QUERY:C277([TelefonNummer:4];  & [TelefonNummer:4]Status:5="Wiedervorlage"; *)
	QUERY:C277([TelefonNummer:4];  & [TelefonNummer:4]StatusErklärung:11="Termin@"; *)
	QUERY:C277([TelefonNummer:4];  & [TelefonNummer:4]WiederAm:2=Current date:C33; *)
	QUERY:C277([TelefonNummer:4];  & [TelefonNummer:4]WiederUm:3<=$vz_Suchzeit)
	CREATE SET:C116([TelefonNummer:4]; "$mZeit")
	UNION:C120("$mDatum"; "$mZeit"; "$mfaellig")
	USE SET:C118("$mfaellig")
	//$mfaellig enthält Telnrn mit "Termin" bis (jetzt + Vorschau)
	If (Records in selection:C76([TelefonNummer:4])=0)
		QUERY:C277([TelefonNummer:4];  & [TelefonNummer:4]Umfrage:30=$vo_SessionObject.Umfrage; *)
		QUERY:C277([TelefonNummer:4];  & [TelefonNummer:4]Status:5="Wiedervorlage"; *)
		QUERY:C277([TelefonNummer:4];  & [TelefonNummer:4]WiederAm:2<Current date:C33)
		CREATE SET:C116([TelefonNummer:4]; "$mDatum")
		QUERY:C277([TelefonNummer:4];  & [TelefonNummer:4]Umfrage:30=$vo_SessionObject.Umfrage; *)
		QUERY:C277([TelefonNummer:4];  & [TelefonNummer:4]Status:5="Wiedervorlage"; *)
		QUERY:C277([TelefonNummer:4];  & [TelefonNummer:4]WiederAm:2=Current date:C33; *)
		QUERY:C277([TelefonNummer:4];  & [TelefonNummer:4]WiederUm:3<=$vz_Suchzeit)
		CREATE SET:C116([TelefonNummer:4]; "$mZeit")
		UNION:C120("$mDatum"; "$mZeit"; "$mfaellig")
		USE SET:C118("$mfaellig")
		//$mfaellig enthält Telnrn ohne "Termin" aber mit "Wiedervorlage" 
		If (Records in selection:C76([TelefonNummer:4])=0)
			// Neue Teilnehmer
			QUERY:C277([Quoten:7]; [Quoten:7]Umfrage:1=$vo_SessionObject.Umfrage)
			For ($vl_Lauf; 1; Length:C16([Quoten:7]FreigabeString:11))
				If ([Quoten:7]FreigabeString:11[[$vl_Lauf]]="1")
					APPEND TO ARRAY:C911($al_FreieToepfe; $vl_Lauf)
				End if 
			End for 
			QUERY:C277([TelefonNummer:4]; [TelefonNummer:4]Umfrage:30=$vo_SessionObject.Umfrage)
			QUERY SELECTION WITH ARRAY:C1050([TelefonNummer:4]QuotenTopf:46; $al_FreieToepfe)
			$es_NeueFreieAdressen:=Create entity selection:C1512([TelefonNummer:4])
			$es_NeueFreieAdressen:=$es_NeueFreieAdressen.query("Status = :1"; "Neu")
			If ($es_NeueFreieAdressen.length#0)
				$vl_Zufall:=Random:C100%$es_NeueFreieAdressen.length+1
				$e_FreieAdresse:=$es_NeueFreieAdressen[$vl_Zufall-1]
				web_SessionUpdate(New collection:C1472("FbNr"; $e_FreieAdresse.AdrFBNr; "AdrPKID"; $e_FreieAdresse.PKID; "LetzteFrage"; $e_FreieAdresse.LetzteFrageWeb; "Fassung"; $e_FreieAdresse.Fassung))
				$e_FreieAdresse.Status:="In Arbeit"
				$e_FreieAdresse.save()
			Else 
				web_SessionUpdate(New collection:C1472("InfoText"; "Nix mehr zu tun - Feierabend!"))
			End if 
		Else 
			$vb_TerminHolen:=True:C214
		End if 
	Else 
		$vb_TerminHolen:=True:C214
	End if 
Else 
	QUERY:C277([TelefonNummer:4]; [TelefonNummer:4]Umfrage:30=$vo_SessionObject.Umfrage; *)
	QUERY:C277([TelefonNummer:4];  & [TelefonNummer:4]AdrFBNr:20=$vo_SessionObject.FbNr)
	Case of 
		: (Records in selection:C76([TelefonNummer:4])=0)
			web_SessionUpdate(New collection:C1472("InfoText"; "Nummer nicht gefunden!"; "FbNr"; 0))
		: (Records in selection:C76([TelefonNummer:4])>1)
			web_SessionUpdate(New collection:C1472("InfoText"; "Nummer mehrfach gefunden!"; "FbNr"; 0))
		: (([TelefonNummer:4]Status:5#"Neu") & ([TelefonNummer:4]Status:5#"Wiedervorlage"))
			web_SessionUpdate(New collection:C1472("InfoText"; "Status ist nicht 'Neu' odere 'Wiedervorlage'!"; "FbNr"; 0))
		Else 
			web_SessionUpdate(New collection:C1472("FbNr"; $vo_SessionObject.FbNr; "AdrPKID"; [TelefonNummer:4]PKID:53; "LetzteFrage"; [TelefonNummer:4]LetzteFrageWeb:55; "Fassung"; [TelefonNummer:4]Fassung:39))
			[TelefonNummer:4]Status:5:="In Arbeit"
			SAVE RECORD:C53([TelefonNummer:4])
	End case 
End if 

If ($vb_TerminHolen)
	ORDER BY:C49([TelefonNummer:4]; [TelefonNummer:4]WiederAm:2; [TelefonNummer:4]WiederUm:3)
	FIRST RECORD:C50([TelefonNummer:4])
	$es_TerminAdressen:=Create entity selection:C1512([TelefonNummer:4])
	$e_TerminAdresse:=$es_TerminAdressen[0]
	[TelefonNummer:4]Status:5:="In Arbeit"
	SAVE RECORD:C53([TelefonNummer:4])
	web_SessionUpdate(New collection:C1472("FbNr"; $e_TerminAdresse.AdrFBNr; "AdrPKID"; $e_TerminAdresse.PKID; "LetzteFrage"; $e_TerminAdresse.LetzteFrageWeb; "Fassung"; $e_TerminAdresse.Fassung))
End if 


CLEAR SEMAPHORE:C144("sema_HoleAdresse")
