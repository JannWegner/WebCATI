//%attributes = {}
AntwortArray_Init 

If ([TelefonNummer:4]Status:5="Wiedervorlage")
	ORDER BY:C49([TelefonNummer:4];[TelefonNummer:4]FixTermin:36;<;[TelefonNummer:4]WiederAm:2;>;[TelefonNummer:4]WiederUm:3;>)
	FIRST RECORD:C50([TelefonNummer:4])
	$text:="Wiedervorlage"+(Num:C11([TelefonNummer:4]FixTermin:36)*" FIXTERMIN!")+Char:C90(13)+"Letztes Telefonat: "+String:C10([TelefonNummer:4]RefDatum:8)+" / "+String:C10([TelefonNummer:4]RefZeit:9)+Char:C90(13)+"Wunschtermin: "+String:C10([TelefonNummer:4]WiederAm:2)+" / "+String:C10([TelefonNummer:4]WiederUm:3)+Char:C90(13)+"Fragebogen "+String:C10([TelefonNummer:4]AdrFBNr:20)+" ab Frage  "+[TelefonNummer:4]WeiterMitFrage:7
	ALERT:C41($text)
End if 

If (([TelefonNummer:4]Status:5="Komplett") & (User in group:C338(Current user:C182;"Entwickler")))
	$vbIntGeaendert:=True:C214
	$vdStartDatum:=[TelefonNummer:4]Start Am:23
	$vzSStartZeit:=[TelefonNummer:4]Start um:24
	$vdEndeDatum:=[TelefonNummer:4]Ende am:25
	$vdEndeZeit:=[TelefonNummer:4]Ende um:26
	$vdWiederDatum:=[TelefonNummer:4]WiederAm:2
	$vzWiederZeit:=[TelefonNummer:4]WiederUm:3
	$vaInterviewer:=[TelefonNummer:4]Interviewer:10
	$vaStatus:=[TelefonNummer:4]Status:5
	$vaStatusErklaerung:=[TelefonNummer:4]StatusErklärung:11
	$viKontakte:=[TelefonNummer:4]Kontakte:52
	$viDauer:=[TelefonNummer:4]Dauer:51
	  //Dauer retten
	QUERY:C277([Bogen:6];[Bogen:6]Umfrage:20=vUmfrage;*)
	QUERY:C277([Bogen:6]; & [Bogen:6]Bedingung:10="Dauer")
	If (Records in selection:C76([Bogen:6])=1)
		$viDauerBogen:=LiA ([Bogen:6]ID:1)
	End if 
	  //Datum retten
	QUERY:C277([Bogen:6];[Bogen:6]Umfrage:20=vUmfrage;*)
	QUERY:C277([Bogen:6]; & [Bogen:6]Bedingung:10="Datum")
	If (Records in selection:C76([Bogen:6])=1)
		$viDatumBogen:=LiA ([Bogen:6]ID:1)
	End if 
Else 
	$vbIntGeaendert:=False:C215
End if 

C_TEXT:C284(vt_KommentarSpeicher)
vt_KommentarSpeicher:=""

AntwortArray_Lesen 
var2feld (".vs1_Telefon";"";"")
var2feld (".vs2_IntBereit";"";"")

p_Infofeld_Bauen 
  //Stötzer: Änderung für 5225, original nur Anweisung in else
If (([TelefonNummer:4]Umfrage:30="5225_Raucher") | ([TelefonNummer:4]Umfrage:30="5258_RauchII") | ([TelefonNummer:4]Umfrage:30="6217_Rauch_III"))
	weitermit:=weitermit_neu ("Telefon_5225")
Else 
	weitermit:=weitermit_neu ("Telefon")
End if 




[TelefonNummer:4]Status:5:="In Arbeit"
[TelefonNummer:4]Interviewer:10:=Current user:C182
[TelefonNummer:4]Kontakte:52:=[TelefonNummer:4]Kontakte:52+1
sichere_DS (Table:C252(->[TelefonNummer:4]);DEBUG)

CLEAR SEMAPHORE:C144("HoleTelNr")

GOTO RECORD:C242([LogDaten:1];<>BenutzerNr)
[LogDaten:1]Modul:8:="Interviewen"
[LogDaten:1]FbNr:9:=[TelefonNummer:4]AdrFBNr:20
sichere_DS (Table:C252(->[LogDaten:1]);DEBUG)

vSprunkmarke:=0

seitenkontrolle 


If ($vbIntGeaendert)
	[TelefonNummer:4]Start Am:23:=$vdStartDatum
	[TelefonNummer:4]Start um:24:=$vzSStartZeit
	[TelefonNummer:4]Ende am:25:=$vdEndeDatum
	[TelefonNummer:4]Ende um:26:=$vdEndeZeit
	[TelefonNummer:4]Interviewer:10:=$vaInterviewer
	[TelefonNummer:4]WiederAm:2:=$vdWiederDatum
	[TelefonNummer:4]WiederUm:3:=$vzWiederZeit
	[TelefonNummer:4]Kontakte:52:=$viKontakte
	[TelefonNummer:4]Dauer:51:=$viDauer
	QUERY:C277([Bogen:6];[Bogen:6]Umfrage:20=vUmfrage;*)
	QUERY:C277([Bogen:6]; & [Bogen:6]Bedingung:10="Dauer")
	If (Records in selection:C76([Bogen:6])=1)
		var2feld ([Bogen:6]ID:1;$viDauerBogen;"")
	End if 
	QUERY:C277([Bogen:6];[Bogen:6]Umfrage:20=vUmfrage;*)
	QUERY:C277([Bogen:6]; & [Bogen:6]Bedingung:10="Datum")
	If (Records in selection:C76([Bogen:6])=1)
		var2feld ([Bogen:6]ID:1;$viDatumBogen;"")
	End if 
	[TelefonNummer:4]Historie:4:=String:C10(Current date:C33)+"/"+String:C10(Current time:C178)+" * "+Current user:C182+" * Manuell geändert"+Char:C90(13)+[TelefonNummer:4]Historie:4
	CONFIRM:C162("Fertiges Interview wurde geändert! Änderungen schreiben?";"Schreiben";"Abbrechen")
	If (OK=1)
		AntwortArray_Schreiben 
	Else 
		[TelefonNummer:4]Status:5:=$vaStatus
		[TelefonNummer:4]StatusErklärung:11:=$vaStatusErklaerung
	End if 
	sichere_DS (Table:C252(->[TelefonNummer:4]);DEBUG)
Else 
	AntwortArray_Schreiben 
End if 

  //Aktivitaeten-Log schreiben
CREATE RECORD:C68([AktivLog:8])
[AktivLog:8]AdrFbNr:5:=[TelefonNummer:4]AdrFBNr:20
[AktivLog:8]Datum:2:=Current date:C33
[AktivLog:8]DBNutzer:4:=Current user:C182
[AktivLog:8]Status:6:=[TelefonNummer:4]Status:5
[AktivLog:8]StatusErklärung:7:=[TelefonNummer:4]StatusErklärung:11
[AktivLog:8]Umfrage:1:=vUmfrage
[AktivLog:8]Zeit:3:=Current time:C178
SAVE RECORD:C53([AktivLog:8])

UNLOAD RECORD:C212([TelefonNummer:4])
CONFIRM:C162("Wollen Sie weiter telefonieren?";"Ja, noch ne Nummer!";"Nein - Ende!")
If (OK=1)
	NochNeNummer:=True:C214
Else 
	NochNeNummer:=False:C215
End if 

