//%attributes = {"publishedWeb":true}
// web_Authenticate
// Jann Wegner
// 20220125-20210929-20210419

// Checkt Username und Passwort gegen Tabelle WebUser

C_TEXT:C284($1; $2; $vt_User; $vt_PW)
C_OBJECT:C1216($e_AktUser)
C_BOOLEAN:C305($0)

$vt_User:=$1
$vt_PW:=$2

$e_AktUser:=ds:C1482.WebUser.query("Name = :1"; $vt_User).first()

Case of 
	: ($e_AktUser=Null:C1517)
		web_NewLog("WrongUser"; $vt_User; "")
		$0:=False:C215
		
	: (Verify password hash:C1534($vt_PW; $e_AktUser.HashedPW))
		$e_AktUser.LetzteAnmeldung:=p_timestampD
		$e_AktUser.save()
		web_NewLog("Login"; $vt_User; "")
		$0:=True:C214
		
	Else 
		web_NewLog("WrongPW"; $vt_User; $vt_PW)
		$0:=False:C215
End case 