//%attributes = {}
// web_SessionReset
// Jann Wegner
// 20210929

// Setzt eine WebSession zurück

Use (Session:C1714.storage)
	OB REMOVE:C1226(Session:C1714.storage; "Info")
End use 
Session:C1714.clearPrivileges()
WEB SEND TEXT:C677("CLEARED "+Timestamp:C1445)

