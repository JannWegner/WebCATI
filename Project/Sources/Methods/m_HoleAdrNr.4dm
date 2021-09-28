//%attributes = {}
  // m_HoleAdrNr
  // Jann Wegner
  // 20180327-

p_LogDatenAktualisieren ("AdrNr ziehen";vUmfrage;0;"")

$AdrNr:=Num:C11(Request:C163("Welche Adress-Nr. möchten Sie eingeben?"))
If (OK=1)
	  //Fassung vorbereiten
	If ([Variablen:5]Fasssung:24#"")
		p_FassungInit 
		p_FassungRechnen 
	End if 
	
	QUERY:C277([TelefonNummer:4];[TelefonNummer:4]Umfrage:30=vUmfrage;*)
	QUERY:C277([TelefonNummer:4]; & [TelefonNummer:4]AdrFBNr:20=$AdrNr)
	
	
	If (Records in selection:C76([TelefonNummer:4])=1)
		$NameNr:=Substring:C12("'"+[TelefonNummer:4]AdrFeld01:14+" "+[TelefonNummer:4]AdrFeld02:16+Char:C90(13)+[TelefonNummer:4]AdrFeld03:13+" "+[TelefonNummer:4]AdrFeld04:15+"'";1;80)
		CONFIRM:C162($NameNr+" wirklich bearbeiten?";"Bearbeiten";"Abbruch")
		If (OK=1)
			While (Semaphore:C143("HoleTelNr"))
				MESSAGE:C88("Bitte kurz warten")
				For ($lauf;1;5000)
				End for 
			End while 
			If (([TelefonNummer:4]Status:5="Neu@") | ([TelefonNummer:4]Status:5="Wiedervorlage") | (([TelefonNummer:4]Status:5="Komplett") & (User in group:C338(Current user:C182;"Entwickler"))))
				If ([TelefonNummer:4]Status:5="Komplett")
					ALERT:C41("Achtung: Sie bearbeiten ein abgeschlossesnes Interview!")
				End if 
				If (Locked:C147([TelefonNummer:4]))
					LOCKED BY:C353([TelefonNummer:4];$Prozessnr;$Anwender;$Arbeitsstation;$Prozessname)
					CLEAR SEMAPHORE:C144("HoleTelNr")
					ALERT:C41("Die Adresse "+String:C10([TelefonNummer:4]AdrFBNr:20)+" wird bereits bearbeitet"+Char:C90(13)+"U: "+$Anwender+" S: "+$Arbeitsstation+" P: "+$Prozessname+Char:C90(13)+" Nochmal!")
				Else 
					
					NeuerSatz:=True:C214
					doppelklick:=False:C215
					vName:=[LogDaten:1]DBNutzer:1
					
					  // Ziehen der Nummer dokumentieren
					[TelefonNummer:4]Historie:4:=String:C10(Current date:C33)+"/"+String:C10(Current time:C178)+" (Z) * "+vName+Char:C90(13)+[TelefonNummer:4]Historie:4
					sichere_DS (Table:C252(->[TelefonNummer:4]);DEBUG)
					
					p_RandomSprungWuerfeln 
					Telefonieren 
					
					[LogDaten:1]Modul:8:="Startbildschirm"
					[LogDaten:1]FbNr:9:=0
					[LogDaten:1]Frage:10:=""
					sichere_DS (Table:C252(->[LogDaten:1]);DEBUG)
					
				End if 
			Else 
				CLEAR SEMAPHORE:C144("HoleTelNr")
				ALERT:C41("Sorry - "+$NameNr+" hat den Status  "+[TelefonNummer:4]Status:5+"/"+[TelefonNummer:4]StatusErklärung:11)
				ALERT:C41("Nummer kann nicht bearbeitet werden! "+String:C10($AdrNr))
			End if 
		Else 
			ALERT:C41("Nix passiert!")
		End if 
	Else 
		ALERT:C41("Diese Nummer wurde leider nicht gefunden! "+String:C10($AdrNr))
	End if 
	UNLOAD RECORD:C212([TelefonNummer:4])
Else 
	ALERT:C41("Nix passiert!")
End if 

p_LogDatenAktualisieren ("Startbildschirm";vUmfrage;0;"")
