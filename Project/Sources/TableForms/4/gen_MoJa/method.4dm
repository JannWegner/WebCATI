If (Form event code:C388=On Load:K2:1)
	OBJECT SET FILTER:C235(vantwMo;"&9##")
	OBJECT SET FILTER:C235(vantwJa;"&9##")
	vantw:=id2feld (weitermit)
	
	$PosKomma:=Position:C15(",";vantw)
	vantwMo:=String:C10(Num:C11(Substring:C12(vantw;1;$PosKomma-1)))
	vantw:=Substring:C12(vantw;$PosKomma+1)
	
	vantwJa:=String:C10(Num:C11(Substring:C12(vantw;1)))
	p_TelefonAvgFormatSetzen 
End if 