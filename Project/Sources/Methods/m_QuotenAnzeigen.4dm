//%attributes = {}
p_LogDatenAktualisieren ("Quoten anzeigen";vUmfrage;0;"")
  //Erzeugt ein Layout mit den aktuellen Angaben
QUERY:C277([Quoten:7];[Quoten:7]Umfrage:1=vUmfrage)
QUERY:C277([TelefonNummer:4];[TelefonNummer:4]Umfrage:30=vUmfrage;*)
QUERY:C277([TelefonNummer:4]; & [TelefonNummer:4]QuotenTopf:46<1)
If (Records in selection:C76([TelefonNummer:4])>0)
	$NrListe:=""
	APPLY TO SELECTION:C70([TelefonNummer:4];$NrListe:=$NrListe+" "+String:C10([TelefonNummer:4]AdrFBNr:20))
	ALERT:C41("m_QuotenAnzeigen:"+Char:C90(13)+"Adresse(n) "+$NrListe+" hat/haben haben keinen Topf!"+Char:C90(13)+"EDV anrufen!")
End if 

If (Records in selection:C76([Quoten:7])=1)
	  //Arrays erzeugen
	p_QuotenArraysErzeugen 
	
	  //Sollzahlen auslesen
	p_QuotenSollZahlenLesen 
	
	  //Freigaben einlesen
	p_QuotenFreigabenLesen 
	
	  //Aktuellen Stand aus Adressen auslesen
	p_QuotenAdrAuslesen 
	
	  //Matrix erzeugen
	p_QuotenMatrixErzeugen 
	
	DIALOG:C40([Quoten:7];"QuotenAnsicht")
	
	
Else 
	ALERT:C41("p_QuotenAnzeigen:"+Char:C90(13)+"Keine Quotenangaben gefunden!")
End if 

p_LogDatenAktualisieren ("Startbildschirm";vUmfrage;0;"")
