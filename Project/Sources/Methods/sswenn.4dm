//%attributes = {}
  //Spread Sheet WENN

C_TEXT:C284($0;$2;$3)
C_BOOLEAN:C305($1)

$Bedingung:=$1
$AntwPos:=$2
$AntNeg:=$3


If ($Bedingung)
	$0:=$AntwPos
Else 
	$0:=$AntNeg
End if 
