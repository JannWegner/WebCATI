//%attributes = {}
  // weitermit_neu
  // Jann Wegner
  // 20180327-

C_TEXT:C284($0;$vs_NeueBogenID)
C_LONGINT:C283($vl_FindPos)


If ($1="")
	  // Bei generischen Formularen steht in [Bogen]nextID das neue weitermit
	$vs_NeueBogenID:=[Bogen:6]nextID:6
	QUERY:C277([Bogen:6];[Bogen:6]Umfrage:20="Universell!!";*)
	QUERY:C277([Bogen:6]; | [Bogen:6]Umfrage:20=vUmfrage;*)
	QUERY:C277([Bogen:6]; & [Bogen:6]ID:1=[Bogen:6]nextID:6)
	If (Records in selection:C76([Bogen:6])#1)
		ALERT:C41("weitermit_neu:"+Char:C90(13)+"ID "+[Bogen:6]nextID:6+" nicht zu identifizieren (gen)-Anzahl DS◊1!")
		TRACE:C157
	End if 
Else 
	  //Auch bei speziellen Formularen muß der zugehörige [Bogen]-DS ausgewählt werden
	$vs_NeueBogenID:=$1
	QUERY:C277([Bogen:6];[Bogen:6]Umfrage:20="Universell!!";*)
	QUERY:C277([Bogen:6]; | [Bogen:6]Umfrage:20=vUmfrage;*)
	QUERY:C277([Bogen:6]; & [Bogen:6]ID:1=$1)
	If (Records in selection:C76([Bogen:6])#1)
		ALERT:C41("weitermit_neu:"+Char:C90(13)+"ID "+$1+" nicht zu identifizieren (spez) - Anzahl DS <> 1!")
		TRACE:C157
	End if 
End if 

  // Muss ein Random-Mapping berücksichtigt werden?
$vl_FindPos:=Find in array:C230(at_RandomOrgID;$vs_NeueBogenID)
If ($vl_FindPos#-1)
	$vs_NeueBogenID:=at_RandomMapID{$vl_FindPos}
End if 

  //Bogen fuer AktuellerWeg-Kontrolle mitprotokollieren
If (($vs_NeueBogenID#"Telefon@") & ($vs_NeueBogenID#"int_bereit@"))
	$vi_FindPos:=Position:C15($vs_NeueBogenID;vt_AktuellerWeg)
	If ($vi_FindPos#0)
		  //Hier waren wir schon einmal ...
		  //... deshalb den Weg unterhalb von $vi_FindPos löschen, damit keine toten Aeste uebrigbleiben
		vt_AktuellerWeg:=Substring:C12(vt_AktuellerWeg;1;$vi_FindPos-1)
	End if 
	vt_AktuellerWeg:=vt_AktuellerWeg+$vs_NeueBogenID+Char:C90(13)
End if 

  //Weiter-Mit-Proto für Rücksprünge während des Interviews
If ([Bogen:6]Sprungziel:11)
	If (arr_wms{1}="")
		arr_wms{1}:=$vs_NeueBogenID
	Else 
		wmalt_ind:=Size of array:C274(arr_wms)
		wmneu_ind:=Find in array:C230(arr_wms;$vs_NeueBogenID)
		If (wmneu_ind>-1)
			ARRAY TEXT:C222(arr_wms;wmneu_ind)
		Else 
			ARRAY TEXT:C222(arr_wms;wmalt_ind+1)
			arr_wms{wmalt_ind+1}:=$vs_NeueBogenID
		End if 
	End if 
End if 

[TelefonNummer:4]wmProto:37:=[TelefonNummer:4]wmProto:37+String:C10(Current time:C178;HH MM SS:K7:1)+";"+String:C10(Current date:C33;Internal date short:K1:7)+";"+$vs_NeueBogenID+Char:C90(13)
p_AktuellerWegBlobSchreiben 
$0:=$vs_NeueBogenID


