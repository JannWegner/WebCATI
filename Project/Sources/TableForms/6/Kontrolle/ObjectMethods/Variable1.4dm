Case of 
	: ((Form event code:C388=On Display Detail:K2:22) | (Form event code:C388=On Printing Detail:K2:18))
		Case of 
			: ([Bogen:6]Bedingung:10="")
				vFilter:=[Bogen:6]Filter_Eingabe:9+"  |--|   Anz.: "+String:C10([Bogen:6]MaxAnzEingabe:13)
			: (([Bogen:6]Bedingung:10="do_command") | ([Bogen:6]Bedingung:10="write@"))
				vFilter:=Substring:C12([Bogen:6]Bedingung:10+": "+[Bogen:6]FText:3;1;80)
			Else 
				vFilter:=Substring:C12([Bogen:6]Bedingung:10;1;80)
		End case 
		
End case 