//%attributes = {}
/* p_ResetSession
Jann Wegner
20210421

$1>0: Löscht Daten der aktuellen Session
$1=0: Löscht Daten aller Sessions
*/

C_TEXT:C284($1;$vt_LoeschSession)
C_LONGINT:C283($vl_LoeschSessionNr)

$vt_LoeschSession:=$1

If ($vt_LoeschSession="RESET")
	ARRAY TEXT:C222(<>at_SessionID;0)
	ARRAY OBJECT:C1221(<>ao_SessionObject;0)
Else 
	$vl_LoeschSessionNr:=Find in array:C230(<>at_SessionID;$vt_LoeschSession)
	If ($vl_LoeschSessionNr=-1)
		WEB SEND TEXT:C677("Fehler Löschen SessionID")
	Else 
		<>at_SessionID{$vl_LoeschSessionNr}:=""
		CLEAR VARIABLE:C89(<>ao_SessionObject{$vl_LoeschSessionNr})
	End if 
End if 

ALERT:C41($1)

