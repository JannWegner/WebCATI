//%attributes = {}
  //Erzeugt aus den ausgewählten Bogen-Datensätzen entsprechende Spezial-DS

C_LONGINT:C283($Anzahl)

CONFIRM:C162("Automatisch Spezial-Bogen erstellen lassen?")
If (OK=1)
	CONFIRM:C162("Komplett neu erstellen?";"Ergänzen";"Neu")
	$KomplNeu:=Not:C34(1=OK)
	If ($KomplNeu)
		QUERY:C277([Bogen:6];[Bogen:6]Umfrage:20=vUmfrage;*)
		QUERY:C277([Bogen:6]; & [Bogen:6]FormTyp:7="Spez")
		DELETE SELECTION:C66([Bogen:6])
		
		QUERY:C277([Bogen:6];[Bogen:6]Umfrage:20=vUmfrage)
	Else 
		If (Records in set:C195("UserSet")=0)
			ALERT:C41("Bitte Datensätze auswählen")
		Else 
			USE SET:C118("UserSet")
		End if 
	End if 
	
	QUERY SELECTION:C341([Bogen:6];[Bogen:6]FormNam:8="gen_OffenText";*)
	QUERY SELECTION:C341([Bogen:6]; | [Bogen:6]FormNam:8="gen_1b@";*)
	QUERY SELECTION:C341([Bogen:6]; | [Bogen:6]FormNam:8="gen_Halboffen")
	ORDER BY:C49([Bogen:6]ID:1;<)
	
	ARRAY TEXT:C222($tNeuID;0)
	ARRAY TEXT:C222($tDelID;0)
	ARRAY BOOLEAN:C223($t8offen;0)
	FIRST RECORD:C50([Bogen:6])
	
	While (Not:C34(End selection:C36([Bogen:6])))
		MESSAGE:C88("Lesen von "+[Bogen:6]ID:1)
		$Erzeugen:=True:C214
		If (Not:C34($KomplNeu))
			SET QUERY DESTINATION:C396(Into variable:K19:4;$Anzahl)
			$SuchId:=[Bogen:6]ID:1+"-Spez"
			QUERY:C277([Bogen:6];[Bogen:6]Umfrage:20="Universell!!";*)
			QUERY:C277([Bogen:6]; | [Bogen:6]Umfrage:20=vUmfrage;*)
			QUERY:C277([Bogen:6]; & [Bogen:6]ID:1=$SuchId)
			If ($Anzahl#0)
				CONFIRM:C162($SuchId+" gibt es schon - Löschen?";"Nein";"Löschen")
				If (OK=1)
					$Erzeugen:=False:C215
				Else 
					INSERT IN ARRAY:C227($tDelID;1)
					$tDelID{1}:=$SuchID
				End if 
			End if 
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
		End if 
		If ($Erzeugen)
			INSERT IN ARRAY:C227($tNeuID;1)
			INSERT IN ARRAY:C227($t8offen;1)
			$tNeuID{1}:=[Bogen:6]ID:1
			$t8offen{1}:=(([Bogen:6]FormNam:8="gen_1b@") | ([Bogen:6]FormNam:8="gen_Halboffen"))
		End if 
		NEXT RECORD:C51([Bogen:6])
	End while 
	SORT ARRAY:C229($tNeuID;$t8offen;<)
	
	For ($lauf;1;Size of array:C274($tDelID))
		QUERY:C277([Bogen:6];[Bogen:6]Umfrage:20="Universell!!";*)
		QUERY:C277([Bogen:6]; | [Bogen:6]Umfrage:20=vUmfrage;*)
		QUERY:C277([Bogen:6]; & [Bogen:6]ID:1=$tDelID{$lauf})
		DELETE SELECTION:C66([Bogen:6])
	End for 
	
	
	For ($lauf;1;Size of array:C274($tNeuID))
		MESSAGE:C88("Erzeugen von "+$tNeuID{$lauf}+"_Spez")
		CREATE RECORD:C68([Bogen:6])
		[Bogen:6]ID:1:=$tNeuID{$lauf}+(".o"*Num:C11(($t8offen{$lauf})))+"_Spez"
		[Bogen:6]FormNam:8:="gen_Spez"
		[Bogen:6]Umfrage:20:=vUmfrage
		[Bogen:6]AvgText:5:=$tNeuID{$lauf}
		[Bogen:6]FormTyp:7:="Spez"
		[Bogen:6]Spezial_Druck:21:=True:C214
		[Bogen:6]Zitate_Druck:23:=True:C214
		[Bogen:6]Spezial_Eingabe:22:=Not:C34($t8offen{$lauf})
		SAVE RECORD:C53([Bogen:6])
	End for 
End if 

