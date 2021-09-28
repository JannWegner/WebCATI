//%attributes = {}
p_LogDatenAktualisieren ("Töpfe setzen";vUmfrage;0;"")

  //Arrays initialisieren
QUERY:C277([Quoten:7];[Quoten:7]Umfrage:1=vUmfrage)

p_QuotenArraysErzeugen 
p_QuotenSuchArrayBauen 

CONFIRM:C162("Topf setzen für letzte Auswahl (n="+String:C10(Records in selection:C76([TelefonNummer:4]))+") oder alle Adressen?";"Alle";"Auswahl")
If (OK=1)
	QUERY:C277([TelefonNummer:4];[TelefonNummer:4]Umfrage:30=vUmfrage)
End if 

MESSAGE:C88("Weise Adressen den entsprechenden Quotentopf zu ...")

READ WRITE:C146([TelefonNummer:4])
If (Read only state:C362([TelefonNummer:4]))
	ALERT:C41("[TelefonNummer] im 'Nur-Lesen-Modus!' - Abbruch")
Else 
	MESSAGES OFF:C175
	APPLY TO SELECTION:C70([TelefonNummer:4];p_QuotenToepfeInAdrSetzen )
	MESSAGES ON:C181
	
	QUERY SELECTION:C341([TelefonNummer:4];[TelefonNummer:4]QuotenTopf:46=-1;*)
	QUERY SELECTION:C341([TelefonNummer:4]; | [TelefonNummer:4]QuotenTopf:46=0)
	If (Records in selection:C76([TelefonNummer:4])=0)
		ALERT:C41("Alles OK")
	Else 
		ALERT:C41("Manchen Adressen konnte kein Topf zugeordnet werden ([TelefonNummer]QuotenTopf=-1"+"/0)!")
	End if 
End if 

p_LogDatenAktualisieren ("Startbildschirm";vUmfrage;0;"")
