If (Form event code:C388=On Load:K2:1)
	  //Antwortvorgaben zerlegen
	p_Multi_inArray ([Bogen:6]AvgText:5)
	
	OBJECT SET VISIBLE:C603(*;"v@Multi1";as_MultiLabel{1}#"")
	OBJECT SET VISIBLE:C603(*;"v@Multi2";as_MultiLabel{2}#"")
	OBJECT SET VISIBLE:C603(*;"v@Multi3";as_MultiLabel{3}#"")
	OBJECT SET VISIBLE:C603(*;"v@Multi4";as_MultiLabel{4}#"")
	OBJECT SET VISIBLE:C603(*;"v@Multi5";as_MultiLabel{5}#"")
	OBJECT SET VISIBLE:C603(*;"v@Multi6";as_MultiLabel{6}#"")
	
	vLabelMulti1:=as_MultiLabel{1}+" ("+String:C10(ai_MultiMin{1})+"-"+String:C10(ai_MultiMax{1})+((" *|* KKA="+String:C10(ai_MultikkA{1}))*(Num:C11(ai_MultikkA{1}#-9)))+")"
	vLabelMulti2:=as_MultiLabel{2}+" ("+String:C10(ai_MultiMin{2})+"-"+String:C10(ai_MultiMax{2})+((" *|* KKA="+String:C10(ai_MultikkA{2}))*(Num:C11(ai_MultikkA{2}#-9)))+")"
	vLabelMulti3:=as_MultiLabel{3}+" ("+String:C10(ai_MultiMin{3})+"-"+String:C10(ai_MultiMax{3})+((" *|* KKA="+String:C10(ai_MultikkA{3}))*(Num:C11(ai_MultikkA{3}#-9)))+")"
	vLabelMulti4:=as_MultiLabel{4}+" ("+String:C10(ai_MultiMin{4})+"-"+String:C10(ai_MultiMax{4})+((" *|* KKA="+String:C10(ai_MultikkA{4}))*(Num:C11(ai_MultikkA{4}#-9)))+")"
	vLabelMulti5:=as_MultiLabel{5}+" ("+String:C10(ai_MultiMin{5})+"-"+String:C10(ai_MultiMax{5})+((" *|* KKA="+String:C10(ai_MultikkA{5}))*(Num:C11(ai_MultikkA{5}#-9)))+")"
	vLabelMulti6:=as_MultiLabel{6}+" ("+String:C10(ai_MultiMin{6})+"-"+String:C10(ai_MultiMax{6})+((" *|* KKA="+String:C10(ai_MultikkA{6}))*(Num:C11(ai_MultikkA{6}#-9)))+")"
	
	OBJECT SET FILTER:C235(vantwMulti1;"&9"+("#"*ai_MultiLaenge{1}))
	OBJECT SET FILTER:C235(vantwMulti2;"&9"+("#"*ai_MultiLaenge{2}))
	OBJECT SET FILTER:C235(vantwMulti3;"&9"+("#"*ai_MultiLaenge{3}))
	OBJECT SET FILTER:C235(vantwMulti4;"&9"+("#"*ai_MultiLaenge{4}))
	OBJECT SET FILTER:C235(vantwMulti5;"&9"+("#"*ai_MultiLaenge{5}))
	OBJECT SET FILTER:C235(vantwMulti6;"&9"+("#"*ai_MultiLaenge{6}))
	
	vantw:=id2feld (weitermit)
	
	$PosKomma:=Position:C15(",";vantw)
	vantwMulti1:=String:C10(Num:C11(Substring:C12(vantw;1;$PosKomma-1)))
	vantw:=Substring:C12(vantw;$PosKomma+1)
	
	$PosKomma:=Position:C15(",";vantw)
	vantwMulti2:=String:C10(Num:C11(Substring:C12(vantw;1;$PosKomma-1)))
	vantw:=Substring:C12(vantw;$PosKomma+1)
	
	$PosKomma:=Position:C15(",";vantw)
	vantwMulti3:=String:C10(Num:C11(Substring:C12(vantw;1;$PosKomma-1)))
	vantw:=Substring:C12(vantw;$PosKomma+1)
	
	$PosKomma:=Position:C15(",";vantw)
	vantwMulti4:=String:C10(Num:C11(Substring:C12(vantw;1;$PosKomma-1)))
	vantw:=Substring:C12(vantw;$PosKomma+1)
	
	$PosKomma:=Position:C15(",";vantw)
	vantwMulti5:=String:C10(Num:C11(Substring:C12(vantw;1;$PosKomma-1)))
	vantw:=Substring:C12(vantw;$PosKomma+1)
	
	  //$PosKomma:=Position(",";vantw)
	vantwMulti6:=String:C10(Num:C11(Substring:C12(vantw;1)))
	
	p_TelefonAvgFormatSetzen 
	
	GOTO OBJECT:C206(*;"vantwMulti1")
End if 