//%attributes = {"publishedWeb":true}
C_LONGINT:C283($indexUserId;$indexPassword)
C_TEXT:C284($userId;$password)
C_OBJECT:C1216($user;$info)

ARRAY TEXT:C222($anames;0)
ARRAY TEXT:C222($avalues;0)

  // get values sent in the header of the request
WEB GET VARIABLES:C683($anames;$avalues)

  // look for header login fields
$indexUserId:=Find in array:C230($anames;"userId")
$userId:=$avalues{$indexUserId}
$indexPassword:=Find in array:C230($anames;"password")
$password:=$avalues{$indexPassword}

  //look for a user with the entered name in the users table
$user:=ds:C1482.WebUser.query("UserId = :1";$userId).first()

If ($user#Null:C1517)  //a user was found
	  //check the password
	If (Verify password hash:C1534($password;$user.password))
		  //password ok, fill the session
		$info:=New object:C1471()
		$info.userName:=$user.firstname+" "+$user.Lastname
		Session.setPrivileges($info)
		  //You can use the user session to store any information
		WEB SEND TEXT:C677("Welcome "+Session.userName)
	Else 
		WEB SEND TEXT:C677("Wrong user name or password.")
	End if 
Else 
	WEB SEND TEXT:C677("Wrong user name or password.")
End if 