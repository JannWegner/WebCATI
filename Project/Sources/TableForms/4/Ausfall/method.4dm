If (Form event code:C388=On Load:K2:1)
	vantw:=id2feld (".vs3_Ausfall")
	vantw_Offen:=id2feld (".vs4_AusfallSonst")
	GOTO OBJECT:C206(vantw)
	If (id2feld (".vs1_Telefon")="9")
		FORM GOTO PAGE:C247(2)
	Else 
		FORM GOTO PAGE:C247(1)
	End if 
End if 