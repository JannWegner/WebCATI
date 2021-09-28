//%attributes = {}
  //str2anz gibt zurück wie oft ein String in einem zweiten vorkommt

  //$1 ist der zu suchende String

  //$2 ist der String in dem gesucht wird


C_TEXT:C284($1)
C_TEXT:C284($2)

If ((Length:C16($1)=0) | (Length:C16($2)=0))
	$0:=0
Else 
	$anz:=0
	$durchsuchter:=$2
	$länge:=Length:C16($1)
	
	While (Position:C15($1;$durchsuchter)>0)
		$anz:=$anz+1
		$pos:=Position:C15($1;$durchsuchter)
		$durchsuchter:=Substring:C12($durchsuchter;$pos+$länge)
	End while 
	$0:=$anz
End if 