//%attributes = {"publishedWeb":true}
GOTO RECORD:C242([LogDaten:1];<>BenutzerNr)
[LogDaten:1]Modul:8:="Nummer ziehen"
sichere_DS (Table:C252(->[LogDaten:1]);DEBUG)
C_LONGINT:C283($Zufall)

If ([Variablen:5]Fasssung:24#"")
	p_FassungRechnen 
End if 

$Suchzeit:=Time:C179(Time string:C180(Current time:C178+([Variablen:5]Vorschau:2*60)))
QUERY:C277([TelefonNummer:4]; & [TelefonNummer:4]Umfrage:30=vUmfrage;*)
QUERY:C277([TelefonNummer:4]; & [TelefonNummer:4]Status:5="Wiedervorlage";*)
QUERY:C277([TelefonNummer:4]; & [TelefonNummer:4]StatusErklärung:11="Termin@";*)
QUERY:C277([TelefonNummer:4]; & [TelefonNummer:4]WiederAm:2<Current date:C33)
CREATE SET:C116([TelefonNummer:4];"$mDatum")
QUERY:C277([TelefonNummer:4]; & [TelefonNummer:4]Umfrage:30=vUmfrage;*)
QUERY:C277([TelefonNummer:4]; & [TelefonNummer:4]Status:5="Wiedervorlage";*)
QUERY:C277([TelefonNummer:4]; & [TelefonNummer:4]StatusErklärung:11="Termin@";*)
QUERY:C277([TelefonNummer:4]; & [TelefonNummer:4]WiederAm:2=Current date:C33;*)
QUERY:C277([TelefonNummer:4]; & [TelefonNummer:4]WiederUm:3<=$Suchzeit)
CREATE SET:C116([TelefonNummer:4];"$mZeit")
UNION:C120("$mDatum";"$mZeit";"$mfaellig")
USE SET:C118("$mfaellig")
  //$mfaellig enthält Telnrn mit "Termin" bis (jetzt + Vorschau)
If (Records in selection:C76([TelefonNummer:4])=0)
	QUERY:C277([TelefonNummer:4]; & [TelefonNummer:4]Umfrage:30=vUmfrage;*)
	QUERY:C277([TelefonNummer:4]; & [TelefonNummer:4]Status:5="Wiedervorlage";*)
	QUERY:C277([TelefonNummer:4]; & [TelefonNummer:4]WiederAm:2<Current date:C33)
	CREATE SET:C116([TelefonNummer:4];"$mDatum")
	QUERY:C277([TelefonNummer:4]; & [TelefonNummer:4]Umfrage:30=vUmfrage;*)
	QUERY:C277([TelefonNummer:4]; & [TelefonNummer:4]Status:5="Wiedervorlage";*)
	QUERY:C277([TelefonNummer:4]; & [TelefonNummer:4]WiederAm:2=Current date:C33;*)
	QUERY:C277([TelefonNummer:4]; & [TelefonNummer:4]WiederUm:3<=$Suchzeit)
	CREATE SET:C116([TelefonNummer:4];"$mZeit")
	UNION:C120("$mDatum";"$mZeit";"$mfaellig")
	USE SET:C118("$mfaellig")
	  //$mfaellig enthält Telnrn ohne "Termin" aber mit "Wiedervorlage" 
	If (Records in selection:C76([TelefonNummer:4])=0)
		  // Neue Teilnehmer
		USE SET:C118("FreieAdressen")
		QUERY SELECTION:C341([TelefonNummer:4];[TelefonNummer:4]Status:5="Neu")
		If (Records in selection:C76([TelefonNummer:4])#0)
			$Zufall:=((Random:C100+(Random:C100*32767))%(Records in selection:C76([TelefonNummer:4])))+1
			GOTO SELECTED RECORD:C245([TelefonNummer:4];$Zufall)
			If ([TelefonNummer:4]Umfrage:30#vUmfrage)
				ALERT:C41("AdrNr "+String:C10([TelefonNummer:4]AdrFBNr:20)+" ist aus Umfrage "+[TelefonNummer:4]Umfrage:30+Char:C90(13)+"Bitte Daten notieren und EDV verständigen!")
				QUERY:C277([TelefonNummer:4];[TelefonNummer:4]Umfrage:30="xxxxxx")
			End if 
		Else 
			ALERT:C41("Nix mehr zu tun - Feierabend!")
		End if 
	End if 
End if 

