START TRANSACTION:C239
$vbCopyOK:=True:C214
For ($lauf;1;Size of array:C274(asBogenIDQuelle))
	If (asBogenIDZiel{$lauf}#"")
		MESSAGE:C88("Kopiere "+asBogenIDQuelle{$lauf}+" nach "+asBogenIDZiel{$lauf})
		QUERY:C277([Bogen:6];[Bogen:6]Umfrage:20=vsZielUmfrage;*)
		QUERY:C277([Bogen:6]; & [Bogen:6]ID:1=asBogenIDZiel{$lauf})
		If (Records in selection:C76([Bogen:6])#0)
			ALERT:C41("Die ID "+asBogenIDZiel{$lauf}+" gibt es in "+vsZielUmfrage+" bereits!")
			$vbCopyOK:=False:C215
		Else 
			QUERY:C277([Bogen:6];[Bogen:6]Umfrage:20=asQuellUmfrage{asQuellUmfrage};*)
			QUERY:C277([Bogen:6]; & [Bogen:6]ID:1=asBogenIDQuelle{$lauf})
			If (Records in selection:C76([Bogen:6])=1)
				DUPLICATE RECORD:C225([Bogen:6])
				[Bogen:6]ID:1:=asBogenIDZiel{$lauf}
				[Bogen:6]nextID:6:=asNextIDZiel{$lauf}
				[Bogen:6]Spalte:12:=asSpalteZiel{$lauf}
				[Bogen:6]Umfrage:20:=vsZielUmfrage
				SAVE RECORD:C53([Bogen:6])
				$vbCopyOK:=($vbCopyOK & (OK=1))
			Else 
				ALERT:C41("Die ID "+asBogenIDQuelle{$lauf}+" gibt es in "+asQuellUmfrage{asQuellUmfrage}+" nicht?!?!!")
				$vbCopyOK:=False:C215
			End if 
		End if 
	End if 
End for 
If ($vbCopyOK)
	VALIDATE TRANSACTION:C240
	p_BogenDupl_VorgabenLoeschen 
	ALERT:C41("Alles klar - Bogen wurden kopiert")
Else 
	CANCEL TRANSACTION:C241
	ALERT:C41("Wegen Eindeutigkeitsproblemen: Nix isch passiert!")
End if 
UNLOAD RECORD:C212([Bogen:6])