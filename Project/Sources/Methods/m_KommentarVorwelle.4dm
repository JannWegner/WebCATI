//%attributes = {}
  // Übernimmt für die aktuelle Auswahl den Kommentar aus der Vorwelle
  // Vorwellenkommentar wird wahlweise angehängt oder ausschließlich benutzt
vb_Ueberschreiben:=False:C215

CONFIRM:C162("Kommentar übernehmen für letzte Auswahl (n="+String:C10(Records in selection:C76([TelefonNummer:4]))+") oder alle Adressen?";"Alle";"Auswahl")
If (OK=1)
	QUERY:C277([TelefonNummer:4];[TelefonNummer:4]Umfrage:30=vUmfrage)
End if 

COPY NAMED SELECTION:C331([TelefonNummer:4];"$ns_ZuBearbeiten")

$AlteUmfrage:=Request:C163("Von welcher Umfrage übernehmen?")
If ($AlteUmfrage#"")
	$Trenntext:="****  "+$AlteUmfrage+"  ****"
	CONFIRM:C162("Der aktuelle Kommentar würde bei "+String:C10(Records in selection:C76([TelefonNummer:4]))+" Adressen überschrieben!";"Anfügen";"Überschreiben")
	vb_Ueberschreiben:=Choose:C955(OK=1;False:C215;True:C214)
	CONFIRM:C162("Starten?";"Start";"Abbruch")
	If (OK=1)
		QUERY:C277([TelefonNummer:4];[TelefonNummer:4]Umfrage:30=$AlteUmfrage)
		If (Records in selection:C76([TelefonNummer:4])#0)
			SELECTION TO ARRAY:C260([TelefonNummer:4]AdrFBNr:20;$al_AdrNr;[TelefonNummer:4]Kommentar:6;$at_Kommentar)
			
			AdressenLesenSchreiben 
			USE NAMED SELECTION:C332("$ns_ZuBearbeiten")
			FIRST RECORD:C50([TelefonNummer:4])
			While (Not:C34(End selection:C36([TelefonNummer:4])))
				$FindPos:=Find in array:C230($al_AdrNr;[TelefonNummer:4]AdrFBNr:20)
				If ($FindPos>0)
					If (Length:C16($at_Kommentar{$FindPos})>10)
						[TelefonNummer:4]Kommentar:6:=Choose:C955(vb_Ueberschreiben;"";[TelefonNummer:4]Kommentar:6+Char:C90(13))+$Trenntext+Char:C90(13)+$at_Kommentar{$FindPos}
					End if 
				End if 
				SAVE RECORD:C53([TelefonNummer:4])
				NEXT RECORD:C51([TelefonNummer:4])
			End while 
			ALERT:C41("Alles erledigt!")
		Else 
			ALERT:C41("Keine Datensätze in "+$AlteUmfrage+" gefunden!")
		End if 
	Else 
		ALERT:C41("Nix passiert")
	End if 
End if 