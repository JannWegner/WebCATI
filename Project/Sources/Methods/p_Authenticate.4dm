//%attributes = {"publishedWeb":true}
  // p_Authenticate
  // Jann Wegner
  // 20210419

  // Checkt Username und Passwort gegen Tabelle WebUser

C_TEXT:C284($1;$2;$vt_User;$vt_PW)
C_OBJECT:C1216($e_AktUser)
C_BOOLEAN:C305($0)

$vt_User:=$1
$vt_PW:=$2

$e_AktUser:=ds:C1482.WebUser.query("Name = :1";$vt_User).first()

If ($e_AktUser=Null:C1517)
	$0:=False:C215
Else 
	$0:=Verify password hash:C1534($vt_PW;$e_AktUser.HashedPW)
End if 