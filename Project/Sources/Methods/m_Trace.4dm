//%attributes = {}
// m_Trace
// Jann Wegner
// 20220126

If (User in group:C338(Current user:C182; "Entwickler"))
	TRACE:C157
Else 
	ALERT:C41("Kein Zugriff auf diesen Befehl!")
End if 