Case of 
	: (Form event code:C388=On Data Change:K2:15)
		Case of 
			: ([Bogen:6]ID:1="@-bed")
				GOTO OBJECT:C206([Bogen:6]Bedingung:10)
				[Bogen:6]FormTyp:7:="bed"
				If ([Bogen:6]Bedingung:10="")
					[Bogen:6]Bedingung:10:="ex_res:=sswenn()"
				End if 
				[Bogen:6]nextID:6:=""
			: ([Bogen:6]ID:1="@-do")
				GOTO OBJECT:C206([Bogen:6]Bedingung:10)
				[Bogen:6]FormTyp:7:="do"
		End case 
End case 