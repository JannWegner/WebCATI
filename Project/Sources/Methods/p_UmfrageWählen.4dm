//%attributes = {}
p_LogDatenAktualisieren ("Umfrage wählen";vUmfrage;0;"")

p_FensterAnpassen (650;550)

C_LONGINT:C283($vl_AnzRec)

$UmfrageOK:=False:C215
vUmfrage:=""

READ ONLY:C145([Variablen:5])
READ ONLY:C145([Bogen:6])

MESSAGE:C88("Umfragen werden zusammengestellt - bitte kurz warten ...")
ALL RECORDS:C47([Variablen:5])
If (User in group:C338(Current user:C182;"AlleUmfragen"))
	ORDER BY:C49([Variablen:5];[Variablen:5]EingerichtetAm:40;<)
	SELECTION TO ARRAY:C260([Variablen:5]Umfrage:3;taUmfragen;[Variablen:5]EingerichtetAm:40;tdEingerichtet;[Variablen:5]AnonymDurch:42;taAnonymDurch;[Variablen:5]AnonymAm:41;tdAnonymAm;[Variablen:5]Umfrage:3;taUmfragenAnzeige)
Else 
	QUERY SELECTION:C341([Variablen:5];[Variablen:5]FuerAlleOffen:30=True:C214)
	ORDER BY:C49([Variablen:5];[Variablen:5]EingerichtetAm:40;<)
	SELECTION TO ARRAY:C260([Variablen:5]Umfrage:3;taUmfragen;[Variablen:5]EingerichtetAm:40;tdEingerichtet;[Variablen:5]AnonymDurch:42;taAnonymDurch;[Variablen:5]AnonymAm:41;tdAnonymAm;[Variablen:5]UmfrageAnzeigeName:38;taUmfragenAnzeige)
End if 
ARRAY LONGINT:C221(tiAnzahlAdr;Size of array:C274(taUmfragen))
ARRAY LONGINT:C221(tiAnzahlKomplett;Size of array:C274(taUmfragen))
SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_AnzRec)
For ($lauf;1;Size of array:C274(taUmfragen))
	QUERY:C277([TelefonNummer:4];[TelefonNummer:4]Umfrage:30=taUmfragen{$lauf})
	tiAnzahlAdr{$lauf}:=$vl_AnzRec
	QUERY:C277([TelefonNummer:4];[TelefonNummer:4]Umfrage:30=taUmfragen{$lauf};*)
	QUERY:C277([TelefonNummer:4]; & [TelefonNummer:4]Status:5="Komplett")
	tiAnzahlKomplett{$lauf}:=$vl_AnzRec
End for 
SET QUERY DESTINATION:C396(Into current selection:K19:1)
taUmfragen:=1
DIALOG:C40([Variablen:5];"d_UmfrageWaehlen")

QUERY:C277([Bogen:6];[Bogen:6]Umfrage:20=vUmfrage)
QUERY:C277([Quoten:7];[Quoten:7]Umfrage:1=vUmfrage)
QUERY:C277([TelefonNummer:4];[TelefonNummer:4]Umfrage:30=vUmfrage)
QUERY:C277([Variablen:5];[Variablen:5]Umfrage:3=vUmfrage)

If (User in group:C338(Current user:C182;"AlleUmfragen"))
	vUmfrageAnzeige:=[Variablen:5]Umfrage:3
Else 
	vUmfrageAnzeige:=[Variablen:5]UmfrageAnzeigeName:38
End if 
  //UNLOAD RECORD([TelefonNummer])

p_QuotenArraysErzeugen 

vAdrFeld01:=[Variablen:5]AdrFeld01:6
vAdrFeld02:=[Variablen:5]AdrFeld02:7
vAdrFeld03:=[Variablen:5]AdrFeld03:8
vAdrFeld04:=[Variablen:5]AdrFeld04:9
vAdrFeld05:=[Variablen:5]AdrFeld05:10
vAdrFeld06:=[Variablen:5]AdrFeld06:11
vAdrFeld07:=[Variablen:5]AdrFeld07:12
vAdrFeld08:=[Variablen:5]AdrFeld08:13
vAdrFeld09:=[Variablen:5]AdrFeld09:14
vAdrFeld10:=[Variablen:5]AdrFeld10:15
vAdrFeld11:=[Variablen:5]AdrFeld11:16
vAdrFeld12:=[Variablen:5]AdrFeld12:17
vAdrFeld13:=[Variablen:5]AdrFeld13:18
vAdrFeld14:=[Variablen:5]AdrFeld14:19
vAdrFeld15:=[Variablen:5]AdrFeld15:20
vAdrFeld16:=[Variablen:5]AdrFeld16:21

SET WINDOW TITLE:C213("CATI-Allensbach: "+vUmfrageAnzeige+"             v"+Replace string:C233(Structure file:C489;"cati_";""))

p_Map_MappingSetzen 

p_LogDatenAktualisieren ("Startbildschirm";vUmfrage;0;"")

