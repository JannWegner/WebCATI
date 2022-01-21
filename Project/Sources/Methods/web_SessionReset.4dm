//%attributes = {}
// web_SessionReset
// Jann Wegner
// 20210929

// Setzt eine WebSession zurück

Use (Session:C1714.storage)
	OB REMOVE:C1226(Session:C1714.storage; "Info")
	OB REMOVE:C1226(Session:C1714.storage; "History")
End use 
Session:C1714.clearPrivileges()
WEB SEND TEXT:C677("CLEARED "+Timestamp:C1445)
Use (Session:C1714.storage)
	Session:C1714.storage.Info:=New shared object:C1526("LetzteURL"; ""; "History"; "")
	Session:C1714.storage.History:=New shared collection:C1527()
	
End use 


