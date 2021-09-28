//%attributes = {}
  //Initialisierung fuer Weg-Verfolgung
C_TEXT:C284(vt_AktuellerWeg)
If (([TelefonNummer:4]WeiterMitFrage:7#"") & ([TelefonNummer:4]Wegspeicher:48#""))
	vt_AktuellerWeg:=[TelefonNummer:4]Wegspeicher:48
Else 
	vt_AktuellerWeg:=""
End if 

  //Ersetzungsvariablen initialisieren
Init_ErsetzungsVariablen 

$RestText:=[TelefonNummer:4]AntwASCII:41

$TrennPos:=Position:C15("|";$RestText)
While ($TrennPos#0)
	$ID:=Substring:C12($RestText;1;$TrennPos-1)
	$RestText:=Substring:C12($RestText;$TrennPos+1)
	$TrennPos:=Position:C15("|";$RestText)
	$Antwort:=Substring:C12($RestText;1;$TrennPos-1)
	$RestText:=Substring:C12($RestText;$TrennPos+1)
	$TrennPos:=Position:C15("|";$RestText)
	
	$ArrayPos:=Find in array:C230(asBogenID;$ID)
	
	If ($ArrayPos=-1)
		ALERT:C41("AntwortArray_Lesen:"+Char:C90(13)+"FB "+String:C10([TelefonNummer:4]AdrFBNr:20)+Char:C90(13)+$ID+" aus AntwortenASCII nicht in den aktuellen BogenID's!"+Char:C90(13)+"Schwerer Fehler -> EDV melden!")
	Else 
		atAntworten{$ArrayPos}:=$Antwort
	End if 
End while 