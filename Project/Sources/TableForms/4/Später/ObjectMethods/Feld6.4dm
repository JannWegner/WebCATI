$viStunde:=Num:C11(Substring:C12(String:C10([TelefonNummer:4]WiederUm:3);1;Position:C15(":";String:C10([TelefonNummer:4]WiederUm:3))))
If (($viStunde<0) | ($viStunde>23))
	ALERT:C41("Stundenangaben bitte nur von 0 bis 23!")
	GOTO OBJECT:C206([TelefonNummer:4]WiederUm:3)
End if 