Case of 
	: (Form event code:C388=On Load:K2:1)
		vEnde:=[TelefonNummer:4]Ende am:25
		vDruck:=Current date:C33
	: (Form event code:C388=On Printing Detail:K2:18)
		vInhalt:=Replace string:C233(LiA (vDruckfeld);Char:C90(13);"  *|*  ")
	: (Form event code:C388=On Display Detail:K2:22)
		vInhalt:=Replace string:C233(LiA (vDruckfeld);Char:C90(13);"  *|*  ")
	: (Form event code:C388=On Printing Footer:K2:20)
		vSeitenzahlText:="Seite: "+String:C10(Printing page:C275)
End case 