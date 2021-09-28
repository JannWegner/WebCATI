Case of 
	: (Form event code:C388=On Load:K2:1)
		viSeite:=1
End case 

vUmfrDat:=vUmfrage+"  /  "+String:C10(Records in selection:C76([TelefonNummer:4]))+" Interviews"+"  /  "+String:C10(Current date:C33)+"  "+String:C10(Current time:C178)+"  /  Seite "+String:C10(viSeite)

If (Size of array:C274(atGA)>=((viSeite*2)-1))
	vtGA1:=atGA{(viSeite*2)-1}
Else 
	vtGA1:=""
End if 

If (Size of array:C274(atGA)>=(viSeite*2))
	vtGA2:=atGA{viSeite*2}
Else 
	vtGA2:=""
End if 
