//%attributes = {}
  //Test, ob solche Prozesse schon existieren
vb_ClientsAnzeigen:=True:C214
SET MENU ITEM MARK:C208(4;9;Char:C90(18);1)

If (Application type:C494=4D Remote mode:K5:5)
	For ($lauf;1;Count tasks:C335)
		PROCESS PROPERTIES:C336($lauf;$vs_Prozeßname;$vi_Prozeßstatus;$Prozeßzeit)
		If (($vs_Prozeßname="ListOfClients") & ($lauf#Current process:C322) & ($vi_Prozeßstatus>=0))
			SET PROCESS VARIABLE:C370($lauf;vb_ClientsAnzeigen;False:C215)
			SET MENU ITEM MARK:C208(4;9;"";1)
			vb_ClientsAnzeigen:=False:C215
		End if 
	End for 
	
	
	  // Nachfolgender Code ist nur im Client/Server-Betrieb gültig
	$Ref:=Open window:C153(100;100;350;400;-(Palette window:K34:3+Has window title:K34:11+Alternate dialog box:K34:5);"Liste der registrierten Clients")
	While (vb_ClientsAnzeigen)
		GET REGISTERED CLIENTS:C650($ClientList;$ListeCharge)
		  //Finde die registrierten Clients wieder in $ClientList
		ERASE WINDOW:C160($Ref)
		GOTO XY:C161(0;0)
		For ($p;1;Size of array:C274($ClientList))
			MESSAGE:C88($ClientList{$p}+Char:C90(Carriage return:K15:38))
		End for 
		  //Zeige jede Sekunde an
		DELAY PROCESS:C323(Current process:C322;300)
	End while   // Endlos-Schleife
	
	SET MENU ITEM MARK:C208(4;9;"";1)
End if 