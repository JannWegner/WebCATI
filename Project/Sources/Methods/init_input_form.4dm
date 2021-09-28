//%attributes = {}
If (generisch_if )
	vftext:=get_ftext 
	If (Position:C15("$$$";vftext)#0)
		vftext:=TextErsetzen (vftext)
	End if 
	
	  //vftext:=Replace string(vftext;"xxxtv01xxx";xxxtv01xxx)
	  //vftext:=Replace string(vftext;"xxxtv02xxx";xxxtv02xxx)
	  //vftext:=Replace string(vftext;"xxxtv03xxx";xxxtv03xxx)
	  //vftext:=Replace string(vftext;"xxxtv04xxx";xxxtv04xxx)
	  //vftext:=Replace string(vftext;"xxxtv05xxx";xxxtv05xxx)
	
	vavgtext:=get_avgtext 
	If (Position:C15("$$$";vavgtext)#0)
		vavgtext:=TextErsetzen (vavgtext)
	End if 
End if 
FORM SET INPUT:C55([TelefonNummer:4];get_ifnam )
