  //Mapping Konsistenz prüfen
  //20151123

C_TEXT:C284($vt_Fehler)
C_LONGINT:C283($vi_Lauf1;$vi_Lauf2)

$vt_Fehler:=""
CREATE EMPTY SET:C140([Mapping:10];"$m_Fehler")


MESSAGE:C88("Test Name ohne Nummer...")
QUERY:C277([Mapping:10];[Mapping:10]NeuerName:5#"";*)
QUERY:C277([Mapping:10]; & [Mapping:10]NeueNr:4=0)
If (Records in selection:C76([Mapping:10])#0)
	$vt_Fehler:=$vt_Fehler+Char:C90(13)+"Text ohne Nummer"
	ADD TO SET:C119([Mapping:10];"$m_Fehler")
End if 

MESSAGE:C88("Test Nummer ohne Name...")
QUERY:C277([Mapping:10];[Mapping:10]NeuerName:5="";*)
QUERY:C277([Mapping:10]; & [Mapping:10]NeueNr:4#0)
If (Records in selection:C76([Mapping:10])#0)
	$vt_Fehler:=$vt_Fehler+Char:C90(13)+"Nummer ohne Text"
	ADD TO SET:C119([Mapping:10];"$m_Fehler")
End if 

MESSAGE:C88("Löcher-Test...")
ALL RECORDS:C47([Mapping:10])
DISTINCT VALUES:C339([Mapping:10]TabNr:7;$ai_TabNr)
For ($vi_Lauf1;1;Size of array:C274($ai_TabNr))
	QUERY:C277([Mapping:10];[Mapping:10]NeueNr:4#0;*)
	QUERY:C277([Mapping:10]; & [Mapping:10]Typ:2="f";*)
	QUERY:C277([Mapping:10]; & [Mapping:10]NeuerName:5#"";*)
	QUERY:C277([Mapping:10]; & [Mapping:10]TabNr:7=$ai_TabNr{$vi_Lauf1})
	ORDER BY:C49([Mapping:10];[Mapping:10]NeueNr:4)
	FIRST RECORD:C50([Mapping:10])
	If ([Mapping:10]NeueNr:4#1)
		$vt_Fehler:=$vt_Fehler+Char:C90(13)+"Tabelle "+String:C10($ai_TabNr{$vi_Lauf1})+": Numerierung beginnt nicht bei 1"
	Else 
		NEXT RECORD:C51([Mapping:10])
		$vi_Lauf2:=2
		While (Not:C34(End selection:C36([Mapping:10])))
			If ($vi_Lauf2#[Mapping:10]NeueNr:4)
				$vt_Fehler:=$vt_Fehler+Char:C90(13)+"Tabelle "+String:C10($ai_TabNr{$vi_Lauf1})+": Numerierungsfehler bei "+String:C10($vi_Lauf2)
			End if 
			$vi_Lauf2:=$vi_Lauf2+1
			NEXT RECORD:C51([Mapping:10])
		End while 
	End if 
End for 

If ($vt_Fehler[[1]]=Char:C90(13))
	$vt_Fehler:=Substring:C12($vt_Fehler;2)
End if 
If ($vt_Fehler#"")
	ALERT:C41($vt_Fehler)
	If (Records in set:C195("$m_Fehler")#0)
		ALERT:C41("Zeige fehlerhafte Sätze an!")
		USE SET:C118("$m_Fehler")
	End if 
Else 
	ALERT:C41("Alles OK!")
End if 