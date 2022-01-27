//%attributes = {}
// p_ReloadProject
// Jann Wegner
// 20220127

If (Current user:C182="Wegner Jann")
	CONFIRM:C162("Reload Project"; "Server"; "Lokal")
	If (OK=1)
		RELOAD PROJECT:C1739
	Else 
		Execute on server:C373("sp_ReloadProject"; 0)
	End if 
Else 
	ALERT:C41("Zugriff nicht erlaubt!")
End if 