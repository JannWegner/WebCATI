If (Form event code:C388=On Load:K2:1)
	OBJECT SET FILTER:C235(vantw;get_filter )
	vantw:=id2feld (weitermit)
	p_TelefonAvgFormatSetzen 
End if 