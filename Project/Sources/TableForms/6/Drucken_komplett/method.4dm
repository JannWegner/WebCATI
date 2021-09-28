Case of 
	: (Form event code:C388=On Printing Detail:K2:18)
		vt_Text:="Frage: "+p_TextFormat ([Bogen:6]Fragenummer:2;"l";15)+"ID: "+p_TextFormat ([Bogen:6]ID:1;"l";20)+"NextID: "+p_TextFormat ([Bogen:6]nextID:6;"l";20)+"Spalte: "+p_TextFormat ([Bogen:6]Spalte:12;"l";8)+[Bogen:6]FormNam:8+" "+[Bogen:6]Halboffen:26+Char:C90(13)
		If (([Bogen:6]FormTyp:7#"bed") & ([Bogen:6]FormTyp:7#"do"))
			vt_Text:=vt_Text+"Werte: "+p_TextFormat ([Bogen:6]Filter_Eingabe:9;"l";20)+"Max. Anz.: "+p_TextFormat (String:C10([Bogen:6]MaxAnzEingabe:13);"l";7)
			vt_Text:=vt_Text+"Min: "+p_TextFormat ([Bogen:6]MinWert:16;"l";7)+"Max: "+p_TextFormat ([Bogen:6]MaxWert:17;"l";7)+"kkA: "+p_TextFormat ([Bogen:6]KKA:18;"l";7)+"Solo: "+p_TextFormat ([Bogen:6]Solo:19;"l";9)+"RndGrp: "+p_TextFormat ([Bogen:6]RandomGrp:28;"l";5)+Char:C90(13)
		End if 
		If ([Bogen:6]FText:3#"")
			vt_Text:=vt_Text+[Bogen:6]FText:3+Char:C90(13)
		End if 
		If ([Bogen:6]AvgText:5#"")
			vt_Text:=vt_Text+[Bogen:6]AvgText:5+Char:C90(13)
		End if 
		If ([Bogen:6]Bedingung:10#"")
			vt_Text:=vt_Text+[Bogen:6]Bedingung:10+Char:C90(13)
		End if 
End case 