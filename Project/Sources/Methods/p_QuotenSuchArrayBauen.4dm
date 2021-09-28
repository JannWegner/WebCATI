//%attributes = {}
  //Baut aus den Einträgen in TextDimX ein Suchfeld auf
ARRAY TEXT:C222(asQuSuchOp1;0)
ARRAY TEXT:C222(asQuSuchArg1;0)
ARRAY INTEGER:C220(asQuSuchItem1;0)

ARRAY TEXT:C222(asQuSuchOp2;0)
ARRAY TEXT:C222(asQuSuchArg2;0)
ARRAY INTEGER:C220(asQuSuchItem2;0)

ARRAY TEXT:C222(asQuSuchOp3;0)
ARRAY TEXT:C222(asQuSuchArg3;0)
ARRAY INTEGER:C220(asQuSuchItem3;0)

ARRAY TEXT:C222(asQuSuchOp4;0)
ARRAY TEXT:C222(asQuSuchArg4;0)
ARRAY INTEGER:C220(asQuSuchItem4;0)

$vtText:=Replace string:C233([Quoten:7]TextDim1:6;"|";",|")
$viBlock:=1
$viPositionSS:=Position:C15("|";$vtText)
While ($viPositionSS#0)
	$viPositionSS:=Position:C15("|";$vtText)
	$viPositionKomma:=Position:C15(",";$vtText)
	While (($viPositionKomma#0) & ($viPositionKomma<$viPositionSS))
		INSERT IN ARRAY:C227(asQuSuchOp1;1)
		INSERT IN ARRAY:C227(asQuSuchArg1;1)
		INSERT IN ARRAY:C227(asQuSuchItem1;1)
		asQuSuchOp1{1}:=Substring:C12($vtText;1;1)
		asQuSuchArg1{1}:=Substring:C12($vtText;2;$viPositionKomma-2)
		asQuSuchItem1{1}:=$viBlock
		
		$vtText:=Substring:C12($vtText;$viPositionKomma+1)
		
		$viPositionKomma:=Position:C15(",";$vtText)
		$viPositionSS:=Position:C15("|";$vtText)
	End while 
	$viBlock:=$viBlock+1
	$vtText:=Substring:C12($vtText;$viPositionSS+1)
	$viPositionSS:=Position:C15("|";$vtText)
End while 

$vtText:=Replace string:C233([Quoten:7]TextDim2:7;"|";",|")
$viBlock:=1
$viPositionSS:=Position:C15("|";$vtText)
While ($viPositionSS#0)
	$viPositionSS:=Position:C15("|";$vtText)
	$viPositionKomma:=Position:C15(",";$vtText)
	While (($viPositionKomma#0) & ($viPositionKomma<$viPositionSS))
		INSERT IN ARRAY:C227(asQuSuchOp2;1)
		INSERT IN ARRAY:C227(asQuSuchArg2;1)
		INSERT IN ARRAY:C227(asQuSuchItem2;1)
		asQuSuchOp2{1}:=Substring:C12($vtText;1;1)
		asQuSuchArg2{1}:=Substring:C12($vtText;2;$viPositionKomma-2)
		asQuSuchItem2{1}:=$viBlock
		
		$vtText:=Substring:C12($vtText;$viPositionKomma+1)
		
		$viPositionSS:=Position:C15("|";$vtText)
		$viPositionKomma:=Position:C15(",";$vtText)
	End while 
	$viBlock:=$viBlock+1
	$vtText:=Substring:C12($vtText;$viPositionSS+1)
	$viPositionKomma:=Position:C15(",";$vtText)
End while 

$vtText:=Replace string:C233([Quoten:7]TextDim3:8;"|";",|")
$viBlock:=1
$viPositionSS:=Position:C15("|";$vtText)
While ($viPositionSS#0)
	$viPositionSS:=Position:C15("|";$vtText)
	$viPositionKomma:=Position:C15(",";$vtText)
	While (($viPositionKomma#0) & ($viPositionKomma<$viPositionSS))
		INSERT IN ARRAY:C227(asQuSuchOp3;1)
		INSERT IN ARRAY:C227(asQuSuchArg3;1)
		INSERT IN ARRAY:C227(asQuSuchItem3;1)
		asQuSuchOp3{1}:=Substring:C12($vtText;1;1)
		asQuSuchArg3{1}:=Substring:C12($vtText;2;$viPositionKomma-2)
		asQuSuchItem3{1}:=$viBlock
		
		$vtText:=Substring:C12($vtText;$viPositionKomma+1)
		
		$viPositionSS:=Position:C15("|";$vtText)
		$viPositionKomma:=Position:C15(",";$vtText)
	End while 
	$viBlock:=$viBlock+1
	$vtText:=Substring:C12($vtText;$viPositionSS+1)
	$viPositionKomma:=Position:C15(",";$vtText)
End while 

$vtText:=Replace string:C233([Quoten:7]TextDim4:9;"|";",|")
$viBlock:=1
$viPositionSS:=Position:C15("|";$vtText)
While ($viPositionSS#0)
	$viPositionSS:=Position:C15("|";$vtText)
	$viPositionKomma:=Position:C15(",";$vtText)
	While (($viPositionKomma#0) & ($viPositionKomma<$viPositionSS))
		INSERT IN ARRAY:C227(asQuSuchOp4;1)
		INSERT IN ARRAY:C227(asQuSuchArg4;1)
		INSERT IN ARRAY:C227(asQuSuchItem4;1)
		asQuSuchOp4{1}:=Substring:C12($vtText;1;1)
		asQuSuchArg4{1}:=Substring:C12($vtText;2;$viPositionKomma-2)
		asQuSuchItem4{1}:=$viBlock
		
		$vtText:=Substring:C12($vtText;$viPositionKomma+1)
		
		$viPositionSS:=Position:C15("|";$vtText)
		$viPositionKomma:=Position:C15(",";$vtText)
	End while 
	$viBlock:=$viBlock+1
	$vtText:=Substring:C12($vtText;$viPositionSS+1)
	$viPositionKomma:=Position:C15(",";$vtText)
End while 

