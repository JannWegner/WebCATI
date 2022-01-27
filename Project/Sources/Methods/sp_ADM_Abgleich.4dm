//%attributes = {}
//Empfaenger der Endemeldung als $1

C_TEXT:C284($vs_ADMPfad; $3; $vs_EndeMeldungAn; $vs_LoeschSatz)
C_DATE:C307($vd_StartDatum)
C_TIME:C306($vt_StartZeit)
C_LONGINT:C283($vi_lauf)
C_BOOLEAN:C305(vb_AbgleichFertig; vb_AbgleichSterben)
ARRAY TEXT:C222($as_Umfrage; 0)
ARRAY BOOLEAN:C223($ab_ADM_B2B_Frei; 0)

vb_AbgleichFertig:=False:C215
vb_AbgleichSterben:=False:C215

$vd_StartDatum:=Current date:C33
$vt_StartZeit:=Current time:C178


$vs_EndeMeldungAn:=$1

/* Alte Version
Case of 
: (Current machine="cati-server")
$vs_ADMPfad:="Mac HD Cati:Users:db_orga:Documents:CATI:CATI-Allgemein:ADM-Log:"
: (Current machine="4d-server-1")
$vs_ADMPfad:="4D-Server-1:Users:datenbank:Documents:CATI-Aktuell:ADM-Log:"
: (Current machine="4D-2")
$vs_ADMPfad:="Volumes:Datenbanken:ADM-Log:"
Else 
$vs_ADMPfad:=""
End case 
*/

$vs_ADMPfad:="ADM-Log:"

