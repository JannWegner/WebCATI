//%attributes = {}
  // p_RandomSprungWuerfeln
  // Jann Wegner
  // 20180326

C_LONGINT:C283($vl_lauf;$vl_lauf2;$vl_FindPos)

ARRAY TEXT:C222(at_RandomGrp;0)
ARRAY TEXT:C222(at_RandomOrgID;0)
ARRAY TEXT:C222($at_ID_Pool;0)
ARRAY TEXT:C222($at_Reihenfolge;0)
ARRAY TEXT:C222(at_RandomMapID;0)

QUERY:C277([Bogen:6];[Bogen:6]Umfrage:20=vUmfrage;*)
QUERY:C277([Bogen:6]; & [Bogen:6]RandomGrp:28#"")
If (Records in selection:C76([Bogen:6])#0)
	DISTINCT VALUES:C339([Bogen:6]RandomGrp:28;at_RandomGrp)
	$vl_Offset:=0
	If ([TelefonNummer:4]RandomReihenfolge:54="")  // Muss für diesen Satz noch gewürfelt werden?
		For ($vl_lauf;1;Size of array:C274(at_RandomGrp))
			ARRAY TEXT:C222($at_ID_Pool;0)
			QUERY:C277([Bogen:6];[Bogen:6]Umfrage:20=vUmfrage;*)
			QUERY:C277([Bogen:6]; & [Bogen:6]RandomGrp:28=at_RandomGrp{$vl_Lauf})
			ORDER BY:C49([Bogen:6];[Bogen:6]ID:1;<)
			ARRAY TEXT:C222($at_Reihenfolge;Records in selection:C76([Bogen:6])+1)
			FIRST RECORD:C50([Bogen:6])
			INSERT IN ARRAY:C227(at_RandomOrgID;1)
			at_RandomOrgID{1}:=[Bogen:6]nextID:6
			$at_Reihenfolge{Size of array:C274($at_Reihenfolge)}:=[Bogen:6]nextID:6
			While (Not:C34(End selection:C36([Bogen:6])))  // Array mit den Original-IDs aufbauen
				INSERT IN ARRAY:C227(at_RandomOrgID;1)
				at_RandomOrgID{1}:=[Bogen:6]ID:1
				INSERT IN ARRAY:C227($at_ID_Pool;1)
				$at_ID_Pool{1}:=[Bogen:6]ID:1
				NEXT RECORD:C51([Bogen:6])
			End while 
			
			  // Wuerfeln
			For ($vl_lauf2;1;Size of array:C274($at_Reihenfolge)-1)
				$vl_Random:=Random:C100%(Size of array:C274($at_ID_Pool)-1+1)+1  // (Random%(vEnd-vStart+1))+vStart
				$at_Reihenfolge{$vl_lauf2}:=$at_ID_Pool{$vl_Random}
				DELETE FROM ARRAY:C228($at_ID_Pool;$vl_Random)
			End for 
			
			For ($vl_lauf2;1;Size of array:C274($at_Reihenfolge))
				INSERT IN ARRAY:C227(at_RandomMapID;1)
			End for 
			
			  // Mapping bauen
			$vl_FindPos:=1
			For ($vl_lauf2;1;Size of array:C274($at_Reihenfolge))
				at_RandomMapID{$vl_FindPos}:=$at_Reihenfolge{$vl_lauf2}
				$vl_FindPos:=Find in array:C230(at_RandomOrgID;$at_Reihenfolge{$vl_lauf2})+1
			End for 
		End for 
		
		  // Mapping schreiben
		For ($vl_lauf2;1;Size of array:C274(at_RandomOrgID))
			[TelefonNummer:4]RandomReihenfolge:54:=[TelefonNummer:4]RandomReihenfolge:54+at_RandomOrgID{$vl_lauf2}+"|"+at_RandomMapID{$vl_lauf2}+"|"
		End for 
		SAVE RECORD:C53([TelefonNummer:4])
	Else 
		C_TEXT:C284($vt_Reihenfolgentext)
		$vt_Reihenfolgentext:=[TelefonNummer:4]RandomReihenfolge:54
		$vl_FindPos:=Position:C15("|";$vt_Reihenfolgentext)
		While ($vl_FindPos#0)
			INSERT IN ARRAY:C227(at_RandomOrgID;1)
			at_RandomOrgID{1}:=Substring:C12($vt_Reihenfolgentext;1;$vl_FindPos-1)
			$vt_Reihenfolgentext:=Substring:C12($vt_Reihenfolgentext;$vl_FindPos+1)
			$vl_FindPos:=Position:C15("|";$vt_Reihenfolgentext)
			INSERT IN ARRAY:C227(at_RandomMapID;1)
			at_RandomMapID{1}:=Substring:C12($vt_Reihenfolgentext;1;$vl_FindPos-1)
			$vt_Reihenfolgentext:=Substring:C12($vt_Reihenfolgentext;$vl_FindPos+1)
			$vl_FindPos:=Position:C15("|";$vt_Reihenfolgentext)
		End while 
	End if 
End if 
