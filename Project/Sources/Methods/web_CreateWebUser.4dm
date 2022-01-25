//%attributes = {}
// web_CreateWebUser
// Jann Wegner
// 20210419

// Erzeugt aus Nutzername ($1) und Kennwort ($2) eine neuen Eintrag in Tabelle WebUser

C_TEXT:C284($1; $2; $vt_UserName; $vt_PasswdPlain)
C_OBJECT:C1216($vo_Options; $vo_NewUser)

$vt_UserName:=$1
$vt_PasswdPlain:=$2
$vo_Options:=New object:C1471("algorithm"; "bcrypt"; "cost"; 10)
$vo_NewUser:=ds:C1482.WebUser.new()

$vo_NewUser.Name:=$vt_UserName
$vo_NewUser.HashedPW:=Generate password hash:C1533($vt_PasswdPlain; $vo_Options)

$vo_NewUser.save()