If (Test path name:C476($vs_ADMPfad)=Is a folder:K24:2)
	
	//FlagDatei ggf. löschen
	If (Test path name:C476($vs_ADMPfad+"SkriptStart.txt")=Is a document:K24:1)
		DELETE DOCUMENT:C159($vs_ADMPfad+"SkriptStart.txt")
	End if 
	
	//Datei fuer Adressen erstellen
	$vl_AdrTel:=Create document:C266($vs_ADMPfad+"AdrTel.txt"; "TEXT")
	
	//Offene Umfragen zusammensuchen
	QUERY:C277([Variablen:5]; [Variablen:5]FuerAlleOffen:30=True:C214)
	SELECTION TO ARRAY:C260([Variablen:5]Umfrage:3; $as_Umfrage)
	SELECTION TO ARRAY:C260([Variablen:5]ADM_B2B_Frei:43; $ab_ADM_B2B_Frei)
	For ($vi_lauf; 1; Size of array:C274($as_Umfrage))
		QUERY:C277([TelefonNummer:4]; [TelefonNummer:4]Umfrage:30=$as_Umfrage{$vi_lauf}; *)
		QUERY:C277([TelefonNummer:4];  & [TelefonNummer:4]Telefon1:19#"")
		QUERY SELECTION:C341([TelefonNummer:4]; [TelefonNummer:4]Status:5="Neu"; *)
		QUERY SELECTION:C341([TelefonNummer:4];  | ; [TelefonNummer:4]Status:5="Wiedervorlage")
		APPLY TO SELECTION:C70([TelefonNummer:4]; SEND PACKET:C103($vl_AdrTel; String:C10($vi_lauf; "00")+"_"+String:C10([TelefonNummer:4]AdrFBNr:20)+Char:C90(9)+[TelefonNummer:4]Telefon1:19+Char:C90(13)))
		
		QUERY:C277([TelefonNummer:4]; [TelefonNummer:4]Umfrage:30=$as_Umfrage{$vi_lauf}; *)
		QUERY:C277([TelefonNummer:4];  & [TelefonNummer:4]Telefon2:1#"")
		QUERY SELECTION:C341([TelefonNummer:4]; [TelefonNummer:4]Status:5="Neu"; *)
		QUERY SELECTION:C341([TelefonNummer:4];  | ; [TelefonNummer:4]Status:5="Wiedervorlage")
		APPLY TO SELECTION:C70([TelefonNummer:4]; SEND PACKET:C103($vl_AdrTel; String:C10($vi_lauf; "00")+"_"+String:C10([TelefonNummer:4]AdrFBNr:20)+Char:C90(9)+[TelefonNummer:4]Telefon2:1+Char:C90(13)))
	End for 
	CLOSE DOCUMENT:C267($vl_AdrTel)
	
	//Datei fuer Adressen erstellen
	$vl_Flag:=Create document:C266($vs_ADMPfad+"SkriptStart.txt"; "TEXT")
	CLOSE DOCUMENT:C267($vl_Flag)
	
	//Warten auf Beendigung des ADM-Abgleichs ...
	While (Test path name:C476($vs_ADMPfad+"SkriptStop.txt")#Is a document:K24:1)
		DELAY PROCESS:C323(Current process:C322; (900))
	End while 
	DELETE DOCUMENT:C159($vs_ADMPfad+"SkriptStop.txt")
	
	$vl_LoeschNrDatei:=Open document:C264($vs_ADMPfad+"LoeschNrInsgesamt.txt"; "TEXT")
	If (OK=1)
		Repeat 
			RECEIVE PACKET:C104($vl_LoeschNrDatei; $vs_LoeschSatz; Char:C90(10))
			If (OK=1)  //Noch nicht Dateiende
				CREATE RECORD:C68([ADM_Log:9])
				[ADM_Log:9]Datum:1:=$vd_StartDatum
				[ADM_Log:9]Zeit:2:=$vt_StartZeit
				[ADM_Log:9]ADM_String:3:=Substring:C12($vs_LoeschSatz; Position:C15(" "; $vs_LoeschSatz)+1)
				[ADM_Log:9]AdrNr:5:=Num:C11(Substring:C12(Substring:C12($vs_LoeschSatz; 1; Position:C15(" "; $vs_LoeschSatz)-1); Position:C15("_"; $vs_LoeschSatz)+1))
				$vi_UmfrLfdNr:=Num:C11(Substring:C12($vs_LoeschSatz; 1; Position:C15("_"; $vs_LoeschSatz)-1))
				[ADM_Log:9]Umfrage:4:=$as_Umfrage{$vi_UmfrLfdNr}
				//Test ob B2B_Frei zutrifft
				If (($ab_ADM_B2B_Frei{$vi_UmfrLfdNr}=True:C214) & (Substring:C12([ADM_Log:9]ADM_String:3; Position:C15(";"; [ADM_Log:9]ADM_String:3)+3; 1)="2"))
					UNLOAD RECORD:C212([ADM_Log:9])
				Else 
					SAVE RECORD:C53([ADM_Log:9])
					//Adresse sperren
					QUERY:C277([TelefonNummer:4]; [TelefonNummer:4]Umfrage:30=[ADM_Log:9]Umfrage:4; *)
					QUERY:C277([TelefonNummer:4];  & [TelefonNummer:4]AdrFBNr:20=[ADM_Log:9]AdrNr:5)
					If (Records in selection:C76([TelefonNummer:4])=1)
						[TelefonNummer:4]Status:5:="ADM "+String:C10([ADM_Log:9]Datum:1)+"/"+String:C10([ADM_Log:9]Zeit:2)
						[TelefonNummer:4]StatusErklärung:11:=[ADM_Log:9]ADM_String:3
						SAVE RECORD:C53([TelefonNummer:4])
					End if 
				End if 
			End if 
		Until (OK=0)
	Else 
		ALERT:C41("LoeschNrInsgesamt.txt nicht gefunden!")
	End if 
	CLOSE DOCUMENT:C267($vl_LoeschNrDatei)
	
	vb_AbgleichFertig:=True:C214
	
	While (Not:C34(vb_AbgleichSterben))
		DELAY PROCESS:C323(Current process:C322; 60)
	End while 
	
Else 
	ALERT:C41("ADM-Log muss gemountet sein!")
End if 