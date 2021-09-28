//%attributes = {}
  //Berechnet die Verweildauer bei den einzelnen Fragen
  //für die aktuelle Auswahl an Bögen bzw. für alle

CONFIRM:C162("Zeit/Frage für letzte Auswahl (n="+String:C10(Records in selection:C76([TelefonNummer:4]))+") oder alle fertigen Interviews?";"Alle";"Auswahl")
If (OK=1)
	QUERY:C277([TelefonNummer:4];[TelefonNummer:4]Umfrage:30=vUmfrage;*)
	QUERY:C277([TelefonNummer:4]; & [TelefonNummer:4]Status:5="Komplett")
End if 

ORDER BY:C49([TelefonNummer:4];[TelefonNummer:4]AdrFBNr:20)

ARRAY TEXT:C222(asBogenID;0)
QUERY:C277([Bogen:6];[Bogen:6]Umfrage:20=vUmfrage)
QUERY SELECTION:C341([Bogen:6];[Bogen:6]ID:1#"@-bed";*)
QUERY SELECTION:C341([Bogen:6]; & [Bogen:6]ID:1#"@-do";*)
QUERY SELECTION:C341([Bogen:6]; & [Bogen:6]ID:1#"@_Spez")
SELECTION TO ARRAY:C260([Bogen:6]ID:1;asBogenID)

ARRAY INTEGER:C220(ai_ZeitFrage;Size of array:C274(asBogenID)+2;Records in selection:C76([TelefonNummer:4])+3)
C_BOOLEAN:C305($vb_GueltigPhase)
C_TEXT:C284($vt_AuswertString)
C_TEXT:C284($vs_Zeile;$vs_AktID)
C_TEXT:C284($vs_StartZeit)
C_LONGINT:C283($vi_ArrayZeile)
C_LONGINT:C283($vl_lauf;$vl_lauf2;$vl_KummZeit;$vl_MaxZeit;$vl_MinZeit)

MESSAGE:C88("Datensätze analysieren ...")
FIRST RECORD:C50([TelefonNummer:4])
$vl_lauf:=1
While (Not:C34(End selection:C36([TelefonNummer:4])))
	$vb_GueltigPhase:=False:C215
	$vi_ArrayZeile:=0
	$vl_KummZeit:=0
	$vt_AuswertString:=[TelefonNummer:4]wmProto:37
	ai_ZeitFrage{Size of array:C274(ai_ZeitFrage)}{$vl_lauf}:=[TelefonNummer:4]AdrFBNr:20
	While (Not:C34($vt_AuswertString=""))
		$vs_Zeile:=Substring:C12($vt_AuswertString;1;Position:C15(Char:C90(13);$vt_AuswertString)-1)
		If ($vi_ArrayZeile>0)
			ai_ZeitFrage{$vi_ArrayZeile}{$vl_lauf}:=p_TimeStringToSeconds (Substring:C12($vs_Zeile;1;8))-p_TimeStringToSeconds ($vs_StartZeit)
			$vl_KummZeit:=$vl_KummZeit+ai_ZeitFrage{$vi_ArrayZeile}{$vl_lauf}
			$vi_ArrayZeile:=0
		End if 
		$vs_StartZeit:=Substring:C12($vs_Zeile;1;8)
		$vs_AktID:=Substring:C12($vs_Zeile;21;Length:C16($vs_Zeile)-20)
		Case of 
			: ($vs_AktID="Ende@")
				$vb_GueltigPhase:=False:C215
			: ($vb_GueltigPhase)
				If (($vs_AktID="@-do") | ($vs_AktID="@-bed") | ($vs_AktID="@_Spez") | ($vs_AktID=".vs@"))
					$vi_ArrayZeile:=0
				Else 
					$vi_ArrayZeile:=Find in array:C230(asBogenID;$vs_AktID)
					If ($vi_ArrayZeile=-1)
						  //ALERT("m_ZeitProFrage:"+Char(13)+$vs_AktID+" aus FB "+String([TelefonNummer]AdrFBNr)+" nicht in 'asBogenID' gefunden!")
						
					End if 
				End if 
			: ($vs_AktID="Start")
				$vb_GueltigPhase:=True:C214
		End case 
		$vt_AuswertString:=Substring:C12($vt_AuswertString;Position:C15(Char:C90(13);$vt_AuswertString)+1)
	End while 
	  //Statistik erzeugen
	ai_ZeitFrage{(Size of array:C274(ai_ZeitFrage)-1)}{$vl_lauf}:=Round:C94($vl_KummZeit/60;0)
	
	NEXT RECORD:C51([TelefonNummer:4])
	$vl_lauf:=$vl_lauf+1
End while 

MESSAGE:C88("Statistik erstellen ...")

  //Statistik über alle
For ($vl_lauf;1;Size of array:C274(asBogenID))
	$vl_KummZeit:=0
	$vl_MaxZeit:=0
	$vl_MinZeit:=30000
	For ($vl_lauf2;1;Records in selection:C76([TelefonNummer:4]))
		$vl_KummZeit:=$vl_KummZeit+ai_ZeitFrage{$vl_lauf}{$vl_lauf2}
		If (ai_ZeitFrage{$vl_lauf}{$vl_lauf2}>$vl_MaxZeit)
			$vl_MaxZeit:=ai_ZeitFrage{$vl_lauf}{$vl_lauf2}
		End if 
		If ((ai_ZeitFrage{$vl_lauf}{$vl_lauf2}<$vl_MinZeit) & (ai_ZeitFrage{$vl_lauf}{$vl_lauf2}>0))
			$vl_MinZeit:=ai_ZeitFrage{$vl_lauf}{$vl_lauf2}
		End if 
	End for 
	If ($vl_MinZeit=30000)
		$vl_MinZeit:=0
	End if 
	ai_ZeitFrage{$vl_lauf}{Records in selection:C76([TelefonNummer:4])+1}:=$vl_MinZeit
	ai_ZeitFrage{$vl_lauf}{Records in selection:C76([TelefonNummer:4])+2}:=$vl_MaxZeit
	ai_ZeitFrage{$vl_lauf}{Records in selection:C76([TelefonNummer:4])+3}:=Round:C94($vl_KummZeit/Records in selection:C76([TelefonNummer:4]);0)
End for 

C_LONGINT:C283(vi_ZeitProFrageAktSeite)
vi_ZeitProFrageAktSeite:=1
DIALOG:C40([TelefonNummer:4];"d_ZeitProFrage")
