// On Web Connection
// Jann Wegner
// 20210928

var $1; $vt_URL; $vt_NextURL : Text

$vt_URL:=$1
$vt_NextURL:=""

Case of 
	: (Session:C1714.isGuest() & ($vt_URL#"/InterviewerLogin"))
		$vt_NextURL:="404"
		
	: (Session:C1714.isGuest() & ($vt_URL="/InterviewerLogin"))
		
	: (Not:C34(Session:C1714.isGuest()) & ($vt_URL="/Reset"))
		Session:C1714.clearPrivileges()
		
		
End case 

If ($vt_NextURL#"")
	WEB SEND FILE:C619($vt_NextURL)
End if 