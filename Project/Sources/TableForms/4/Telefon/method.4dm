Case of 
	: (Form event code:C388=On Load:K2:1)
		If (User in group:C338(Current user:C182;"Chef"))
			OBJECT SET VISIBLE:C603(*;"b_Fernsteuern";True:C214)
		Else 
			OBJECT SET VISIBLE:C603(*;"b_Fernsteuern";False:C215)
		End if 
		
		vakt_Teln:=[TelefonNummer:4]Telefon1:19
		vakt_AP:=[TelefonNummer:4]aktAnsprechp:38
		[TelefonNummer:4]StatusErklärung:11:=""
		vantw:=id2feld (".vs1_Telefon")
		GOTO OBJECT:C206(*;"vantw")
End case 