//%attributes = {}
// web_NewLog
// Jann Wegner
// 20220125

// Zulässige Aktionen
// Login
// 404 (falsche URL)
// Block (wegen zu oft falsch)
// WrongUser
// WrongPW
// Undefined (undefinierter Programmzustand)

// $1: MessageType
// $2: User
// $3: PW

var $1; $2; $3; $vt_MessageType; $vt_User; $vt_Passwd : Text
var $e_NewLog : Object
$vt_MessageType:=$1
$vt_User:=$2
$vt_Passwd:=$3

$e_NewLog:=ds:C1482.WebLog.new()

$e_NewLog.IP:=vt_IP
$e_NewLog.TS:=p_timestampD
$e_NewLog.MessageType:=$vt_MessageType

Case of 
	: ($vt_MessageType="Login")
		$e_NewLog.User:=$vt_User
		web_UpdateBlock("Free")
		
	: ($vt_MessageType="404")
		$e_NewLog.URL:=vt_URL
		
	: ($vt_MessageType="Block")
		//
		
	: ($vt_MessageType="WrongUser")
		$e_NewLog.User:=$vt_User
		web_UpdateBlock("Block")
		
	: ($vt_MessageType="WrongPW")
		$e_NewLog.User:=$vt_User
		$e_NewLog.PW:=$vt_Passwd
		web_UpdateBlock("Block")
		
	: ($vt_MessageType="Undefined")
		$e_NewLog.URL:=vt_URL
		$e_NewLog.User:=$vt_User
		
End case 

$e_NewLog.save()
