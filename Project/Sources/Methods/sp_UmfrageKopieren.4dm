//%attributes = {}
  //Erzeugt einen Dummy einer Umfrage (Server-Part)
  //$1 Original UmfrageNur
  //$2 Dummy-UmfrageNr
  //$3 Anzeige-Name
  //$4 Jede wievielte Nummer soll kopiert werden
  // $5 true=Alles, sonst jungfräulich
  // $6: Erstellungsdatum

C_TEXT:C284($1;$2;$3;$vt_OrgNr;$vt_DummyNr;$vt_Anzeige)
C_LONGINT:C283($4;$vl_Wievielte;$vl_OrgAnzahl)
ARRAY LONGINT:C221($al_AdrNr;0)
C_BOOLEAN:C305($5;$vb_Alles)
C_DATE:C307($6;$vd_Erstellt)


$vt_OrgNr:=$1
$vt_DummyNr:=$2
$vt_Anzeige:=$3
$vl_Wievielte:=$4
$vb_Alles:=$5
$vd_Erstellt:=$6

QUERY:C277([TelefonNummer:4];[TelefonNummer:4]Umfrage:30=$vt_OrgNr)
SELECTION TO ARRAY:C260([TelefonNummer:4]AdrFBNr:20;$al_AdrNr)
For ($lauf1;Size of array:C274($al_AdrNr);1;-1)
	If ($lauf1%$vl_Wievielte#0)
		DELETE FROM ARRAY:C228($al_AdrNr;$lauf1;1)
	End if 
End for 

QUERY WITH ARRAY:C644([TelefonNummer:4]AdrFBNr:20;$al_AdrNr)
QUERY SELECTION:C341([TelefonNummer:4];[TelefonNummer:4]Umfrage:30=$vt_OrgNr)
$vl_OrgAnzahl:=Records in selection:C76([TelefonNummer:4])

SELECTION TO ARRAY:C260([TelefonNummer:4]AdrBehalten:47;$a_AdrBehalten;[TelefonNummer:4]AdrFBNr:20;$a_AdrFBNr;[TelefonNummer:4]AdrFeld01:14;$a_AdrFeld01;[TelefonNummer:4]AdrFeld02:16;$a_AdrFeld02;[TelefonNummer:4]AdrFeld03:13;$a_AdrFeld03;[TelefonNummer:4]AdrFeld04:15;$a_AdrFeld04;[TelefonNummer:4]AdrFeld05:18;$a_AdrFeld05;[TelefonNummer:4]AdrFeld06:34;$a_AdrFeld06;[TelefonNummer:4]AdrFeld07:35;$a_AdrFeld07;[TelefonNummer:4]AdrFeld08:33;$a_AdrFeld08;[TelefonNummer:4]AdrFeld09:17;$a_AdrFeld09;[TelefonNummer:4]AdrFeld10:21;$a_AdrFeld10;[TelefonNummer:4]AdrFeld11:27;$a_AdrFeld11;[TelefonNummer:4]AdrFeld12:28;$a_AdrFeld12;[TelefonNummer:4]AdrFeld13:31;$a_AdrFeld13;[TelefonNummer:4]AdrFeld14:42;$a_AdrFeld14;[TelefonNummer:4]AdrFeld15:43;$a_AdrFeld15;[TelefonNummer:4]AdrFeld16:44;$a_AdrFeld16;[TelefonNummer:4]aktAnsprechp:38;$a_aktAnsprechp;[TelefonNummer:4]AntwASCII:41;$a_AntwASCII;[TelefonNummer:4]AntwortArrayBlob:22;$a_AntwortArrayBlob;[TelefonNummer:4]AntwUeberlauf:40;$a_AntwUeberlauf;[TelefonNummer:4]BinaerText:32;$a_BinaerText;[TelefonNummer:4]Dauer:51;$a_Dauer;[TelefonNummer:4]EingetragenTB:12;$a_EingetragenTB;[TelefonNummer:4]Ende am:25;$a_Ende am;[TelefonNummer:4]Ende um:26;$a_Ende um;[TelefonNummer:4]Fassung:39;$a_Fassung;[TelefonNummer:4]FixTermin:36;$a_FixTermin;[TelefonNummer:4]Historie:4;$a_Historie;[TelefonNummer:4]HistZeilen:29;$a_HistZeilen;[TelefonNummer:4]Interviewer:10;$a_Interviewer;[TelefonNummer:4]Kommentar:6;$a_Kommentar;[TelefonNummer:4]Kontakte:52;$a_Kontakte;[TelefonNummer:4]QuotenTopf:46;$a_QuotenTopf;[TelefonNummer:4]RefDatum:8;$a_RefDatum;[TelefonNummer:4]RefZeit:9;$a_RefZeit;[TelefonNummer:4]SpezialDruck:45;$a_SpezialDruck;[TelefonNummer:4]Start Am:23;$a_Start Am;[TelefonNummer:4]Start um:24;$a_Start um;[TelefonNummer:4]Status:5;$a_Status;[TelefonNummer:4]StatusErklärung:11;$a_StatusErklärung;[TelefonNummer:4]Telefon1:19;$a_Telefon1;[TelefonNummer:4]Telefon2:1;$a_Telefon2;[TelefonNummer:4]Variablenspeicher:49;$a_Variablenspeicher;[TelefonNummer:4]Wegspeicher:48;$a_Wegspeicher;[TelefonNummer:4]WegspeicherBLOB:50;$a_WegspeicherBLOB;[TelefonNummer:4]WeiterMitFrage:7;$a_WeiterMitFrage;[TelefonNummer:4]WiederAm:2;$a_WiederAm;[TelefonNummer:4]WiederUm:3;$a_WiederUm;[TelefonNummer:4]wmProto:37;$a_wmProto)
REDUCE SELECTION:C351([TelefonNummer:4];0)

START TRANSACTION:C239
If ($vb_Alles)
	ARRAY TO SELECTION:C261($a_AdrBehalten;[TelefonNummer:4]AdrBehalten:47;$a_AdrFBNr;[TelefonNummer:4]AdrFBNr:20;$a_AdrFeld01;[TelefonNummer:4]AdrFeld01:14;$a_AdrFeld02;[TelefonNummer:4]AdrFeld02:16;$a_AdrFeld03;[TelefonNummer:4]AdrFeld03:13;$a_AdrFeld04;[TelefonNummer:4]AdrFeld04:15;$a_AdrFeld05;[TelefonNummer:4]AdrFeld05:18;$a_AdrFeld06;[TelefonNummer:4]AdrFeld06:34;$a_AdrFeld07;[TelefonNummer:4]AdrFeld07:35;$a_AdrFeld08;[TelefonNummer:4]AdrFeld08:33;$a_AdrFeld09;[TelefonNummer:4]AdrFeld09:17;$a_AdrFeld10;[TelefonNummer:4]AdrFeld10:21;$a_AdrFeld11;[TelefonNummer:4]AdrFeld11:27;$a_AdrFeld12;[TelefonNummer:4]AdrFeld12:28;$a_AdrFeld13;[TelefonNummer:4]AdrFeld13:31;$a_AdrFeld14;[TelefonNummer:4]AdrFeld14:42;$a_AdrFeld15;[TelefonNummer:4]AdrFeld15:43;$a_AdrFeld16;[TelefonNummer:4]AdrFeld16:44;$a_aktAnsprechp;[TelefonNummer:4]aktAnsprechp:38;$a_AntwASCII;[TelefonNummer:4]AntwASCII:41;$a_AntwortArrayBlob;[TelefonNummer:4]AntwortArrayBlob:22;$a_AntwUeberlauf;[TelefonNummer:4]AntwUeberlauf:40;$a_BinaerText;[TelefonNummer:4]BinaerText:32;$a_Dauer;[TelefonNummer:4]Dauer:51;$a_EingetragenTB;[TelefonNummer:4]EingetragenTB:12;$a_Ende am;[TelefonNummer:4]Ende am:25;$a_Ende um;[TelefonNummer:4]Ende um:26;$a_Fassung;[TelefonNummer:4]Fassung:39;$a_FixTermin;[TelefonNummer:4]FixTermin:36;$a_Historie;[TelefonNummer:4]Historie:4;$a_HistZeilen;[TelefonNummer:4]HistZeilen:29;$a_Interviewer;[TelefonNummer:4]Interviewer:10;$a_Kommentar;[TelefonNummer:4]Kommentar:6;$a_Kontakte;[TelefonNummer:4]Kontakte:52;$a_QuotenTopf;[TelefonNummer:4]QuotenTopf:46;$a_RefDatum;[TelefonNummer:4]RefDatum:8;$a_RefZeit;[TelefonNummer:4]RefZeit:9;$a_SpezialDruck;[TelefonNummer:4]SpezialDruck:45;$a_Start Am;[TelefonNummer:4]Start Am:23;$a_Start um;[TelefonNummer:4]Start um:24;$a_Status;[TelefonNummer:4]Status:5;$a_StatusErklärung;[TelefonNummer:4]StatusErklärung:11;$a_Telefon1;[TelefonNummer:4]Telefon1:19;$a_Telefon2;[TelefonNummer:4]Telefon2:1;$a_Variablenspeicher;[TelefonNummer:4]Variablenspeicher:49;$a_Wegspeicher;[TelefonNummer:4]Wegspeicher:48;$a_WegspeicherBLOB;[TelefonNummer:4]WegspeicherBLOB:50;$a_WeiterMitFrage;[TelefonNummer:4]WeiterMitFrage:7;$a_WiederAm;[TelefonNummer:4]WiederAm:2;$a_WiederUm;[TelefonNummer:4]WiederUm:3;$a_wmProto;[TelefonNummer:4]wmProto:37)
Else 
	ARRAY TO SELECTION:C261($a_AdrBehalten;[TelefonNummer:4]AdrBehalten:47;$a_AdrFBNr;[TelefonNummer:4]AdrFBNr:20;$a_AdrFeld01;[TelefonNummer:4]AdrFeld01:14;$a_AdrFeld02;[TelefonNummer:4]AdrFeld02:16;$a_AdrFeld03;[TelefonNummer:4]AdrFeld03:13;$a_AdrFeld04;[TelefonNummer:4]AdrFeld04:15;$a_AdrFeld05;[TelefonNummer:4]AdrFeld05:18;$a_AdrFeld06;[TelefonNummer:4]AdrFeld06:34;$a_AdrFeld07;[TelefonNummer:4]AdrFeld07:35;$a_AdrFeld08;[TelefonNummer:4]AdrFeld08:33;$a_AdrFeld09;[TelefonNummer:4]AdrFeld09:17;$a_AdrFeld10;[TelefonNummer:4]AdrFeld10:21;$a_AdrFeld11;[TelefonNummer:4]AdrFeld11:27;$a_AdrFeld12;[TelefonNummer:4]AdrFeld12:28;$a_AdrFeld13;[TelefonNummer:4]AdrFeld13:31;$a_AdrFeld14;[TelefonNummer:4]AdrFeld14:42;$a_AdrFeld15;[TelefonNummer:4]AdrFeld15:43;$a_AdrFeld16;[TelefonNummer:4]AdrFeld16:44;$a_aktAnsprechp;[TelefonNummer:4]aktAnsprechp:38;$a_EingetragenTB;[TelefonNummer:4]EingetragenTB:12;$a_QuotenTopf;[TelefonNummer:4]QuotenTopf:46;$a_Telefon1;[TelefonNummer:4]Telefon1:19;$a_Telefon2;[TelefonNummer:4]Telefon2:1)
	APPLY TO SELECTION:C70([TelefonNummer:4];[TelefonNummer:4]Status:5:="Neu")
End if 
$vb_OK:=($vl_OrgAnzahl=Records in selection:C76([TelefonNummer:4]))

If ($vb_OK)
	APPLY TO SELECTION:C70([TelefonNummer:4];[TelefonNummer:4]Umfrage:30:=$vt_DummyNr)
	QUERY:C277([TelefonNummer:4];[TelefonNummer:4]Umfrage:30=$vt_DummyNr)
	$vb_OK:=($vb_OK & ($vl_OrgAnzahl=Records in selection:C76([TelefonNummer:4])))
End if 

If ($vb_OK)
	QUERY:C277([Bogen:6];[Bogen:6]Umfrage:20=$vt_OrgNr)
	$vl_OrgAnzahl:=Records in selection:C76([Bogen:6])
	SELECTION TO ARRAY:C260([Bogen:6]AnzahlSpalten:24;$a_AnzahlSpalten;[Bogen:6]AvgSchrift:25;$a_AvgSchrift;[Bogen:6]AvgText:5;$a_AvgText;[Bogen:6]Bedingung:10;$a_Bedingung;[Bogen:6]ErlaubteWerte:15;$a_ErlaubteWerte;[Bogen:6]Filter_Eingabe:9;$a_Filter_Eingabe;[Bogen:6]Filter_generiert:14;$a_Filter_generiert;[Bogen:6]FormNam:8;$a_FormNam;[Bogen:6]FormTyp:7;$a_FormTyp;[Bogen:6]Fragenummer:2;$a_Fragenummer;[Bogen:6]FText:3;$a_FText;[Bogen:6]Halboffen:26;$a_Halboffen;[Bogen:6]ID:1;$a_ID;[Bogen:6]KKA:18;$a_KKA;[Bogen:6]kurzText:4;$a_kurzText;[Bogen:6]MaxAnzEingabe:13;$a_MaxAnzEingabe;[Bogen:6]MaxWert:17;$a_MaxWert;[Bogen:6]MinWert:16;$a_MinWert;[Bogen:6]nextID:6;$a_nextID;[Bogen:6]Solo:19;$a_Solo;[Bogen:6]Spalte:12;$a_Spalte;[Bogen:6]Spezial_Druck:21;$a_Spezial_Druck;[Bogen:6]Spezial_Eingabe:22;$a_Spezial_Eingabe;[Bogen:6]Sprungziel:11;$a_Sprungziel;[Bogen:6]Zitate_Druck:23;$a_Zitate_Druck)
	REDUCE SELECTION:C351([Bogen:6];0)
	ARRAY TO SELECTION:C261($a_AnzahlSpalten;[Bogen:6]AnzahlSpalten:24;$a_AvgSchrift;[Bogen:6]AvgSchrift:25;$a_AvgText;[Bogen:6]AvgText:5;$a_Bedingung;[Bogen:6]Bedingung:10;$a_ErlaubteWerte;[Bogen:6]ErlaubteWerte:15;$a_Filter_Eingabe;[Bogen:6]Filter_Eingabe:9;$a_Filter_generiert;[Bogen:6]Filter_generiert:14;$a_FormNam;[Bogen:6]FormNam:8;$a_FormTyp;[Bogen:6]FormTyp:7;$a_Fragenummer;[Bogen:6]Fragenummer:2;$a_FText;[Bogen:6]FText:3;$a_Halboffen;[Bogen:6]Halboffen:26;$a_ID;[Bogen:6]ID:1;$a_KKA;[Bogen:6]KKA:18;$a_kurzText;[Bogen:6]kurzText:4;$a_MaxAnzEingabe;[Bogen:6]MaxAnzEingabe:13;$a_MaxWert;[Bogen:6]MaxWert:17;$a_MinWert;[Bogen:6]MinWert:16;$a_nextID;[Bogen:6]nextID:6;$a_Solo;[Bogen:6]Solo:19;$a_Spalte;[Bogen:6]Spalte:12;$a_Spezial_Druck;[Bogen:6]Spezial_Druck:21;$a_Spezial_Eingabe;[Bogen:6]Spezial_Eingabe:22;$a_Sprungziel;[Bogen:6]Sprungziel:11;$a_Zitate_Druck;[Bogen:6]Zitate_Druck:23)
	APPLY TO SELECTION:C70([Bogen:6];[Bogen:6]Umfrage:20:=$vt_DummyNr)
	$vb_OK:=($vb_OK & ($vl_OrgAnzahl=Records in selection:C76([Bogen:6])))
	
End if 


If ($vb_OK)
	QUERY:C277([Variablen:5];[Variablen:5]Umfrage:3=$vt_OrgNr)
	DUPLICATE RECORD:C225([Variablen:5])
	[Variablen:5]Umfrage:3:=$vt_DummyNr
	[Variablen:5]UmfrageAnzeigeName:38:=$vt_Anzeige
	[Variablen:5]FuerAlleOffen:30:=False:C215
	[Variablen:5]EingerichtetAm:40:=$vd_Erstellt
	SAVE RECORD:C53([Variablen:5])
	QUERY:C277([Variablen:5];[Variablen:5]Umfrage:3=$vt_DummyNr)
	$vb_OK:=($vb_OK & (1=Records in selection:C76([Variablen:5])))
	
End if 

If ($vb_OK)
	QUERY:C277([Quoten:7];[Quoten:7]Umfrage:1=$vt_OrgNr)
	DUPLICATE RECORD:C225([Quoten:7])
	[Quoten:7]Umfrage:1:=$vt_DummyNr
	SAVE RECORD:C53([Quoten:7])
	QUERY:C277([Quoten:7];[Quoten:7]Umfrage:1=$vt_DummyNr)
	$vb_OK:=($vb_OK & (1=Records in selection:C76([Quoten:7])))
	
End if 

If ($vb_OK)
	VALIDATE TRANSACTION:C240
Else 
	CANCEL TRANSACTION:C241
End if 