//%attributes = {}
/*
p_WebInterview
Jann Wegner
20210422

*/

C_OBJECT:C1216(e_AktAdresse;$vo_WebCheckReturn)
C_LONGINT:C283($1;$vl_AktSessionNr;$vl_FindPos)
C_TEXT:C284(vt_WebHinweis)

$vl_AktSessionNr:=$1
e_AktAdresse:=ds:C1482.TelefonNummer.query("PKID = :1";<>ao_SessionObject{$vl_AktSessionNr}.AdrPKID).first()
$vo_WebCheckReturn:=New object:C1471

  // Neuer Kommentar vorhanden?
$vl_FindPos:=Find in array:C230(at_FormVarNames;"NeuKomm")
Case of 
	: ($vl_FindPos=-1)
		  // Nix tun
	: (at_FormVarValues{$vl_FindPos}="")
		  // Nix tun
	Else 
		[TelefonNummer:4]Kommentar:6:=String:C10(Current date:C33)+" "+String:C10(Current time:C178)+"   "+<>ao_SessionObject{$vl_AktSessionNr}.User+Char:C90(13)+at_FormVarValues{$vl_FindPos}+Char:C90(13)+"______________________________________"+Char:C90(13)+[TelefonNummer:4]Kommentar:6
		SAVE RECORD:C53([TelefonNummer:4])
End case 

  // Infofeld bauen
QUERY:C277([TelefonNummer:4];[TelefonNummer:4]PKID:53=e_AktAdresse.PKID)
QUERY:C277([Variablen:5];[Variablen:5]Umfrage:3=e_AktAdresse.Umfrage)
p_Infofeld_Bauen 
p_Infofeld4HTML 
p_Hist4HTML 
p_Komm4HTML 


  // Welches Formular ist auszuwerten?

Case of 
	: (<>ao_SessionObject{$vl_AktSessionNr}.Formular="")  // Es wurde noch nix angezeigt, also erstmal einfach "Telefon" einblenden
		vt_WebHinweis:=""
		WEB SEND FILE:C619("Telefon.shtml")
		<>ao_SessionObject{$vl_AktSessionNr}.Formular:="Telefon"
		
	: (<>ao_SessionObject{$vl_AktSessionNr}.Formular="Telefon")
		$vo_WebCheckReturn:=p_WebCheckInput ("RadioSingle";"Telefon")
		If ($vo_WebCheckReturn.Erfolg)
			vt_WebHinweis:=$vo_WebCheckReturn.Eingabetext
		Else 
			vt_WebHinweis:="Es wurde nichts eingegeben!"
		End if 
		WEB SEND FILE:C619("Telefon.shtml")
End case 



