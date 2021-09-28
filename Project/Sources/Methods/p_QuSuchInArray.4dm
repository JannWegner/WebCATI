//%attributes = {}
  //Sucht den passenden Topf
$viDimension:=$1
$vsSuchWert:=$2

$viItemNr:=0
$vbGefunden:=False:C215

Case of 
	: ($viDimension=1)
		$lauf:=Size of array:C274(asQuSuchOp1)
	: ($viDimension=2)
		$lauf:=Size of array:C274(asQuSuchOp2)
	: ($viDimension=3)
		$lauf:=Size of array:C274(asQuSuchOp3)
	: ($viDimension=4)
		$lauf:=Size of array:C274(asQuSuchOp4)
End case 


Repeat 
	Case of 
		: ($viDimension=1)
			Case of 
				: (asQuSuchOp1{$lauf}="=")
					If ($vsSuchWert=asQuSuchArg1{$lauf})
						$viItemNr:=asQuSuchItem1{$lauf}
						$vbGefunden:=True:C214
					End if 
				: (asQuSuchOp1{$lauf}=" ")
					  //Blank bei unbenutzer Dimension
				Else 
					ALERT:C41("p_QuSuchInArray:"+Char:C90(13)+"Operand "+asQuSuchOp1{$lauf}+" ist noch nicht definiert!")
			End case 
		: ($viDimension=2)
			Case of 
				: (asQuSuchOp2{$lauf}="=")
					If ($vsSuchWert=asQuSuchArg2{$lauf})
						$viItemNr:=asQuSuchItem2{$lauf}
						$vbGefunden:=True:C214
					End if 
				: (asQuSuchOp1{$lauf}=" ")
					  //Blank bei unbenutzer Dimension
				Else 
					ALERT:C41("p_QuSuchInArray:"+Char:C90(13)+"Operand "+asQuSuchOp2{$lauf}+" ist noch nicht definiert!")
					TRACE:C157
			End case 
		: ($viDimension=3)
			Case of 
				: (asQuSuchOp3{$lauf}="=")
					If ($vsSuchWert=asQuSuchArg3{$lauf})
						$viItemNr:=asQuSuchItem3{$lauf}
						$vbGefunden:=True:C214
					End if 
				: (asQuSuchOp1{$lauf}=" ")
					  //Blank bei unbenutzer Dimension
				Else 
					ALERT:C41("p_QuSuchInArray:"+Char:C90(13)+"Operand "+asQuSuchOp3{$lauf}+" ist noch nicht definiert!")
					TRACE:C157
			End case 
		: ($viDimension=4)
			Case of 
				: (asQuSuchOp4{$lauf}="=")
					If ($vsSuchWert=asQuSuchArg4{$lauf})
						$viItemNr:=asQuSuchItem4{$lauf}
						$vbGefunden:=True:C214
					End if 
				: (asQuSuchOp1{$lauf}=" ")
					  //Blank bei unbenutzer Dimension
				Else 
					ALERT:C41("p_QuSuchInArray:"+Char:C90(13)+"Operand "+asQuSuchOp4{$lauf}+" ist noch nicht definiert!")
					TRACE:C157
			End case 
	End case 
	$lauf:=$lauf-1
Until ($vbGefunden | ($lauf=0))

$0:=$viItemNr