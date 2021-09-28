//%attributes = {}
/* p_ChangePassword
Jann Wegner
20210420

Ändert das Passwort eine Nutzers

$1: Ort der Änderung: 4D/Table
$2: Art der Nutzerkennung: UUID/Name
$3: Nutzerkennung
$4: Neues Kennwort
*/

C_TEXT:C284($1;$2;$3;$4;$vt_Ort;$vt_Art;$vt_Kennung;$vt_Kennwort)
C_OBJECT:C1216($e_AktNutzer)

$vt_Ort:=$1
$vt_Art:=$2
$vt_Kennung:=$3
$vt_Kennwort:=$4

Case of 
	: ($vt_Ort="4D")
		ALERT:C41("Noch nicht implementiert!")
	: ($vt_Ort="Table")
		$vt_Suchfeld:=Choose:C955($vt_Art="UUID";"PKID";"Name")
		$e_AktNutzer:=ds:C1482.WebUser.query(":1 = :2";$vt_Suchfeld;$vt_Kennung).first()
		If ($e_AktNutzer#Null:C1517)
			$e_AktNutzer.HashedPW:=Generate password hash:C1533($vt_Kennwort)
			$e_AktNutzer.save()
		Else 
			ALERT:C41("Nutzer nicht gefunden!")
		End if 
End case 
