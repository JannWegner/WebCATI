
  //Daten werden in Layout-Prozedur Bevor-Phase gesetzt
If ([TelefonNummer:4]Status:5="Ausfall")
	[TelefonNummer:4]Historie:4:=String:C10(Current date:C33)+"/"+String:C10(Current time:C178)+" * "+vName+" * Ausfall/"+[TelefonNummer:4]StatusErklärung:11+Char:C90(13)+[TelefonNummer:4]Historie:4
Else 
	
End if 
sichere_DS (Table:C252(->[TelefonNummer:4]);DEBUG)
EinsZurueck:=weitermit
EndeNummer:=True:C214
