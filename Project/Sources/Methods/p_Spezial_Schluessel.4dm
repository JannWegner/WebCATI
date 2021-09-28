//%attributes = {}
  //Wird aufgerufen von m_SpezialEingabe und von m_SpezialMitSchluessel


OK:=1
  //Vorsichtshalber alle Spezial-Bögen heraussuche, egal ob Spezial-Eingabe wahr oder falsch
$vsDummy1:="@spez@"
$vsDummy2:="@-bed@"
$vsDummy3:="@-do@"
QUERY:C277([Bogen:6];[Bogen:6]Umfrage:20=vUmfrage;*)
QUERY:C277([Bogen:6]; & [Bogen:6]ID:1=$vsDummy1;*)
QUERY:C277([Bogen:6]; & [Bogen:6]ID:1#$vsDummy2;*)
QUERY:C277([Bogen:6]; & [Bogen:6]ID:1#$vsDummy3)
ORDER BY:C49([Bogen:6]ID:1)

ARRAY TEXT:C222(tSpezID;Records in selection:C76([Bogen:6]))
ARRAY TEXT:C222(tSpezFrText;Records in selection:C76([Bogen:6]))



  //Erster Durchgang durch die Bogen
FIRST RECORD:C50([Bogen:6])
$lauf:=1
While (Not:C34(End selection:C36([Bogen:6])))
	tSpezID{$lauf}:=[Bogen:6]AvgText:5
	$lauf:=$lauf+1
	NEXT RECORD:C51([Bogen:6])
End while 

  //Zweiter Durchgang durch die Bogen
For ($lauf;1;Size of array:C274(tSpezID))
	QUERY:C277([Bogen:6];[Bogen:6]Umfrage:20="Universell!!";*)
	QUERY:C277([Bogen:6]; | [Bogen:6]Umfrage:20=vUmfrage;*)
	QUERY:C277([Bogen:6]; & [Bogen:6]ID:1=tSpezID{$lauf})
	tSpezFrText{$lauf}:=Substring:C12("Frage "+[Bogen:6]Fragenummer:2+": "+Char:C90(13)+Char:C90(13)+[Bogen:6]kurzText:4;1;80)
End for 

QUERY:C277([Bogen:6];[Bogen:6]Umfrage:20=vUmfrage;*)
QUERY:C277([Bogen:6]; & [Bogen:6]Spezial_Eingabe:22=True:C214)
ORDER BY:C49([Bogen:6]ID:1)
COPY NAMED SELECTION:C331([Bogen:6];"ns_Bogen")

Repeat 
	USE NAMED SELECTION:C332("ns_Bogen")
	NochNeNummer:=True:C214
	EndeNummer:=False:C215
	$AdrFbNr:=Num:C11(Request:C163("Fragebogen-Nummer eingeben"))
	If (OK=1)
		QUERY:C277([TelefonNummer:4];[TelefonNummer:4]Umfrage:30=vUmfrage;*)
		QUERY:C277([TelefonNummer:4]; & [TelefonNummer:4]AdrFBNr:20=$AdrFbNr)
		Case of 
			: ((Records in selection:C76([TelefonNummer:4])=1) & ([TelefonNummer:4]Status:5="Komplett"))
				  //Spezialeingabe starten
				While (Semaphore:C143("HoleTelNr"))
					MESSAGE:C88("Bitte kurz warten")
					For ($lauf;1;5000)
					End for 
				End while 
				
				C_TEXT:C284(vt_AktuellerWeg)
				
				init_wm_arr 
				
				NeuerSatz:=True:C214
				doppelklick:=False:C215
				vName:=[LogDaten:1]DBNutzer:1
				
				GOTO RECORD:C242([LogDaten:1];<>BenutzerNr)
				[LogDaten:1]FbNr:9:=[TelefonNummer:4]AdrFBNr:20
				sichere_DS (Table:C252(->[LogDaten:1]);DEBUG)
				p_LogDatenAktualisieren (((Num:C11(vbSpezialMitSchluessel)*"Schlüsseln & Spezial-Eingabe")+(Num:C11(Not:C34(vbSpezialMitSchluessel))*"Spezial-Eingabe"));vUmfrage;0;"")
				
				
				FIRST RECORD:C50([Bogen:6])
				weitermit:=weitermit_neu ([Bogen:6]ID:1)
				CLEAR SEMAPHORE:C144("HoleTelNr")
				
				vSprunkmarke:=0
				AntwortArray_Init 
				AntwortArray_Lesen 
				vt_AktuellerWeg:=[TelefonNummer:4]Wegspeicher:48
				
				seitenkontrolle 
				AntwortArray_Schreiben 
				
				[LogDaten:1]Modul:8:="Startbildschirm"
				[LogDaten:1]FbNr:9:=0
				[LogDaten:1]Frage:10:=""
				sichere_DS (Table:C252(->[LogDaten:1]);DEBUG)
				
				
			: (Records in selection:C76([TelefonNummer:4])=1)
				ALERT:C41("Die Nummer "+String:C10($AdrFbNr)+" ist kein kompletter Bogen!")
			Else 
				ALERT:C41("Die Nummer "+String:C10($AdrFbNr)+" gibt es nicht!")
				
		End case 
	Else 
		NochNeNummer:=False:C215
	End if 
Until (Not:C34(NochNeNummer))

p_LogDatenAktualisieren ("Startbildschirm";vUmfrage;0;"")
