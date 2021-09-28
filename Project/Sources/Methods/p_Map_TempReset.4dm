//%attributes = {}
  //p_Map_TempReset
  //20151124
  //SETZT das aktuelle Mapping temporär auf Standardnamen zurück

C_LONGINT:C283($vi_Lauf1;$vi_Lauf2)

ARRAY TEXT:C222($as_TabName;Get last table number:C254)
ARRAY INTEGER:C220($ai_TabNr;Get last table number:C254)

For ($vi_Lauf1;1;Size of array:C274($as_TabName))
	$ai_TabNr{$vi_Lauf1}:=$vi_Lauf1
	$as_TabName{$vi_Lauf1}:=Table name:C256($vi_Lauf1)
	
	ARRAY TEXT:C222($as_Feldname;0)
	ARRAY INTEGER:C220($ai_FeldNr;0)
	ARRAY TEXT:C222($as_Feldname;Get last field number:C255($vi_Lauf1))
	ARRAY INTEGER:C220($ai_FeldNr;Get last field number:C255($vi_Lauf1))
	
	For ($vi_Lauf2;1;Size of array:C274($ai_FeldNr))
		$ai_FeldNr{$vi_Lauf2}:=$vi_Lauf2
		$as_Feldname{$vi_Lauf2}:=Field name:C257($vi_Lauf1;$vi_Lauf2)
	End for 
	SET FIELD TITLES:C602(Table:C252($vi_Lauf1)->;$as_Feldname;$ai_FeldNr)
	
End for 

SET TABLE TITLES:C601($as_TabName;$ai_TabNr)
