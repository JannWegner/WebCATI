//%attributes = {}
$xx:=[TelefonNummer:4]Variablenspeicher:49
$lauf:=0
While (Position:C15(",";$xx)#0)
	$lauf:=$lauf+1
	$xx:=Substring:C12($xx;Position:C15(",";$xx)+1)
End while 
$0:=$lauf
