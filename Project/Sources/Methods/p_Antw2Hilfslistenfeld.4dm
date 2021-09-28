//%attributes = {}
  // p_Antw2Hilfslistenfeld gibt aus FrageID (= $1) und einem
  // Listennamen das in Frage FrageID gewählte Element aus der Liste $2 zurück
$vsFrage:=$1
$vsListe:=$2

If (Records in selection:C76([Bogen:6])=1)
	$vsUmfrage:=[Bogen:6]Umfrage:20
	QUERY:C277([Hilfslisten:3];[Hilfslisten:3]Umfrage:1=$vsUmfrage;*)
	QUERY:C277([Hilfslisten:3];[Hilfslisten:3]ListenID:2=$vsListe)
	If (Records in selection:C76([Hilfslisten:3])=0)
		ALERT:C41("do_action(alert):"+Char:C90(13)+"Keine Liste '"+$vsListe+"' gefunden!")
	Else 
		QUERY SELECTION:C341([Hilfslisten:3];[Hilfslisten:3]LabelID:3=Num:C11(id2feld ($vsFrage)))
		Case of 
			: (Records in selection:C76([Hilfslisten:3])=0)
				ALERT:C41("do_action(alert):"+Char:C90(13)+"Keine Listenelement '"+id2feld ($vsFrage)+"' in '"+$vsListe+"' gefunden!")
				$0:=""
			: (Records in selection:C76([Hilfslisten:3])>1)
				ALERT:C41("do_action(alert):"+Char:C90(13)+"Listenelement '"+id2feld ($vsFrage)+"' in '"+$vsListe+"' mehrfach gefunden!")
				$0:=""
			Else 
				$0:=[Hilfslisten:3]Label:4
		End case 
	End if 
End if 