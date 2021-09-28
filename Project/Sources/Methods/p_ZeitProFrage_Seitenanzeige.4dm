//%attributes = {}
C_LONGINT:C283($1;$vi_Seite;$vi_X_Offset;$vi_SpaltenAnzahl;$vi_X_Ende)
C_LONGINT:C283($vl_laufx;$vl_laufy)

$vi_Seite:=$1
$vi_SpaltenAnzahl:=17
$vi_X_Offset:=($vi_Seite-1)*$vi_SpaltenAnzahl

  //Kopfzeile erzeugen
If (($vi_SpaltenAnzahl+$vi_X_Offset)>Size of array:C274(ai_ZeitFrage{1}))
	$vi_X_Ende:=Size of array:C274(ai_ZeitFrage{1})-3
Else 
	$vi_X_Ende:=$vi_SpaltenAnzahl+$vi_X_Offset
End if 

  //Kopfzeile 1 mit FBNr erzeugen
vt_TextAnzeige:=p_TextFormat ("FbNr";"l";20)+" | "+p_TextFormat ("Min";"l";5)+" | "+p_TextFormat ("Max";"l";5)+" | "+p_TextFormat ("Mid";"l";5)+" | "
For ($vl_laufx;1+$vi_X_Offset;$vi_X_Ende)
	vt_TextAnzeige:=vt_TextAnzeige+p_TextFormat (String:C10(ai_ZeitFrage{Size of array:C274(ai_ZeitFrage)}{$vl_laufx});"r";5)+" | "
End for 
vt_TextAnzeige:=vt_TextAnzeige+Char:C90(13)

  //Kopfzeile 2 mit -- erzeugen
vt_TextAnzeige:=vt_TextAnzeige+p_TextFormat (" ";"l";20)+" | "+p_TextFormat ("-----";"r";5)+" | "+p_TextFormat ("-----";"r";5)+" | "+p_TextFormat ("-----";"r";5)+" | "
For ($vl_laufx;1+$vi_X_Offset;$vi_X_Ende)
	vt_TextAnzeige:=vt_TextAnzeige+p_TextFormat ("-----";"r";5)+" | "
End for 
vt_TextAnzeige:=vt_TextAnzeige+Char:C90(13)

  //Kopfzeile 3 mit Dauer erzeugen
vt_TextAnzeige:=vt_TextAnzeige+p_TextFormat ("Gesamt";"l";20)+" | "+p_TextFormat (" ";"r";5)+" | "+p_TextFormat (" ";"r";5)+" | "+p_TextFormat (" ";"r";5)+" | "
For ($vl_laufx;1+$vi_X_Offset;$vi_X_Ende)
	vt_TextAnzeige:=vt_TextAnzeige+p_TextFormat (String:C10(ai_ZeitFrage{(Size of array:C274(ai_ZeitFrage)-1)}{$vl_laufx});"r";5)+" | "
End for 
vt_TextAnzeige:=vt_TextAnzeige+Char:C90(13)

  //Kopfzeile 4 mit -- erzeugen
vt_TextAnzeige:=vt_TextAnzeige+p_TextFormat (" ";"l";20)+" | "+p_TextFormat ("-----";"r";5)+" | "+p_TextFormat ("-----";"r";5)+" | "+p_TextFormat ("-----";"r";5)+" | "
For ($vl_laufx;1+$vi_X_Offset;$vi_X_Ende)
	vt_TextAnzeige:=vt_TextAnzeige+p_TextFormat ("-----";"r";5)+" | "
End for 
vt_TextAnzeige:=vt_TextAnzeige+Char:C90(13)




For ($vl_laufy;1;Size of array:C274(ai_ZeitFrage)-2)
	vt_TextAnzeige:=vt_TextAnzeige+p_TextFormat (asBogenID{$vl_laufy};"l";20)+" | "+p_TextFormat (String:C10(ai_ZeitFrage{$vl_laufy}{Size of array:C274(ai_ZeitFrage{1})-2});"r";5)+" | "+p_TextFormat (String:C10(ai_ZeitFrage{$vl_laufy}{Size of array:C274(ai_ZeitFrage{1})-1});"r";5)+" | "+p_TextFormat (String:C10(ai_ZeitFrage{$vl_laufy}{Size of array:C274(ai_ZeitFrage{1})});"r";5)+" | "
	For ($vl_laufx;1+$vi_X_Offset;$vi_X_Ende)
		vt_TextAnzeige:=vt_TextAnzeige+p_TextFormat (String:C10(ai_ZeitFrage{$vl_laufy}{$vl_laufx});"r";5)+" | "
	End for 
	vt_TextAnzeige:=vt_TextAnzeige+Char:C90(13)
End for 
