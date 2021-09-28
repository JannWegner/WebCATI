//%attributes = {"publishedWeb":true}
p_LogDatenAktualisieren ("Interviewen";vUmfrage;0;"")

C_LONGINT:C283(viAktuelleQuotenVersion)
READ ONLY:C145([Variablen:5])
QUERY:C277([Variablen:5];[Variablen:5]Umfrage:3=vUmfrage)

NeuerSatz:=True:C214
doppelklick:=False:C215

vName:=[LogDaten:1]DBNutzer:1
NochNeNummer:=True:C214

  //variable für quotenversion initialisieren
viAktuelleQuotenVersion:=-1

  //Fassung vorbereiten
p_FassungInit 

Repeat 
	While (Semaphore:C143("HoleTelNr"))
		MESSAGE:C88("Hole_TelefonNummer: Bitte kurz warten...")
		For ($i;1;50000)
		End for 
		
	End while 
	
	  //test, ob neue Freie Adressen eingelesen werden müssen
	If (viAktuelleQuotenVersion<[Variablen:5]QuotenVersion:33)
		p_FreieAdressenEinlesen 
	End if 
	
	Hole_TelefonNummer 
	If (Records in selection:C76([TelefonNummer:4])#0)
		If (Locked:C147([TelefonNummer:4]))
			LOCKED BY:C353([TelefonNummer:4];$Prozessnr;$Anwender;$Arbeitsstation;$Prozessname)
			CLEAR SEMAPHORE:C144("HoleTelNr")
			CONFIRM:C162("Die Adresse "+String:C10([TelefonNummer:4]AdrFBNr:20)+" wird bereits bearbeitet"+Char:C90(13)+"U: "+$Anwender+" S: "+$Arbeitsstation+" P: "+$Prozessname+Char:C90(13)+" Nochmal!")
		Else 
			p_RandomSprungWuerfeln 
			Telefonieren 
		End if 
	Else 
		NochNeNummer:=False:C215
	End if 
Until (Not:C34(NochNeNummer))
CLEAR SEMAPHORE:C144("HoleTelNr")
READ WRITE:C146([Variablen:5])

doppelklick:=True:C214

p_LogDatenAktualisieren ("Startbildschirm";vUmfrage;0;"")
