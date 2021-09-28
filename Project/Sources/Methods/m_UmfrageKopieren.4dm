//%attributes = {}
  //Erzeugt einen Dummy der aktuellen Umfrage (Client-part)
  //Uebergibt die folgenden Vairablen an an den Server
  //$1 Original UmfrageNur
  //$2 Dummy-UmfrageNr
  //$3 Anzeige-Name
  //$4 Jede wievielte Nummer soll kopiert werdne
  // $5 true=Alles, sonst jungfräulich

C_LONGINT:C283($vl_Treffer)

$vt_OrgNr:=vUmfrage

$vt_Anzeige:=Request:C163("Name für Kopie (Dummy)";"DUMMY_")
$vd_Erstellt:=Date:C102(Request:C163("Erstellungsdatum";String:C10([Variablen:5]EingerichtetAm:40)))
$vt_DummyNr:=Substring:C12(Replace string:C233($vt_Anzeige;" ";"");1;14)
$vl_Wievielte:=Num:C11(Request:C163("Jede wievielte Adresse kopieren?"))
CONFIRM:C162("1:1-kopieren oder jungfräulich?";"1:1";"Jungfräulich")
$vb_Alles:=(OK=1)

SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_Treffer)
QUERY:C277([Variablen:5];[Variablen:5]Umfrage:3=$vt_DummyNr)
SET QUERY DESTINATION:C396(Into current selection:K19:1)

If ($vl_Treffer=0)
	$vt_Text:="Dummy mit folgenden Daten erzeugen:"+Char:C90(13)
	$vt_Text:=$vt_Text+"Quell-Name: "+$vt_OrgNr+Char:C90(13)
	$vt_Text:=$vt_Text+"Kopie-Name: "+$vt_Anzeige+Char:C90(13)
	$vt_Text:=$vt_Text+"Erstellt am: "+String:C10($vd_Erstellt)+Char:C90(13)
	$vt_Text:=$vt_Text+"1:1-kopieren: "+Choose:C955($vb_Alles=True:C214;"Ja";"Nein")+Char:C90(13)
	$vt_Text:=$vt_Text+"Kopiere jede "+String:C10($vl_Wievielte)+". Adresse"
	
	CONFIRM:C162($vt_Text;"Kopieren";"Abbrechen")
	If (OK=1)
		$xx:=Execute on server:C373("sp_UmfrageKopieren";64*1024;"Umfrage kopieren";$vt_OrgNr;$vt_DummyNr;$vt_Anzeige;$vl_Wievielte;$vb_Alles;$vd_Erstellt)
		ALERT:C41("Die Kopie sollte in wenigen Augenblicken aufrufbar sein ...")
	Else 
		ALERT:C41("Nix passiert")
	End if 
Else 
	ALERT:C41("Sorry - Es gibt bereits ein Projekt namens '"+$vt_DummyNr+"'")
End if 